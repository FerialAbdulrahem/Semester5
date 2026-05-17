using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;

namespace M3_Application
{
    public partial class ApplyCompensationLeave : System.Web.UI.Page
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
            if (string.IsNullOrWhiteSpace(compDate.Text))
            {
                Response.Write("Please insert compensation date");
                return;
            }
            if (string.IsNullOrWhiteSpace(originalDate.Text))
            {
                Response.Write("Please insert the date of original workday");
                return;
            }
            if (string.IsNullOrWhiteSpace(reason.Text))
            {
                Response.Write("Please insert the reason");
                return;
            }
            if (string.IsNullOrWhiteSpace(repEmpID.Text))
            {
                Response.Write("Please insert replacement Employee ID");
                return;
            }

            // 2. Parse inputs
            if (!int.TryParse(id.Text, out int empID))
            {
                Response.Write("Employee ID must be a number.");
                return;
            }
            if (!DateTime.TryParse(compDate.Text, out DateTime compensationDate))
            {
                Response.Write("Compensation date is invalid.");
                return;
            }
            if (!DateTime.TryParse(originalDate.Text, out DateTime originalWorkday))
            {
                Response.Write("Original workday date is invalid.");
                return;
            }
            if (!int.TryParse(repEmpID.Text, out int replacementEmpID))
            {
                Response.Write("Replacement Employee ID must be a number.");
                return;
            }

            // 3. Submit to database
            var cs = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"];
            if (cs == null)
            {
                Response.Write("Connection string 'MyDatabaseConnection' not found.");
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(cs.ConnectionString))
                {
                    SqlCommand CompensationLeave = new SqlCommand("Submit_compensation", conn);
                    CompensationLeave.CommandType = CommandType.StoredProcedure;

                    CompensationLeave.Parameters.Add(new SqlParameter("@employee_ID", empID));
                    CompensationLeave.Parameters.Add(new SqlParameter("@compensation_date", compensationDate));
                    CompensationLeave.Parameters.Add(new SqlParameter("@reason", reason.Text));
                    CompensationLeave.Parameters.Add(new SqlParameter("@date_of_original_workday", originalWorkday));
                    CompensationLeave.Parameters.Add(new SqlParameter("@rep_emp_id", replacementEmpID));

                    conn.Open();
                    CompensationLeave.ExecuteNonQuery();
                }

                Response.Write("Compensation leave applied successfully");
            }
            catch (Exception ex)
            {
                Response.Write("Database error: " + ex.Message);
            }
        }
    }
}
