using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3_Application
{
    public partial class RemoveApprovedLeave : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ToString();

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    int id = int.Parse(employee_id.Text);

                    SqlCommand removeproc = new SqlCommand("Remove_Approved_Leaves", conn);
                    removeproc.CommandType = System.Data.CommandType.StoredProcedure;
                    removeproc.Parameters.AddWithValue("@Employee_id", id);

                    conn.Open();
                    int rowsAffected = removeproc.ExecuteNonQuery();

                    // Show result message
                    if (rowsAffected > 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            $"alert('Successfully removed {rowsAffected} absent records for approved leaves.');", true);
                    }
                    else
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "alert('No matching records found or no changes were made.');", true);
                    }
                }
            }
            catch (FormatException)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "alert('Please enter a valid number for Employee ID.');", true);
            }
            catch (SqlException sqlEx)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Database Error: {sqlEx.Message}');", true);
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    $"alert('Error: {ex.Message}');", true);
            }
        }
    }
}