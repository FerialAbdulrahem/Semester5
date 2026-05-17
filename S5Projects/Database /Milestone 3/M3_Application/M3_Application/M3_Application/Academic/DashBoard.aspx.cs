using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3_Application
{
    public partial class DashBoard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeID"] == null)
            {
                Response.Redirect("~/Academic/Academic_Login.aspx");
            }
            

        }

        protected void viewmyperformance(object sender, EventArgs e)
        {
            Response.Redirect("~/Academic/Performance.aspx");
        }

        protected void viewmyattendance(object sender, EventArgs e)
        {
            Response.Redirect("~/Academic/Attendance.aspx");
        }

        protected void payroll(object sender, EventArgs e)
        {
            Response.Redirect("~/Academic/Payroll.aspx");
        }

        protected void deductions(object sender, EventArgs e)
        {
            Response.Redirect("~/Academic/Deductions.aspx");

        }

        protected void annualleave(object sender, EventArgs e)
        {
            Response.Redirect("~/Academic/Apply_for_AnnualLeave.aspx");

        }

        protected void Status_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Academic/Status_Leaves.aspx");
        }

        protected void ApplyAccidentalLeave(object sender, EventArgs e)
        {
            Response.Redirect("~/Academic/ApplyAccidentalLeave.aspx");
        }
        protected void ApplyCompensationLeave(object sender, EventArgs e)
        {
            Response.Redirect("~/Academic/ApplyCompensationLeave.aspx");
        }
        protected void ApplyMedicalLeave(object sender, EventArgs e)
        {
            Response.Redirect("~/Academic/ApplyMedicalLeave.aspx");
        }
        protected void ApplyUnpaidLeave(object sender, EventArgs e)
        {
            Response.Redirect("~/Academic/ApplyUnpaidLeave.aspx");
        }
        protected void ApproveAnnual(object sender, EventArgs e)
        {
            Response.Redirect("~/Academic/ApproveAnnual.aspx");
        }
        protected void ApproveUnpaid(object sender, EventArgs e)
        {
            Response.Redirect("~/Academic/ApproveUnpaid.aspx");
        }
        protected void EvaluateEmployee(object sender, EventArgs e)
        {
            Response.Redirect("~/Academic/EvaluateEmployee.aspx");
        }

    }
}