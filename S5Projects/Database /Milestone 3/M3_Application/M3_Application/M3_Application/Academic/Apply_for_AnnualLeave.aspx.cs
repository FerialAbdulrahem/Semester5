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
    public partial class Apply_for_AnnualLeave : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["EmployeeID"] == null)
            {
                Response.Redirect("~/Academic/Employee_Login.aspx");
            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                int empId = (int)Session["EmployeeID"];

                // 2) validate replacement ID numeric
                if (!int.TryParse(ReplacementID.Text.Trim(), out int replacement))
                {
                    Error.Text = "Replacement ID must be a valid number. Please enter the numeric ID of the replacement employee.";
                    Error.Visible = true;
                    return;
                }

                // 3) ensure replacement is not the same employee
                if (replacement == empId)
                {
                    Error.Text = "Replacement employee cannot be the same as the requester. Please enter a different replacement ID.";
                    Error.Visible = true;
                    return;
                }

                // 4) validate dates
                if (string.IsNullOrWhiteSpace(Start.Text) || string.IsNullOrWhiteSpace(End.Text))
                {
                    Error.Text = "Start date and end date are required. Please enter both dates.";
                    Error.Visible = true;
                    return;
                }

                if (!DateTime.TryParse(Start.Text.Trim(), out DateTime startDate))
                {
                    Error.Text = "Start date is invalid. Please enter a valid date (e.g., 2025-03-01).";
                    Error.Visible = true;
                    return;
                }

                if (!DateTime.TryParse(End.Text.Trim(), out DateTime endDate))
                {
                    Error.Text = "End date is invalid. Please enter a valid date (e.g., 2025-03-10).";
                    Error.Visible = true;
                    return;
                }

                if (startDate > endDate)
                {
                    Error.Text = "Start date must be on or before end date. Please correct the dates.";
                    Error.Visible = true;
                    return;
                }

                // 5) optional: check replacement exists in Employee table
                string connString = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;
                using (SqlConnection checkConn = new SqlConnection(connString))
                {
                    SqlCommand checkCmd = new SqlCommand("SELECT COUNT(1) FROM Employee WHERE employee_id = @repId", checkConn);
                    checkCmd.Parameters.AddWithValue("@repId", replacement);
                    checkConn.Open();
                    int exists = (int)checkCmd.ExecuteScalar();
                    if (exists == 0)
                    {
                        Error.Text = $"Replacement employee with ID {replacement} was not found. Please enter a valid replacement employee ID.";
                        Error.Visible = true;
                        return;
                    }
                }

                // 6) everything validated — call stored procedure
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    SqlCommand cmd = new SqlCommand("Submit_annual", conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@employee_ID", empId);
                    cmd.Parameters.AddWithValue("@replacement_emp", replacement);
                    cmd.Parameters.AddWithValue("@start_date", startDate);
                    cmd.Parameters.AddWithValue("@end_date", endDate);

                    conn.Open();
                    cmd.ExecuteNonQuery();

                    Error.Text = "Annual leave submitted successfully!";
                    Error.Visible = true;
                }
            }
            catch (Exception ex)
            {
                // show the error message and keep it simple (user-friendly)
                Error.Text = "Error: " + ex.Message;
                Error.Visible = true;
            }
        }
    }
}

    //        Error.Text = "";
    //        Error.Visible = false;

    //        try
    //        {
    //            int empId = (int)Session["EmployeeID"];

    //            int replacement = int.Parse(ReplacementID.Text);
    //            DateTime startDate = DateTime.Parse(Start.Text);
    //            DateTime endDate = DateTime.Parse(End.Text);

    //            string connString = WebConfigurationManager
    //                .ConnectionStrings["MyDatabaseConnection"].ConnectionString;

    //            using (SqlConnection conn = new SqlConnection(connString))
    //            {
    //                SqlCommand cmd = new SqlCommand("Submit_annual", conn);
    //                cmd.CommandType = System.Data.CommandType.StoredProcedure;

    //                cmd.Parameters.AddWithValue("@employee_ID", empId);
    //                cmd.Parameters.AddWithValue("@replacement_emp", replacement);
    //                cmd.Parameters.AddWithValue("@start_date", startDate);
    //                cmd.Parameters.AddWithValue("@end_date", endDate);

    //                conn.Open();
    //                cmd.ExecuteNonQuery();

    //                Error.ForeColor = System.Drawing.Color.Green;
    //                Error.Text = "Annual leave submitted successfully!";
    //            }
    //        }
    //        catch (Exception ex)
    //        {
    //            Error.ForeColor = System.Drawing.Color.Red;
    //            Error.Text = "Error: " + ex.Message;
    //            Error.Visible = true;
    //        }

