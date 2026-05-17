using System;
using System.Web.UI;

namespace M3_Application
{
    public partial class AdminLogin : Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string id = txtID.Text;
            string pass = txtPass.Text;

            if (txtID.Text == "admin" && txtPass.Text == "admin123")
            {
                Session["Admin"] = true;
                Response.Redirect("AdminDashboard.aspx");
            }

            else
            {
                EMsg.Text = "Invalid admin ID or password.";
            }
        }
    }
}
