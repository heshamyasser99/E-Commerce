using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication3
{
    public partial class Vendor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("userLogin.aspx");
            }
            else
            {

            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["DB"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("addMobile", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string number = TextBox1.Text;


            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@username", Session["username"]));
            cmd.Parameters.Add(new SqlParameter("@mobile_number", number));

            //Executing the SQLCommand
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();


                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Number Entry Successful')", true);
            }
            catch (SqlException ex)
            {
                if (ex.Number == 2627)
                {

                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Number Already Exists For This User')", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Problem With Input')", true);
                }

            }

        }
    }
}