using System;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace M3_Application
{
    public partial class RejectedMedicals : System.Web.UI.Page
    {
        string conn = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    using (SqlConnection c = new SqlConnection(conn))
                    using (SqlCommand cmd = new SqlCommand("select * from allRejectedMedicals", c))
                    {
                        c.Open();
                        gvRej.DataSource = cmd.ExecuteReader();
                        gvRej.DataBind();
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