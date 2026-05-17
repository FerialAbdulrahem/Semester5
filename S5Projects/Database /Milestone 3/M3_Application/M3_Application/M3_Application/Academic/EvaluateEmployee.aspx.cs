using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace M3_Application
{
    public partial class EvaluateEmployee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblMessage.Text = "";
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            // Get input values
            int employeeID;
            int rating;
            string comment = TextBox3.Text.Trim();
            string semester = TextBox4.Text.Trim();

            // Validate numeric inputs
            if (!int.TryParse(TextBox1.Text.Trim(), out employeeID))
            {
                lblMessage.Text = "Invalid Employee ID.";
                return;
            }

            if (!int.TryParse(TextBox2.Text.Trim(), out rating))
            {
                lblMessage.Text = "Invalid rating.";
                return;
            }

            // Optional: validate comment and semester length
            if (comment.Length > 50)
            {
                lblMessage.Text = "Comment cannot exceed 50 characters.";
                return;
            }

            if (semester.Length != 3)
            {
                lblMessage.Text = "Semester must be 3 characters (e.g., 'Fall', 'Spr').";
                return;
            }

            // Execute stored procedure
            string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand("Dean_andHR_Evaluation", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@employee_ID", employeeID);
                    cmd.Parameters.AddWithValue("@rating", rating);
                    cmd.Parameters.AddWithValue("@comment", comment);
                    cmd.Parameters.AddWithValue("@semester", semester);

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                        lblMessage.Text = "Employee evaluated successfully.";
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = "Error: " + ex.Message;
                    }
                }
            }
        }
    }
}
