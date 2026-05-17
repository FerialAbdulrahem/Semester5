var express = require('express');
var path = require('path');
var app = express();
var MongoClient = require('mongodb').MongoClient;

let db, usersCollection;
let mongoMessage = '';

// Connect to MongoDB
async function connectDB() {
    try {
        const client = new MongoClient('mongodb://127.0.0.1:27017', {
            serverSelectionTimeoutMS: 3000
        });
        await client.connect();
        console.log("Connected to MongoDB");
        
        db = client.db('myDB');
        usersCollection = db.collection('users');
        
        // Create index to ensure unique usernames
        await usersCollection.createIndex({ username: 1 }, { unique: true });
        
    } catch (error) {
        console.log("MongoDB connection error:", error.message);
    }
}

connectDB();

// Setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, 'public')));

// Simple storage
let savedDestinations = [];

// Destinations data
const destinations = [
    { id: 1, name: "Annapurna Circuit", page: "annapurna" },
    { id: 2, name: "Inca Trail to Machu Picchu", page: "inca" },
    { id: 3, name: "Paris", page: "paris" },
    { id: 4, name: "Rome", page: "rome" },
    { id: 5, name: "Bali", page: "bali" },
    { id: 6, name: "Santorini", page: "santorini" }
];

// ========== ROUTES ==========

// Login
app.get('/', function(req, res) {
    res.render('login', { mongoMessage: mongoMessage });
});

app.post('/', async function(req, res) {
    var username = req.body.username ? req.body.username.trim() : '';
    var password = req.body.password ? req.body.password.trim() : '';
    
    // Check if fields are empty
    if (!username || !password) {
        mongoMessage = 'Login failed: Empty username or password';
        console.log(mongoMessage);
        res.redirect('/');
        return;
    }
    
    try {
        // Check if user exists in MongoDB
        const user = await usersCollection.findOne({ username: username, password: password });
        
        if (user) {
            console.log("Login successful for:", username);
            res.redirect('/home');
        } else {
            // Try to register new user
            try {
                const result = await usersCollection.insertOne({
                    username: username, 
                    password: password,
                    timestamp: new Date()
                });
                mongoMessage = `New user "${username}" registered successfully!`;
                console.log(mongoMessage);
                res.redirect('/home');
            } catch (insertError) {
                if (insertError.code === 11000) { // Duplicate key error
                    mongoMessage = `Username "${username}" already exists. Try a different username.`;
                    console.log(mongoMessage);
                    res.redirect('/');
                } else {
                    mongoMessage = `Registration error: ${insertError.message}`;
                    console.log(mongoMessage);
                    res.redirect('/');
                }
            }
        }
        
    } catch (error) {
        mongoMessage = `Database error: ${error.message}`;
        console.log(mongoMessage);
        res.redirect('/');
    }
});

// Registration page
app.get('/registration', function(req, res) {
    res.render('registration', { mongoMessage: mongoMessage });
});

app.post('/registration', async function(req, res) {
    var username = req.body.username ? req.body.username.trim() : '';
    var password = req.body.password ? req.body.password.trim() : '';
    
    if (!username || !password) {
        mongoMessage = 'Registration failed: Empty username or password';
        console.log(mongoMessage);
        res.redirect('/registration');
        return;
    }
    
    try {
        const result = await usersCollection.insertOne({
            username: username, 
            password: password,
            timestamp: new Date()
        });
        mongoMessage = `User "${username}" registered successfully!`;
        console.log(mongoMessage);
        res.redirect('/');
        
    } catch (error) {
        if (error.code === 11000) {
            mongoMessage = `Username "${username}" already exists. Please choose another.`;
        } else {
            mongoMessage = `Registration error: ${error.message}`;
        }
        console.log(mongoMessage);
        res.redirect('/registration');
    }
});

// Pages (all other routes remain the same)
app.get('/home', function(req, res) {
    res.render('home', { mongoMessage: mongoMessage });
});

app.get('/hiking', function(req, res) {
    res.render('hiking');
});

app.get('/cities', function(req, res) {
    res.render('cities');
});

app.get('/islands', function(req, res) {
    res.render('islands');
});

app.get('/bali', function(req, res) {
    res.render('bali');
});

app.get('/santorini', function(req, res) {
    res.render('santorini');
});

app.get('/inca', function(req, res) {
    res.render('inca');
});

app.get('/paris', function(req, res) {
    res.render('paris');
});

app.get('/rome', function(req, res) {
    res.render('rome');
});

app.get('/annapurna', function(req, res) {
    res.render('annapurna');
});

// Want-to-go list
app.post('/add-to-list', function(req, res) {
    const placeName = req.body.destinationName;
    console.log("Saved:", placeName);
    savedDestinations.push(placeName);
    res.redirect('back');
});

app.get('/wanttogo', function(req, res) {
    res.render('wanttogo', {
        places: savedDestinations
    });
});

// ========== SEARCH ROUTE ==========
app.post('/search', function(req, res) {
    const searchTerm = req.body.Search.toLowerCase().trim();
    
    console.log("Searching for:", searchTerm);
    
    const results = destinations.filter(dest => 
        dest.name.toLowerCase().includes(searchTerm)
    );
    
    if (results.length > 0) {
        if (results.length === 1) {
            res.redirect('/' + results[0].page);
        } else {
            res.send(`
                <!DOCTYPE html>
                <html>
                <head>
                    <title>Search Results</title>
                    <style>
                        body { background: #f5f5f5; padding: 20px; }
                        .result { background: white; padding: 15px; margin: 10px; border-radius: 5px; }
                    </style>
                </head>
                <body>
                    <h1>Search Results for "${searchTerm}"</h1>
                    ${results.map(dest => `
                        <div class="result">
                            <h3>${dest.name}</h3>
                            <a href="/${dest.page}">Go to Page</a>
                        </div>
                    `).join('')}
                    <br>
                    <a href="/home">← Back to Home</a>
                </body>
                </html>
            `);
        }
    } else {
        res.send(`
            <!DOCTYPE html>
            <html>
            <head>
                <title>Not Found</title>
            </head>
            <body>
                <h1>Destination not Found</h1>
                <p>No destinations found for "${searchTerm}"</p>
                <a href="/home">← Back to Home</a>
            </body>
            </html>
        `);
    }
});

app.listen(3000, function() {
    console.log("Server started on http://localhost:3000");
});