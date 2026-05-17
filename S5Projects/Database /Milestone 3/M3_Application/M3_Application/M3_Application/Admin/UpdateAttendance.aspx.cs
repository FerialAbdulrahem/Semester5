using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;

namespace M3_Application
{
    public partial class UpdateAttendance : System.Web.UI.Page
    {
        string conn = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

        protected void UpdateAttendance_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection c = new SqlConnection(conn))
                {
                    c.Open();

                    SqlCommand check = new SqlCommand("select 1 from Attendance where emp_ID = @id AND [date] = cast(GETDATE() as date)", c);
                    check.Parameters.AddWithValue("@id", int.Parse(txtEmpID.Text));

                    object exists = check.ExecuteScalar();


                    if (exists == null)
                    {
                        EMsg.Text = "No attendance record found for this employee today.";
                        EMsg.ForeColor = System.Drawing.Color.Red;
                        return;
                    }

                    using (SqlCommand cmd = new SqlCommand("Update_Attendance", c))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@Employee_id", int.Parse(txtEmpID.Text));
                        cmd.Parameters.AddWithValue("@check_in_time", txtIn.Text);
                        cmd.Parameters.AddWithValue("@check_out_time", txtOut.Text);

                        cmd.ExecuteNonQuery();
                    }

                    EMsg.Text = "Attendance updated!";
                    EMsg.ForeColor = System.Drawing.Color.Green;
                }
            }
            catch (Exception ex)
            {
                EMsg.Text = "Error: " + ex.Message;
                EMsg.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}