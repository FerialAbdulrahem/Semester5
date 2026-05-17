using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3_Application
{
    public partial class Status_Leaves : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeID"] == null)
                Response.Redirect("~/Academic/Employee_Login.aspx");

            if (!IsPostBack)
            {
                LoadStatus();
            }

        }
        private void LoadStatus()
        {
            int empID = (int)Session["EmployeeID"];
            string connString = WebConfigurationManager
                .ConnectionStrings["MyDatabaseConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT * FROM dbo.status_leaves(@id)", conn);

                cmd.Parameters.AddWithValue("@id", empID);

                conn.Open();

                DataTable dt = new DataTable();
                dt.Load(cmd.ExecuteReader());

                Statusleaves.DataSource = dt;
                Statusleaves.DataBind();
            }
        }
    }
}
