using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3_Application
{
    public partial class Payroll : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeID"] == null)
            {
                Response.Redirect("~/Academic/Employee_Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadPayroll();
            }

        }
        private void LoadPayroll()
        {
            int employeeID = (int)Session["EmployeeID"];

            string connString = WebConfigurationManager
                .ConnectionStrings["MyDatabaseConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT * FROM dbo.Last_month_payroll(@id)", conn);

                cmd.Parameters.AddWithValue("@id", employeeID);

                conn.Open();

                DataTable dt = new DataTable();
                dt.Load(cmd.ExecuteReader());

                ViewPayroll.DataSource = dt;
                ViewPayroll.DataBind();
            }
        }
    }
}