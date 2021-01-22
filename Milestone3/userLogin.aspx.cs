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
    public partial class userLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LOGIN(object sender, EventArgs e)
        {
            string username = UserLog.Text;
            string password = UserPass.Text;

            System.Diagnostics.Debug.WriteLine(username + "  " + password);

            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["DB"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the
             * stored procedure and the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("userLogin", conn);
            cmd.CommandType = CommandType.StoredProcedure;


            cmd.Parameters.Add(new SqlParameter("@username", username));
            cmd.Parameters.Add(new SqlParameter("@password", password));

            SqlParameter success = cmd.Parameters.Add("@success", SqlDbType.Bit);
            success.Direction = ParameterDirection.Output;

            SqlParameter type = cmd.Parameters.Add("@type", SqlDbType.Int);
            type.Direction = ParameterDirection.Output;


            //Executing the SQLCommand
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();


            int t = Int32.Parse(type.Value.ToString());
            if (success.Value.ToString() == "False")
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Log In Failed')", true);
            }
            else
            {
                if (t == 0)
                {
                    Session["username"] = username;
                    Response.Redirect("Customer.aspx");
                   
                }
                else
                {
                    if (t == 1)
                    {

                        Session["username"] = username;
                        //ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Log In successful As Vendor')", true);
                        Response.Redirect("Vendor.aspx");
                    }
                    else
                    {
                        if (t == 2)
                        {

                            Session["username"] = username;
                            //ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Log In successful As Admin')", true);
                            Response.Redirect("Admin.aspx");
                        }
                        else
                        {
                            if (t == 3)
                            {

                                Session["username"] = username;
                                //ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Log In successful As Delivery')", true);
                                Response.Redirect("Delivery.aspx");
                            }
                            else
                            {

                                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Log In Failed Unknown Bit')", true);
                            }
                        }
                    }
                }
            }

            System.Diagnostics.Debug.WriteLine(success.Value.ToString() + "  " + t);




        }
    }
}