using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3_Application
{
    public partial class RemoveHoliday : System.Web.UI.Page
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

                string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ToString();

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand removeHolidayProc = new SqlCommand("Remove_Holiday", conn);
                    removeHolidayProc.CommandType = System.Data.CommandType.StoredProcedure;

                    conn.Open();
                    int rowsAffected = removeHolidayProc.ExecuteNonQuery();

                    // Show result message
                    if (rowsAffected > 0)
                    {
                        lblMessage.Text = $"Successfully removed {rowsAffected} attendance records that occurred during holidays.";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                    }
                    else
                    {
                        lblMessage.Text = "No attendance records found during holidays or no changes were made.";
                        lblMessage.ForeColor = System.Drawing.Color.Blue;
                    }
                }
            }
            catch (SqlException sqlEx)
            {
                lblMessage.Text = "Database Error: " + sqlEx.Message;
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