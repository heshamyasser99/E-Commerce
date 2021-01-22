using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Milestone3
{
    public partial class VendorRegister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }

        protected void VendorReg(object sender, EventArgs e)
        {

            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["DB"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the
             * stored procedure and the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("vendorRegister", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            string username = VRUser.Text;
            string firstname = VRFName.Text;
            string lastname = VRLName.Text;
            string password = VRPass.Text;
            string email = VREmail.Text;
            string company = VRComp.Text;
            string bank = VRBank.Text;


            System.Diagnostics.Debug.WriteLine(username);
            System.Diagnostics.Debug.WriteLine(firstname);
            System.Diagnostics.Debug.WriteLine(lastname);
            System.Diagnostics.Debug.WriteLine(password);
            System.Diagnostics.Debug.WriteLine(email);
            System.Diagnostics.Debug.WriteLine(company);
            System.Diagnostics.Debug.WriteLine(bank);


            cmd.Parameters.Add(new SqlParameter("@username", username));
            cmd.Parameters.Add(new SqlParameter("@first_name", firstname));
            cmd.Parameters.Add(new SqlParameter("@last_name", lastname));
            cmd.Parameters.Add(new SqlParameter("@password", password));
            cmd.Parameters.Add(new SqlParameter("@email", email));
            cmd.Parameters.Add(new SqlParameter("@company_name", company));
            cmd.Parameters.Add(new SqlParameter("@bank_acc_no", bank));

            //Executing the SQLCommand

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Registration Succesful')", true);
            }
            catch (SqlException ex)
            {
                if (ex.Number == 2627)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Username Already Taken')", true);
                }
            }
        }

        protected void Button1_Click1(object sender, EventArgs e)
        {
            Response.Redirect("startPage.aspx");
        }
    }
}