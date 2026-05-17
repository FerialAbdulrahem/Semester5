using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3_Application
{
    public partial class ReplaceEmployee : System.Web.UI.Page
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

                // Validate all inputs
                if (string.IsNullOrEmpty(ID.Text) || string.IsNullOrEmpty(otherID.Text) ||
                    string.IsNullOrEmpty(start.Text) || string.IsNullOrEmpty(end.Text))
                {
                    lblMessage.Text = "Please fill in all fields.";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return;
                }

                string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ToString();

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    // Parse inputs
                    int emp1ID, emp2ID;
                    DateTime fromDate, toDate;

                    if (!int.TryParse(ID.Text, out emp1ID))
                    {
                        lblMessage.Text = "Invalid Employee 1 ID. Please enter a valid number.";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        return;
                    }

                    if (!int.TryParse(otherID.Text, out emp2ID))
                    {
                        lblMessage.Text = "Invalid Employee 2 ID. Please enter a valid number.";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        return;
                    }

                    if (!DateTime.TryParse(start.Text, out fromDate))
                    {
                        lblMessage.Text = "Invalid start date format. Please use YYYY-MM-DD format.";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        return;
                    }

                    if (!DateTime.TryParse(end.Text, out toDate))
                    {
                        lblMessage.Text = "Invalid end date format. Please use YYYY-MM-DD format.";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        return;
                    }

                    // Validate date range
                    if (fromDate > toDate)
                    {
                        lblMessage.Text = "Start date cannot be after end date.";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        return;
                    }

                    // Check if it's the same employee
                    if (emp1ID == emp2ID)
                    {
                        lblMessage.Text = "Cannot replace an employee with themselves.";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        return;
                    }

                    SqlCommand replaceProc = new SqlCommand("Replace_employee", conn);
                    replaceProc.CommandType = System.Data.CommandType.StoredProcedure;
                    replaceProc.Parameters.AddWithValue("@Emp1_ID", emp1ID);
                    replaceProc.Parameters.AddWithValue("@Emp2_ID", emp2ID);
                    replaceProc.Parameters.AddWithValue("@from_date", fromDate);
                    replaceProc.Parameters.AddWithValue("@to_date", toDate);

                    conn.Open();
                    int rowsAffected = replaceProc.ExecuteNonQuery();

                    // Show result message
                    if (rowsAffected > 0)
                    {
                        lblMessage.Text = $"Successfully replaced Employee {emp2ID} with Employee {emp1ID} from {fromDate.ToShortDateString()} to {toDate.ToShortDateString()}.";
                        lblMessage.ForeColor = System.Drawing.Color.Green;

                        // Clear form after successful submission
                        ClearForm();
                    }
                    else
                    {
                        lblMessage.Text = "Employee replacement record could not be created.";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
            catch (SqlException sqlEx)
            {
                // Check for specific SQL errors
                if (sqlEx.Number == 2627) // Primary key violation
                {
                    lblMessage.Text = "Error: A replacement record for these employees and dates already exists.";
                }
                else if (sqlEx.Number == 547) // Foreign key violation
                {
                    lblMessage.Text = "Error: One or both employee IDs do not exist in the system.";
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

        private void ClearForm()
        {
            ID.Text = "";
            otherID.Text = "";
            start.Text = "";
            end.Text = "";
        }
    }
}