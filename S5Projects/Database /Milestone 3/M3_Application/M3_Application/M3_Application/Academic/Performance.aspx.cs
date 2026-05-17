using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3_Application
{
    public partial class Performance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeID"] == null)
                Response.Redirect("~/Academic/Employee_Login.aspx");

        }

       

        protected void showperf(object sender, EventArgs e)
        {
            LoadPerformance();
        }
        private void LoadPerformance()
        {
            if (string.IsNullOrWhiteSpace(Semester.Text))
            {
                // Prevent empty input
                return;
            }

            string connString = WebConfigurationManager
                .ConnectionStrings["MyDatabaseConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT * FROM dbo.MyPerformance(@id, @sem)", conn);

                cmd.Parameters.Add(new SqlParameter("@id", (int)Session["EmployeeID"]));
                cmd.Parameters.Add(new SqlParameter("@sem", Semester.Text.Trim()));

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                DataTable dt = new DataTable();
                dt.Load(reader);

                Performanceshow.DataSource = dt;
                Performanceshow.DataBind();
            }
        }
    }
}
    
