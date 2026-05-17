using System;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace M3_Application
{
    public partial class EmployeesPerDept : System.Web.UI.Page
    {
        string conn = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    using (SqlConnection c = new SqlConnection(conn))
                    using (SqlCommand cmd = new SqlCommand("select * from NoEmployeeDept", c))
                    {
                        c.Open();
                        gvDept.DataSource = cmd.ExecuteReader();
                        gvDept.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    // Handle error appropriately - could set a label or log
                }
            }
        }
    }
}