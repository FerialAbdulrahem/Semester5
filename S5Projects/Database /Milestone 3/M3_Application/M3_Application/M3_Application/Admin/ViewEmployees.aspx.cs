using System;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace M3_Application
{
    public partial class ViewEmployees : System.Web.UI.Page
    {
        string conn = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    using (SqlConnection c = new SqlConnection(conn))
                    using (SqlCommand cmd = new SqlCommand("select * from allEmployeeProfiles", c))
                    {
                        c.Open();
                        gvEmp.DataSource = cmd.ExecuteReader();
                        gvEmp.DataBind();
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