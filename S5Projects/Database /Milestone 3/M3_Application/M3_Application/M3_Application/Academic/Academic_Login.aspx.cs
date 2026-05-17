using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing.Printing;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3_Application
{
    public partial class Academic_Login : System.Web.UI.Page
    {
        
        protected void login(object sender, EventArgs e)
        {

            Error.Visible = false;
            Error.Text = "";

            if (!int.TryParse(ID.Text, out int id))
            {
                Error.Text = "Please enter a valid Employee ID";
                Error.Visible = true;
                return;
            }

            string pass = Password.Text;
            string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // For a scalar function, use SELECT statement
                SqlCommand cmd = new SqlCommand("SELECT dbo.EmployeeLoginValidation(@employee_ID, @password)", conn);
                // NOT CommandType.StoredProcedure - it's a function call

                cmd.Parameters.AddWithValue("@employee_ID", id);
                cmd.Parameters.AddWithValue("@password", pass);

                conn.Open();

                // ExecuteScalar returns the first column of the first row
                object result = cmd.ExecuteScalar();

                // Check if result is not null and convert to bool
                if (result != null && result != DBNull.Value)
                {
                    bool isValid = (bool)result;

                    if (isValid)
                    {
                        Session["EmployeeID"] = id;
                        Response.Redirect("~/Academic/DashBoard.aspx");
                    }
                    else
                    {
                        Error.Text = "Invalid credentials";
                        Error.Visible = true;
                    }
                }
                else
                {
                    Error.Text = "Login failed - no result returned";
                    Error.Visible = true;
                }
            }
        }
    }
}


//        Error.Visible = false;


//                string connString = WebConfigurationManager
//                    .ConnectionStrings["MyDatabaseConnection"].ConnectionString;

//        SqlConnection conn = new SqlConnection(connString);

//        int id = Int32.Parse(ID.Text);
//        string pass = Password.Text;

//        SqlCommand loginfun = new SqlCommand(
//            "SELECT dbo.EmployeeLoginValidation(@employee_ID, @password)", conn);

//        loginfun.Parameters.Add(new SqlParameter("@employee_ID", id));
//                loginfun.Parameters.Add(new SqlParameter("@password", pass));

//                conn.Open();
//                object result = loginfun.ExecuteScalar();
//                //conn.Close();
//                // Console.WriteLine(123);
//                if (result != null && result != DBNull.Value)
//                {
//                    bool isValid = (bool)result;

//                    if (isValid)
//                    {
//                        Session["EmployeeID"] = id;
//                        Response.Redirect("DashBoard.aspx");
//                    }
//                    else
//                    {
//                        Error.Text = "Invalid credentials";
//                    }
//                }
//                else
//{
//    Error.Text = "Login failed - no result returned";
//}
//            }
//    }
//}



//string connString = WebConfigurationManager
//.ConnectionStrings["MyDatabaseConnection"].ConnectionString;
//SqlConnection conn = new SqlConnection(connString);
//int id = Int32.Parse(ID.Text);
//String pass= Password.Text;

//SqlCommand loginfun = new SqlCommand("select dbo.EmployeeLoginValidation(@employee_ID, @password)", conn); 
//loginfun.Parameters.Add(new SqlParameter("@employee_ID", id));
//loginfun.Parameters.Add(new SqlParameter("@password", pass));
// SqlParameter success = loginfun.Parameters.Add("@success", SqlDbType.Int);
//  success.Direction = ParameterDirection.Output;
//        conn.Open();
//        object success = loginfun.ExecuteScalar();
//        conn.Close();
//        if(success.ToString()=="1")
//        {
//            Session["AcademicEmployeeID"] = id;
//            Response.Write("Hello");
//            Response.Redirect("DashBoard.aspx");
//        }
//        else
//        {
//            Error.Text = "Invalid";
//        }
//    }
//}
