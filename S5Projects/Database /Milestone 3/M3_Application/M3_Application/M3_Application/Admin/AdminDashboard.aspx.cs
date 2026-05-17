using System;

namespace M3_Application
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] == null)
                Response.Redirect("~/Admin/AdminLogin.aspx");
        }

        protected void btnEmp_Click(object s, EventArgs e) => Response.Redirect("~/Admin/ViewEmployees.aspx");
        protected void btnDept_Click(object s, EventArgs e) => Response.Redirect("~/Admin/EmployeesPerDept.aspx");
        protected void btnRej_Click(object s, EventArgs e) => Response.Redirect("~/Admin/RejectedMedicals.aspx");
        protected void btnAtt_Click(object s, EventArgs e) => Response.Redirect("~/Admin/UpdateAttendance.aspx");
        protected void btnDed_Click(object s, EventArgs e) => Response.Redirect("~/Admin/RemoveDeductions.aspx");
        protected void btnHol_Click(object s, EventArgs e) => Response.Redirect("~/Admin/AddHoliday.aspx");
        protected void btnInit_Click(object s, EventArgs e) => Response.Redirect("~/Admin/InitiateAttendance.aspx");


        protected void btn1_Click(object s, EventArgs e) => Response.Redirect("~/Admin/RemoveApprovedLeave.aspx");
        protected void btn2_Click(object s, EventArgs e) => Response.Redirect("~/Admin/RemoveDayOff.aspx");
        protected void btn3_Click(object s, EventArgs e) => Response.Redirect("~/Admin/RemoveHoliday.aspx");
        protected void btn4_Click(object s, EventArgs e) => Response.Redirect("~/Admin/ReplaceEmployee.aspx");
        protected void btn5_Click(object s, EventArgs e) => Response.Redirect("~/Admin/UpdateEmploymentStatus.aspx");
        protected void btn6_Click(object s, EventArgs e) => Response.Redirect("~/Admin/ViewWinterPerformance.aspx");
        protected void btn7_Click(object s, EventArgs e) => Response.Redirect("~/Admin/ViewYesterdayAttendance.aspx");



        protected void btnLogout_Click(object s, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("~/Main/LoginChoice.aspx");
        }
    }
}
