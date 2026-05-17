using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3_Application
{
    using System;

    public partial class HR_Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["HRid"] == null)
                Response.Redirect("~/HR/HR_Login.aspx");
        }
    }

}