using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.InteropServices.ComTypes;
using System.Security.Policy;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace M3_Application
{
    public partial class ApplyAccidentalLeave : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

     

        protected void Apply_Click(object sender, EventArgs e)
        {
            int empID;
            DateTime startDate;
            DateTime endDate;

            if (string.IsNullOrEmpty(id.Text))
            {
                Response.Write("Please insert your ID");
                return;
            }

            if (string.IsNullOrEmpty(StartDate.Text))
            {
                Response.Write("Please insert the start date");
                return;
            }

            if (string.IsNullOrEmpty(EndDate.Text))
            {
                Response.Write("Please insert the end date");
                return;
            }

            if (!int.TryParse(id.Text, out  empID))
            {
                Response.Write("ID must be a number.");
                return;
            }

         
            if (!DateTime.TryParse(StartDate.Text, out startDate))
            {
                Response.Write("Start date is invalid.");
                return;
            }

            if (!DateTime.TryParse(EndDate.Text, out endDate))
            {
                Response.Write("End date is invalid.");
                return;
            }




            String connStr = WebConfigurationManager.ConnectionStrings["MyDatabaseConnection"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            empID = Convert.ToInt32(id.Text);
            startDate = DateTime.Parse(StartDate.Text);
            endDate = DateTime.Parse(EndDate.Text);


            SqlCommand Accidental_Leave = new SqlCommand("Submit_accidental", conn);
            Accidental_Leave.CommandType = CommandType.StoredProcedure;

            Accidental_Leave.Parameters.Add(new SqlParameter("@employee_ID", empID));
            Accidental_Leave.Parameters.Add(new SqlParameter("@start_date", startDate));
            Accidental_Leave.Parameters.Add(new SqlParameter("@end_date", endDate));

            conn.Open();
            Accidental_Leave.ExecuteNonQuery();
            conn.Close();

            Response.Write("Leave got applied successfully");


            // DateTime StartDate, EndDate;
            //if (EndDate <StartDate)
            //{
            //    Response.Write("Please enter correct dates");
            //}
        }

    }
}