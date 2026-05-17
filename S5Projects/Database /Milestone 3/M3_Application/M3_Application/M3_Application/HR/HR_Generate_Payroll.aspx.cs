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
   

    public partial class HR_Generate_Payroll : System.Web.UI.Page
    {
        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/HR/HR_Home.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Main/LoginChoice.aspx");
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["HRid"] == null) Response.Redirect("~/HR/HR_Login.aspx");
        }

        protected void btnGenerate_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";

            if (!int.TryParse(txtEmployeeID.Text.Trim(), out int empId))
            {
                lblMessage.Text = "Enter a valid Employee ID.";
                return;
            }

            if (!DateTime.TryParse(txtFrom.Text.Trim(), out DateTime from) ||
                !DateTime.TryParse(txtTo.Text.Trim(), out DateTime to))
            {
                lblMessage.Text = "Enter valid From and To dates.";
                return;
            }

            string conn = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ToString();

            try
            {
                using (SqlConnection c = new SqlConnection(conn))
                using (SqlCommand cmd = new SqlCommand("Add_Payroll", c))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@employee_ID", empId);
                    cmd.Parameters.AddWithValue("@from", from);
                    cmd.Parameters.AddWithValue("@to", to);
                    c.Open();
                    cmd.ExecuteNonQuery();
                    LoadUpdatedRecord();
                    if (gvResult.Rows.Count == 0)
                    {
                        lblMessage.Text = "0 Payroll(s) added.";
                    }
                    else
                    {
                        lblMessage.Text = "Payroll generated successfully.";
                    }
                   
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
            }
        }

        void LoadUpdatedRecord()
        {
            int empId = int.Parse(txtEmployeeID.Text.Trim());
            string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(@"
            SELECT top 1 *
            from payroll
            where emp_ID = @id 
            and cast(payment_date as date) = cast(CURRENT_TIMESTAMP as date)
            and ID = (select max(ID) from payroll)
            order by ID desc", conn))
            {
                cmd.Parameters.AddWithValue("@id", empId);
                conn.Open();

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvResult.DataSource = dt;
                gvResult.DataBind();
            }
        }
    }
}

