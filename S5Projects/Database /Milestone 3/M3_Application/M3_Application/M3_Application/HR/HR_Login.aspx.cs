using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace M3_Application {
public partial class HR_Login : System.Web.UI.Page
{
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(txtID.Text, out int id))
            {
                lblMessage.Text = "Please enter a valid Employee ID";
                return;
            }

            string pass = txtpassword.Text;
            string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // For a scalar function, use SELECT statement
                SqlCommand cmd = new SqlCommand("SELECT dbo.HRLoginValidation(@employee_ID, @password)", conn);
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
                        Session["HRid"] = id;
                        Response.Redirect("~/HR/HR_Home.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Invalid credentials";
                    }
                }
                else
                {
                    lblMessage.Text = "Login failed - no result returned";
                }
            }
        }
    }
}
