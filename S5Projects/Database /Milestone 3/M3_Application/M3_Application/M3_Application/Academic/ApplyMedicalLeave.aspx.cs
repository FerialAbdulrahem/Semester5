using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;

namespace M3_Application
{
    public partial class ApplyMedicalLeave : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void Apply_Click(object sender, EventArgs e)
        {
            // 1. Validate empty fields
            if (string.IsNullOrWhiteSpace(id.Text))
            {
                Response.Write("Please insert your ID");
                return;
            }
            if (string.IsNullOrWhiteSpace(StartDate.Text))
            {
                Response.Write("Please insert the start date");
                return;
            }
            if (string.IsNullOrWhiteSpace(EndDate.Text))
            {
                Response.Write("Please insert the end date");
                return;
            }
            if (string.IsNullOrWhiteSpace(type.Text))
            {
                Response.Write("Please insert the medical type");
                return;
            }
            if (string.IsNullOrWhiteSpace(status.Text))
            {
                Response.Write("Please insert the insurance status");
                return;
            }
            if (string.IsNullOrWhiteSpace(details.Text))
            {
                Response.Write("Please insert the disability details");
                return;
            }
            if (string.IsNullOrWhiteSpace(desc.Text))
            {
                Response.Write("Please insert the document description");
                return;
            }
            if (string.IsNullOrWhiteSpace(file.Text))
            {
                Response.Write("Please insert the file name");
                return;
            }

            // 2. Validate numeric ID
            if (!int.TryParse(id.Text, out int empID))
            {
                Response.Write("ID must be a number.");
                return;
            }

            // 3. Validate dates
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

            // 4. Date logic check
            if (startDate > endDate)
            {
                Response.Write("Start date cannot be after end date.");
                return;
            }

            // 5. Submit to database
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
                    SqlCommand MedicalLeave = new SqlCommand("Submit_Medical", conn);
                    MedicalLeave.CommandType = CommandType.StoredProcedure;

                    MedicalLeave.Parameters.Add(new SqlParameter("@employee_ID", empID));
                    MedicalLeave.Parameters.Add(new SqlParameter("@start_date", startDate));
                    MedicalLeave.Parameters.Add(new SqlParameter("@end_date", endDate));
                    MedicalLeave.Parameters.Add(new SqlParameter("@medical_type", type.Text));
                    MedicalLeave.Parameters.Add(new SqlParameter("@insurance_status", status.Text));
                    MedicalLeave.Parameters.Add(new SqlParameter("@disability_details", details.Text));
                    MedicalLeave.Parameters.Add(new SqlParameter("@document_description", desc.Text));
                    MedicalLeave.Parameters.Add(new SqlParameter("@file_name", file.Text));

                    conn.Open();
                    MedicalLeave.ExecuteNonQuery();
                }

                Response.Write("Leave got applied successfully");
            }
            catch (Exception ex)
            {
                Response.Write("Database error: " + ex.Message);
            }
        }
    }
}
