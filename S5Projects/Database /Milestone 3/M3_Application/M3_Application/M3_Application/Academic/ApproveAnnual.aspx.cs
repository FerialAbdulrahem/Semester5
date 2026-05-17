using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace M3_Application
{
    public partial class ApproveAnnual : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblMessage.Text = "";
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            int requestID, upperBoardID, replacementID;

            // Validate Request ID
            if (!int.TryParse(TextBox1.Text.Trim(), out requestID))
            {
                lblMessage.Text = "Invalid Request ID";
                return;
            }

            // Validate UpperBoard ID
            if (!int.TryParse(TextBox2.Text.Trim(), out upperBoardID))
            {
                lblMessage.Text = "Invalid UpperBoard ID";
                return;
            }

            // Validate Replacement ID
            if (!int.TryParse(TextBox3.Text.Trim(), out replacementID))
            {
                lblMessage.Text = "Invalid Replacement ID";
                return;
            }

            string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand("Upperboard_approve_annual", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@request_ID", requestID);
                    cmd.Parameters.AddWithValue("@Upperboard_ID", upperBoardID);
                    cmd.Parameters.AddWithValue("@replacement_ID", replacementID);

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();

                        lblMessage.ForeColor = System.Drawing.Color.Green;
                        lblMessage.Text = "Decision submitted successfully.";
                    }
                    catch (SqlException ex)
                    {
                        lblMessage.Text = "SQL Error: " + ex.Message;
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
