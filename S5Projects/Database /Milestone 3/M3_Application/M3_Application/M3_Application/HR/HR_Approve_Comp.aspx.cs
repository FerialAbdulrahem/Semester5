using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace M3_Application
{

    public partial class HR_Approve_Comp : System.Web.UI.Page
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
            if (Session["HRid"] == null)
                Response.Redirect("~/HR/HR_Login.aspx");
        }

        protected void btnProcess_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";

            if (!int.TryParse(txtRequestID.Text.Trim(), out int reqId))
            {
                lblMessage.Text = "Enter a valid Request ID.";
                return;
            }

            // Check Leave status BEFORE calling SP
            string currentStatus = GetLeaveStatus(reqId);

            if (currentStatus != null &&
                currentStatus != "" &&
                !currentStatus.Equals("Pending", StringComparison.OrdinalIgnoreCase))
            {
                lblMessage.Text = "Error: Leave request has already been processed.";
                return;
            }

            ProcessApproval("HR_approval_comp");
            LoadUpdatedRecord();

            if (gvResult.Rows.Count == 0)
            {
                lblMessage.Text = "This Request is not a Compensation Leave.";
            }
            else
            {
                lblMessage.Text = "Request proccessed successfully.";
            }
        }

        string GetLeaveStatus(int requestId)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ToString();
            string status = null;

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(
                "SELECT final_approval_status FROM Leave WHERE request_ID = @id", conn))
            {
                cmd.Parameters.AddWithValue("@id", requestId);
                conn.Open();

                object result = cmd.ExecuteScalar();
                if (result != DBNull.Value && result != null)
                    status = result.ToString();
            }

            return status;
        }

        void ProcessApproval(string procName)
        {
            int reqId = int.Parse(txtRequestID.Text.Trim());
            int hrId = (int)Session["HRid"];
            string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ToString();

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand(procName, conn))
                {
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@request_ID", reqId);
                    cmd.Parameters.AddWithValue("@HR_ID", hrId);

                    conn.Open();
                    cmd.ExecuteNonQuery();

                   
                }
            }
            catch (SqlException ex)
            {
                lblMessage.Text = ex.Message;
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Unexpected error: " + ex.Message;
            }
        }

        void LoadUpdatedRecord()
        {
            int reqId = int.Parse(txtRequestID.Text.Trim());
            string connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(@"
            SELECT l.request_id , l.date_of_request,l.start_date,l.end_date,l.num_days,l.final_approval_status
            FROM Leave L, compensation_leave C
            WHERE L.request_ID = C.request_ID and C.request_ID= @id", conn))
            {
                cmd.Parameters.AddWithValue("@id", reqId);
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