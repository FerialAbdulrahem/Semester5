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
  
public partial class HR_Deduction_Days : System.Web.UI.Page
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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        lblMessage.Text = "";
        if (!int.TryParse(txtEmployeeID.Text.Trim(), out int empId))
        {
            lblMessage.Text = "Enter a valid Employee ID.";
            return;
        }

        string conn = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ToString();

        try
        {
            using (SqlConnection c = new SqlConnection(conn))
            using (SqlCommand cmd = new SqlCommand("Deduction_days", c))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@employee_ID", empId);
                c.Open();
                cmd.ExecuteNonQuery();
                LoadUpdatedRecord();

                    if (gvResult.Rows.Count == 0)
                    {
                        lblMessage.Text = "0 Deduction(s) added.";
                    }
                    else
                    {
                        lblMessage.Text = "Deduction(s) added successfully.";
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
            SELECT top 1 deduction_id, emp_ID, date, amount, type, status, attendance_ID
from deduction
where emp_ID = @id 
  and type = 'missing_days' 
  and cast(date as date) = cast(CURRENT_TIMESTAMP as date)
  and deduction_id = (select max(deduction_id) from deduction)
order by deduction_id desc", conn))
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