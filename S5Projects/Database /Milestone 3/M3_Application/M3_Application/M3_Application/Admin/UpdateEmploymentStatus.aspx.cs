using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3_Application
{
    public partial class UpdateEmploymentStatus : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                // Clear any previous messages
                lblMessage.Text = "";

                // Validate input
                if (string.IsNullOrEmpty(ID.Text))
                {
                    lblMessage.Text = "Please enter an employee ID.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ToString();

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    int employeeId;
                    if (!int.TryParse(ID.Text, out employeeId))
                    {
                        lblMessage.Text = "Invalid employee ID. Please enter a valid number.";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        return;
                    }

                    // Execute the stored procedure
                    SqlCommand updateProc = new SqlCommand("Update_Employment_Status", conn);
                    updateProc.CommandType = System.Data.CommandType.StoredProcedure;
                    updateProc.Parameters.AddWithValue("@Employee_ID", employeeId);

                    conn.Open();
                    int rowsAffected = updateProc.ExecuteNonQuery();

                    // Show result message
                    if (rowsAffected > 0)
                    {
                        lblMessage.Text = $"Successfully updated employment status for Employee ID {employeeId}.";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                    }
                    else
                    {
                        lblMessage.Text = $"Employee ID {employeeId} not found or status already up to date.";
                        lblMessage.ForeColor = System.Drawing.Color.Blue;
                    }
                }
            }
            catch (SqlException sqlEx)
            {
                // Handle specific SQL errors
                if (sqlEx.Message.Contains("function") && sqlEx.Message.Contains("Is_On_Leave"))
                {
                    lblMessage.Text = "Error: The Is_On_Leave function is not available. Please make sure the database function exists.";
                }
                else
                {
                    lblMessage.Text = "Database Error: " + sqlEx.Message;
                }
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}