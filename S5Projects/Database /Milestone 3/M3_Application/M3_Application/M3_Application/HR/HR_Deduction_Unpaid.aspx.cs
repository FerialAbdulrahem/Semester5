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
  

    public partial class HR_Deduction_Unpaid : System.Web.UI.Page
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
                // 1. Get max deduction_id BEFORE calling the procedure
                int maxBefore = GetMaxDeductionId(empId);

                // 2. Execute the stored procedure
                using (SqlConnection c = new SqlConnection(conn))
                using (SqlCommand cmd = new SqlCommand("Deduction_unpaid", c))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@employee_ID", empId);
                    c.Open();
                    cmd.ExecuteNonQuery();
                }

                // 3. Load records that are newer than maxBefore
                LoadUpdatedRecord(empId, maxBefore);
                if (gvResult.Rows.Count == 0)
                {
                    lblMessage.Text = "0 Deduction(s) added.";
                }
                else
                {
                    lblMessage.Text = "Deduction(s) added successfully.";
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
            }
        }

        int GetMaxDeductionId(int empId)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(@"
        SELECT ISNULL(MAX(deduction_id), 0) 
        FROM deduction 
        WHERE emp_ID = @id AND type = 'unpaid'", conn))
            {
                cmd.Parameters.AddWithValue("@id", empId);
                conn.Open();

                object result = cmd.ExecuteScalar();
                return Convert.ToInt32(result);
            }
        }

        void LoadUpdatedRecord(int empId, int maxBefore)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(@"
        SELECT deduction_id, emp_ID, date, amount, type, status, unpaid_ID
        FROM deduction
        WHERE emp_ID = @id 
          AND type = 'unpaid' 
          AND deduction_id > @maxBefore
        ORDER BY deduction_id DESC;", conn))
            {
                cmd.Parameters.AddWithValue("@id", empId);
                cmd.Parameters.AddWithValue("@maxBefore", maxBefore);
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