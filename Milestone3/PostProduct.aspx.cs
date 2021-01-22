using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
namespace WebApplication3
{
    public partial class PostProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e){
            if (Session["username"] == null)
            {
                Response.Redirect("userLogin.aspx");
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
            SqlCommand cmd = new SqlCommand("postProduct", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string Name = name.Text;
            string Category = category.Text;
            string Description = description.Text;
            string Price = price.Text;
            string Color = color.Text;
            decimal Price1 = 0;
            if (Name == "" || Category == "" || Description == "" || Price == "" || Color == "")
            {
                Response.Write("You can not have an empty value for an attribute");
            }
            else
            {
                bool flag = false;
                try
                {
                    Price1 = decimal.Parse(Price);
                    flag = true;
                }
                catch (Exception)
                {
                    Response.Write("The value you entered for Price could not be converted to decimal");
                }
                //Response.Write("Name: "+Name+"<br />"+"Price: " +Price+"<br />"+"Price1: "+Price1);
                if (flag)
                {
                    try
                    {
                        string Username = (string)(Session["username"]);
                        //change Username to "hadeel.adel" for testing.
                        cmd.Parameters.Add(new SqlParameter("@vendorUsername", Username));
                        cmd.Parameters.Add(new SqlParameter("@product_name", Name));
                        cmd.Parameters.Add(new SqlParameter("@category", Category));
                        cmd.Parameters.Add(new SqlParameter("@product_description", Description));
                        cmd.Parameters.Add(new SqlParameter("@price", Price1));
                        cmd.Parameters.Add(new SqlParameter("@color", Color));
                    }
                    catch (Exception)
                    {
                        Response.Write("Error with adding parameters or reading username");
                    }
                    //Executing the SQLCommand
                    conn.Open();
                    try
                    {
                        cmd.ExecuteNonQuery();
                        Response.Write("Procedure executed successfully");
                    }
                    catch (SqlException ex)
                    {
                        System.Diagnostics.Debug.WriteLine(ex.Message);
                    }
                    conn.Close();
                }
            }
        }
    }
}