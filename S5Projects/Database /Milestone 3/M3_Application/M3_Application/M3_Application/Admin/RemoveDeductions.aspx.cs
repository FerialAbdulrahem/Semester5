using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;

namespace M3_Application
{
    public partial class RemoveDeductions : System.Web.UI.Page
    {
        string conn = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

        protected void Remove_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection c = new SqlConnection(conn))
                using (SqlCommand cmd = new SqlCommand("Remove_Deductions", c))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    c.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMsg.Text = "Deductions removed!";
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error: " + ex.Message;
            }
        }
    }
}