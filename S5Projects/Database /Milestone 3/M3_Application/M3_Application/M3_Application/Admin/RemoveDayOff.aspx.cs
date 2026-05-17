using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3_Application
{
    public partial class RemoveDayOff : System.Web.UI.Page
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
                if (string.IsNullOrEmpty(employee_id.Text))
                {
                    lblMessage.Text = "Please enter an employee ID.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ToString();

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    int id;
                    if (!int.TryParse(employee_id.Text, out id))
                    {
                        lblMessage.Text = "Invalid employee ID. Please enter a valid number.";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        return;
                    }

                    SqlCommand removeDayOffProc = new SqlCommand("Remove_DayOff", conn);
                    removeDayOffProc.CommandType = System.Data.CommandType.StoredProcedure;
                    removeDayOffProc.Parameters.AddWithValue("@Employee_id", id);

                    conn.Open();
                    int rowsAffected = removeDayOffProc.ExecuteNonQuery();

                    // Show result message
                    if (rowsAffected > 0)
                    {
                        lblMessage.Text = $"Successfully removed {rowsAffected} day-off absent records for the current month.";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                    }
                    else
                    {
                        lblMessage.Text = "No matching day-off records found for the current month or no changes were made.";
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