using System;
using System.Data;
using System.Data.SqlClient;
using System.Runtime.InteropServices.ComTypes;
using System.Security.Cryptography;
using System.Web.Configuration;
using System.Web.UI;

namespace M3_Application
{
    public partial class ApplyUnpaidLeave : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void Apply_Click(object sender, EventArgs e)
        {
            // 1. Validate inputs
            if (string.IsNullOrWhiteSpace(id.Text))
            {
                Response.Write("Please insert your Employee ID");
                return;
            }
            if (string.IsNullOrWhiteSpace(StartDate.Text))
            {
                Response.Write("Please insert start date");
                return;
            }
            if (string.IsNullOrWhiteSpace(EndDate.Text))
            {
                Response.Write("Please insert end date");
                return;
            }
            if (string.IsNullOrWhiteSpace(desc.Text))
            {
                Response.Write("Please insert document description");
                return;
            }
            if (string.IsNullOrWhiteSpace(file.Text))
            {
                Response.Write("Please insert file name");
                return;
            }

            // 2. Parse inputs
            if (!int.TryParse(id.Text, out int empID))
            {
                Response.Write("Employee ID must be a number.");
                return;
            }
            if (!DateTime.TryParse(StartDate.Text, out DateTime startDate))
            {
                Response.Write("Start date is invalid.");
                return;
            }
            if (!DateTime.TryParse(EndDate.Text, out DateTime endDate))
            {
                Response.Write("End date is invalid.");
                return;
            }
            if (startDate > endDate)
            {
                Response.Write("Start date cannot be after end date.");
                return;
            }

            // 3. Submit to database
            var cs = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"];
            if (cs == null)
            {
                Response.Write("Connection string 'Fahmy' not found.");
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(cs.ConnectionString))
                {
                    SqlCommand UnpaidLeave = new SqlCommand("Submit_unpaid", conn);
                    UnpaidLeave.CommandType = CommandType.StoredProcedure;

                    UnpaidLeave.Parameters.Add(new SqlParameter("@employee_ID", empID));
                    UnpaidLeave.Parameters.Add(new SqlParameter("@start_date", startDate));
                    UnpaidLeave.Parameters.Add(new SqlParameter("@end_date", endDate));
                    UnpaidLeave.Parameters.Add(new SqlParameter("@document_description", desc.Text));
                    UnpaidLeave.Parameters.Add(new SqlParameter("@file_name", file.Text));

                    conn.Open();
                    UnpaidLeave.ExecuteNonQuery();
                }

                Response.Write("Unpaid leave applied successfully");
            }
            catch (Exception ex)
            {
                Response.Write("Database error: " + ex.Message);
            }
        }
    }
}
