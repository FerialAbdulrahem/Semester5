using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace M3_Application
{
    public partial class Attendance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeID"] == null)
            {
                Response.Redirect("~/Academic/Employee_Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadAttendance();
            }
        }

        private void LoadAttendance()
        {
            string connString = WebConfigurationManager
                .ConnectionStrings["MyDatabaseConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(
                    "SELECT * FROM dbo.MyAttendance(@id)", conn);

                cmd.Parameters.AddWithValue("@id", (int)Session["EmployeeID"]);

                conn.Open();

                DataTable dt = new DataTable();
                dt.Load(cmd.ExecuteReader());

                AttendanceTable.DataSource = dt;
                AttendanceTable.DataBind();
            }
        }
    }
}
