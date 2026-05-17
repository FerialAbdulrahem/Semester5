using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3_Application
{
    public partial class LoginChoice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Optional: You can add any initialization code here
        }

        protected void btnHR_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/HR/HR_Login.aspx");
        }

        protected void btnAdmin_Click(object sender, EventArgs e)
        {
            // Redirect to admin login page
            Response.Redirect("~/Admin/AdminLogin.aspx"); // You'll need to create this page
        }

        protected void btnAcademic_Click(object sender, EventArgs e)
        {
            // Redirect to academic employee login page
            Response.Redirect("~/Academic/Academic_Login.aspx"); // You'll need to create this page
        }
    }
}