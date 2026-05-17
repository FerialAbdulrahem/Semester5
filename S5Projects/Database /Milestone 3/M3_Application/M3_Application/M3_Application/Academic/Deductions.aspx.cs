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
    public partial class Deductions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeID"] == null)
            {
                Response.Redirect("~/Academic/Employee_Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadMonths();
            }

        }
        void LoadMonths()
        {
            for (int i = 1; i <= 12; i++)
                Months.Items.Add(i.ToString());
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string connString = WebConfigurationManager
              .ConnectionStrings["MyDatabaseConnection"].ConnectionString;

            int empID = (int)Session["EmployeeID"];
            int month = int.Parse(Months.SelectedValue);

            using (SqlConnection con = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT * FROM dbo.Deductions_Attendance(@emp, @month)", con);

                cmd.Parameters.AddWithValue("@emp", empID);
                cmd.Parameters.AddWithValue("@month", month);

                con.Open();

                DataTable dt = new DataTable();
                dt.Load(cmd.ExecuteReader());

                ViewDeductions.DataSource = dt;
                ViewDeductions.DataBind();
            }
        }
    }
}
    
