using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3_Application
{
    public partial class ViewWinterPerformance : System.Web.UI.Page
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

                string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ToString();

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    // Using your existing view
                    string query = "SELECT * FROM allPerformance ORDER BY semester, emp_ID";

                    SqlCommand cmd = new SqlCommand(query, conn);

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();

                    conn.Open();
                    adapter.Fill(dt);

                    // Display results in GridView
                    if (dt.Rows.Count > 0)
                    {
                        // Create GridView programmatically
                        GridView gridView = new GridView();
                        gridView.ID = "gvWinterPerformance";
                        gridView.DataSource = dt;
                        gridView.DataBind();

                        // Add GridView to page
                        gridContainer.Controls.Add(gridView);

                        // Show record count
                        lblMessage.Text = $"Found {dt.Rows.Count} winter performance records.";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                    }
                    else
                    {
                        lblMessage.Text = "No winter performance records found.";
                        lblMessage.ForeColor = System.Drawing.Color.Blue;
                    }
                }
            }
            catch (SqlException sqlEx)
            {
                lblMessage.Text = "Database Error: " + sqlEx.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
    }
}