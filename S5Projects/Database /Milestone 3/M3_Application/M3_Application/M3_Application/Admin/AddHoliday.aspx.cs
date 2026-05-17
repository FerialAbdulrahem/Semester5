using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;

namespace M3_Application
{
    public partial class AddHoliday : System.Web.UI.Page
    {
        string conn = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

        protected void Add_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection c = new SqlConnection(conn))
                using (SqlCommand cmd = new SqlCommand("Add_Holiday", c))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@holiday_name", txtName.Text);
                    cmd.Parameters.AddWithValue("@from_date", DateTime.Parse(txtFrom.Text));
                    cmd.Parameters.AddWithValue("@to_date", DateTime.Parse(txtTo.Text));

                    c.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMsg.Text = "Holiday added!";
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error: " + ex.Message;
            }
        }
    }
}