<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginChoice.aspx.cs" Inherits="M3_Application.LoginChoice" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Choose Login Type</title>
    <style>
        body {
            background: #f2f2f2;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        
        .container {
            width: 400px;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.15);
            text-align: center;
        }
        
        h1 {
            color: #333;
            margin-bottom: 30px;
            font-size: 24px;
        }
        
        .login-btn {
            width: 100%;
            padding: 15px;
            margin-bottom: 15px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            color: white;
            display: block;
        }
        
        .hr-btn {
            background: #4a76a8;
        }
        
        .hr-btn:hover {
            background: #3a5c82;
            transform: translateY(-2px);
        }
        
        .admin-btn {
            background: #5cb85c;
        }
        
        .admin-btn:hover {
            background: #449d44;
            transform: translateY(-2px);
        }
        
        .academic-btn {
            background: #f0ad4e;
        }
        
        .academic-btn:hover {
            background: #ec971f;
            transform: translateY(-2px);
        }
        
        .btn-icon {
            margin-right: 10px;
            font-size: 18px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>Welcome to the University System</h1>
            <p style="color: #666; margin-bottom: 30px;">Please choose your login type:</p>
            
            <asp:Button ID="btnHR" runat="server" Text="👥 HR Employee Login" 
                CssClass="login-btn hr-btn" OnClick="btnHR_Click" />
            
            <asp:Button ID="btnAdmin" runat="server" Text="⚙️ Admin Login" 
                CssClass="login-btn admin-btn" OnClick="btnAdmin_Click" />
            
            <asp:Button ID="btnAcademic" runat="server" Text="🎓 Academic Employee Login" 
                CssClass="login-btn academic-btn" OnClick="btnAcademic_Click" />
        </div>
    </form>
</body>
</html>