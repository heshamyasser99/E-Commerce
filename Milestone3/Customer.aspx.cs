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
    public partial class Customer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)

        {
           
            if (Session["username"] == null)
            {
                Response.Redirect("userLogin.aspx");

            }
            else
            {
               
                if (!this.IsPostBack)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('" + "Log In successful As Customer:" + Session["username"] + "')", true);
                    System.Diagnostics.Debug.WriteLine(Session["username"]);
          
                }
                GridView1.DataBind();
                Wishlists.DataBind();
               // Dropdown.DataBind();
                GridView2.DataBind();
                GridView3.DataBind();
                GridView5.DataBind();
            


            }
        }


       
       
        protected void AddCT_Click(object sender, EventArgs e)
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
            string number = Ctel.Text;


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

        protected void createWish_Click(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["DB"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("createWishlist", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string wishName = newWish.Text;


            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@customername", Session["username"]));
            cmd.Parameters.Add(new SqlParameter("@name", wishName));
            //Executing the SQLCommand
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Wishlist Created Successfuly')", true);

            }
            catch (SqlException ex)
            {
                if (ex.Number == 2627)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Wishlist Already Exists For This Customer')", true);
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Problem With Input')", true);
                }
            }

            GridView1.DataBind();
            Wishlists.DataBind();
            //Dropdown.DataBind();
            GridView2.DataBind();
            GridView3.DataBind();
            GridView5.DataBind();

        }



        protected void Dropdown_TextChanged(object sender, EventArgs e)
        {

            System.Diagnostics.Debug.WriteLine("Value  changed");
            /*  GridView1.DataBind();
              Wishlists.DataBind();

              GridView2.DataBind();
              GridView3.DataBind();
              GridView5.DataBind();*/

        }



        protected void Dropdown_SelectedIndexChanged(object sender, EventArgs e)
        {
            System.Diagnostics.Debug.WriteLine("index changed");
           /* GridView1.DataBind();
            Wishlists.DataBind();
           
            GridView2.DataBind();
            GridView3.DataBind();
            GridView5.DataBind();*/


        }



        protected void AddProdToWish_Click(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["DB"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("AddtoWishlist", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string wishName = WishName.Text;
            try
            {
                int prodName = Int32.Parse(ProdName.Text);
                //pass parameters to the stored procedure
                cmd.Parameters.Add(new SqlParameter("@customername", Session["username"]));
                cmd.Parameters.Add(new SqlParameter("@wishlistname", wishName));
                cmd.Parameters.Add(new SqlParameter("@serial", prodName));
                //Executing the SQLCommand

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Product Added to Wishlist Successfuly')", true);
                  
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 2627)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('This Product Already Exists in This Wishlist')", true);
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine(ex.Message);
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('PROBLEM WITH INPUT')", true);
                    }
                }
            }
            catch (FormatException fx)
            {
                System.Diagnostics.Debug.WriteLine(fx.Message);
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Product Input Is Not A Number')", true);


            }



            GridView1.DataBind();
            Wishlists.DataBind();
           // Dropdown.DataBind();
            GridView2.DataBind();
            GridView3.DataBind();
            GridView5.DataBind();

        }
        protected void RemProdFromWish_Click(object sender, EventArgs e)
        {

            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["DB"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("removefromWishlist", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string wishName = WishName.Text;
            try
            {
                int prodName = Int32.Parse(ProdName.Text);
                //pass parameters to the stored procedure
                cmd.Parameters.Add(new SqlParameter("@customername", Session["username"]));
                cmd.Parameters.Add(new SqlParameter("@wishlistname", wishName));
                cmd.Parameters.Add(new SqlParameter("@serial", prodName));
                //Executing the SQLCommand

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Product Removed From Wishlist Successfuly')", true);
                    
                }
                catch (SqlException ex)
                {
                    if (ex.Number == 2627)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('This Product Already Exists in This Wishlist')", true);
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine(ex.Message);
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('PROBLEM WITH INPUT')", true);
                    }
                }
            }
            catch (FormatException fx)
            {
                System.Diagnostics.Debug.WriteLine(fx.Message);
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Product Input Is Not A Number')", true);
            }

            GridView1.DataBind();
            Wishlists.DataBind();
            //Dropdown.DataBind();
            GridView2.DataBind();
            GridView3.DataBind();
            GridView5.DataBind();

        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["DB"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("addToCart", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@customername", Session["username"]));
            try
            {
                int prod = Int32.Parse(ProdCart.Text);

                cmd.Parameters.Add(new SqlParameter("@serial", prod));

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Product Added To Cart Successfuly')", true);

                }
                catch (SqlException ex)
                {
                    if (ex.Number == 2627)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('This Product Already Exists In Cart')", true);
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine(ex.Message);
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('PROBLEM WITH INPUT')", true);
                    }
                }


            }
            catch (FormatException fx)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Product Input Is Not A Number')", true);

            }



            GridView3.DataBind();
        }

        protected void Button4_Click(object sender, EventArgs e)
        {

            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["DB"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("removefromCart", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@customername", Session["username"]));
            try
            {
                int prod = Int32.Parse(ProdCart.Text);

                cmd.Parameters.Add(new SqlParameter("@serial", prod));

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Product Removed From Cart Successfuly')", true);

                }
                catch (SqlException ex)
                {
                    if (ex.Number == 2627)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('DUPLICATION ERROR')", true);
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine(ex.Message);
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('PROBLEM WITH INPUT')", true);
                    }
                }


            }
            catch (FormatException fx)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Product Input Is Not A Number')", true);

            }



            GridView3.DataBind();
        }

        protected void Button5_Click(object sender, EventArgs e)
        {

            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["DB"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("AddCreditCard", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@customername", Session["username"]));




            try
            {
                DateTime s = DateTime.Parse(Date.Text);


                cmd.Parameters.Add(new SqlParameter("@expirydate", s));


                string cardnumber = cardNumber.Text;
                cmd.Parameters.Add(new SqlParameter("@creditcardnumber", cardnumber));

                string cardcode = cardCode.Text;
                cmd.Parameters.Add(new SqlParameter("@cvv", cardcode));



                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('CreditCard Added Successfully')", true);


                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine(ex.Message);
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Problem Inserting Card ')", true);
                }



            }
            catch (FormatException)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Wrong Date Format')", true);
            }
            GridView1.DataBind();
            Wishlists.DataBind();
            //Dropdown.DataBind();
            GridView2.DataBind();
            GridView3.DataBind();
            GridView5.DataBind();

        }

        protected void Button6_Click(object sender, EventArgs e)
        {
            Response.Redirect("MakeOrder.aspx");
        }

        protected void Button7_Click(object sender, EventArgs e)
        {          
           
           
            GridView1.DataBind();
            Wishlists.DataBind();

            GridView2.DataBind();
            GridView3.DataBind();
            GridView5.DataBind();

        }

        protected void Button8_Click(object sender, EventArgs e)
        {
            Session["wishlist"] = TextBox1.Text;
            System.Diagnostics.Debug.WriteLine(Session["wishlist"]);
            GridView1.DataBind();
            Wishlists.DataBind();

            GridView2.DataBind();
            GridView3.DataBind();
            GridView5.DataBind();
        }
       
    }
}
