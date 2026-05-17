using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;

namespace M3_Application
{
    public partial class InitiateAttendance : System.Web.UI.Page
    {
        string conn = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

        protected void Init_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection c = new SqlConnection(conn))
                using (SqlCommand cmd = new SqlCommand("Initiate_Attendance", c))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    c.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMsg.Text = "Attendance initiated!";
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error: " + ex.Message;
            }
        }
    }
}