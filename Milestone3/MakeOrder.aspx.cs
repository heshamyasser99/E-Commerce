using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace WebApplicationProj
{
    public partial class MakeOrder : System.Web.UI.Page
    {
        protected void LoadCC(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("viewCC", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            //double check 7war el session
            string Username = (string)(Session["username"]);
            //REPLACE ammar.yasser to Username
            cmd.Parameters.Add(new SqlParameter("@customername",Session["username"]));

            Table tbl = new Table();
            TableRow tr = new TableRow();
            TableCell ccnum = new TableCell();
            
            ccnum.Text = "Credit Card Number";
            
            tr.Cells.Add(ccnum);

            tbl.Rows.Add(tr);
            conn.Open();

            //IF the output is a table, then we can read the records one at a time
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                //Get the value of the attribute name in the Company table
                String ccnumber = rdr.GetString(rdr.GetOrdinal("cc_number"));

                TableRow tr1 = new TableRow();
                TableCell tcc = new TableCell();
                tcc.Text = ccnumber;
              
                tr1.Cells.Add(tcc);
                tbl.Rows.Add(tr1);

            }


            form1.Controls.Add(tbl);
        }
        protected void LoadOrder(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd = new SqlCommand("viewOrderCust", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            //double check 7war el session
            string Username = (string)(Session["username"]);
            cmd.Parameters.Add(new SqlParameter("@customername", "btengan"));

            Table tbl = new Table();
            TableRow tr = new TableRow();
            TableCell tcOrdNum = new TableCell();
            TableCell tcTotAmt = new TableCell();
            tcOrdNum.Text = "Order number";
            tcTotAmt.Text = "Total amount";
            tr.Cells.Add(tcOrdNum);
            tr.Cells.Add(tcTotAmt);
            tbl.Rows.Add(tr);
            conn.Open();

            //IF the output is a table, then we can read the records one at a time
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                //Get the value of the attribute name in the Company table
                int OrdNumber = rdr.GetInt32(rdr.GetOrdinal("order_no"));
                //Get the value of the attribute field in the Company table
                decimal TotAmount = rdr.GetDecimal(rdr.GetOrdinal("total_amount"));

                TableRow tr1 = new TableRow();
                TableCell tcOrd1 = new TableCell();
                TableCell tcTot1 = new TableCell();
                tcOrd1.Text = OrdNumber.ToString();
                tcTot1.Text = TotAmount.ToString();
                tr1.Cells.Add(tcOrd1);
                tr1.Cells.Add(tcTot1);
                tbl.Rows.Add(tr1);

            }


            form1.Controls.Add(tbl);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("userLogin.aspx");
            }
            LoadCC(sender,e);
        }

        protected void Button1_Click1(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["DB"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("makeOrder", conn);
            cmd.CommandType = CommandType.StoredProcedure;


            //double check 7war el session
            string Username = (string)(Session["username"]);
            //REPLACE btengan b username
            cmd.Parameters.Add(new SqlParameter("@customername", Session["username"]));

            //Executing the SQLCommand
            conn.Open();
            try { cmd.ExecuteNonQuery(); }
            catch (SqlException)
            {
                Response.Write("Something went wrong with executing query.");
            }
            conn.Close();

            //Get the information of the connection to the database
            string connStr1 = ConfigurationManager.ConnectionStrings["DB"].ToString();

            //create a new connection
            SqlConnection conn1 = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd1 = new SqlCommand("LastOrder", conn1);
            cmd1.CommandType = CommandType.StoredProcedure;


            //double check 7war el session
            string Username1 = (string)(Session["username"]);
            //REPLACE btengan b Username1
            cmd1.Parameters.Add(new SqlParameter("@customername", Session["username"]));


            //Save the output from the procedure
            SqlParameter count1 = cmd1.Parameters.Add("@orderid", SqlDbType.Int);
            count1.Direction = ParameterDirection.Output;
            if (count1.Value != null)
            {
                string totamount = count1.Value.ToString();
                Label1.Text = totamount;
            }
            
            SqlParameter count2 = cmd1.Parameters.Add("@totalamount", SqlDbType.Int);
            count2.Direction = ParameterDirection.Output;
            if (count2.Value != null)
            {
                string orderid = count2.Value.ToString();
                Label2.Text = orderid;
            }
            //Executing the SQLCommand
            conn1.Open();
            try { cmd1.ExecuteNonQuery(); }
            catch (SqlException sx)
            {
                Response.Write(sx.Message);
                Response.Write("Something went wrong with executing query.");
            }
            conn1.Close();


        }

        protected void TextBox3_TextChanged(object sender, EventArgs e)
        {

        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {
          
        }

        protected void CheckBox1_CheckedChanged1(object sender, EventArgs e)
        {
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["DB"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("cancelOrder", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            string orderidString = TextBox2.Text;
            if (orderidString == "")
            {
                Response.Write("Please enter a number");
            }
            else
            {
                int orderidint = -1;

                try
                {
                    orderidint = int.Parse(orderidString);

                }
                catch (Exception)
                {
                    Response.Write("Value ordered couldn't be converted to int");
                }

                //pass parameters to the stored procedure
                cmd.Parameters.Add(new SqlParameter("@orderid", orderidint));


                //Executing the SQLCommand
                conn.Open();
                try { cmd.ExecuteNonQuery(); }
                catch (SqlException sx)
                {
                    Response.Write(sx.Message);
                   // Response.Write("Something went wrong with executing query.");
                }
                conn.Close();
            }
        }

        protected void TextBox2_TextChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox2_TextChanged1(object sender, EventArgs e)
        {

        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            string amount = TextBox3.Text;
            if (amount == "")
            {
                Response.Write("Please enter a number");
            }
            else
            {
                int orderidint = -1;

                try
                {
                    orderidint = int.Parse(amount);

                }
                catch (Exception)
                {
                    Response.Write("Value ordered couldn't be converted to int");
                }

            }
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["DB"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("LastOrder", conn);
            cmd.CommandType = CommandType.StoredProcedure;


            //pass parameters to the stored procedure
            string Username = (string)(Session["username"]);
            cmd.Parameters.Add(new SqlParameter("@username", Username));


            //Save the output from the procedure
            SqlParameter count = cmd.Parameters.Add("@orderid", SqlDbType.Int);
            count.Direction = ParameterDirection.Output;
            int orderid = Int32.Parse(count.Value.ToString());

            //Executing the SQLCommand
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            //Get the information of the connection to the database
            string connStr1 = ConfigurationManager.ConnectionStrings["DB"].ToString();

            //create a new connection
            SqlConnection conn1 = new SqlConnection(connStr1);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd1 = new SqlCommand("SpecifyAmount", conn1);
            cmd1.CommandType = CommandType.StoredProcedure;

            string Username1 = (string)(Session["username"]);
            Decimal money = Decimal.Parse(TextBox3.Text);
            //pass parameters to the stored procedure
            cmd1.Parameters.Add(new SqlParameter("@customername", Username1));
            if(Credit_Card.Checked)
            {
                cmd1.Parameters.Add(new SqlParameter("@cash", 0));
                cmd1.Parameters.Add(new SqlParameter("@credit", money));
            }
            else
            {
                cmd1.Parameters.Add(new SqlParameter("@cash", money));
                cmd1.Parameters.Add(new SqlParameter("@credit", 0));
            }
            cmd1.Parameters.Add(new SqlParameter("@orderID", orderid));

            //Executing the SQLCommand
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

        }

        protected void TextBox3_TextChanged1(object sender, EventArgs e)
        {

        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["DB"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand cmd1 = new SqlCommand("LastOrder", conn);
            cmd1.CommandType = CommandType.StoredProcedure;


            //pass parameters to the stored procedure
            string Username = (string)(Session["username"]);
            cmd1.Parameters.Add(new SqlParameter("@username", Username));


            //Save the output from the procedure
            SqlParameter count = cmd1.Parameters.Add("@orderid", SqlDbType.Int);
            count.Direction = ParameterDirection.Output;
            int orderid = -1;
            if (count != null)
            {
                orderid = (int)count.Value;
         }

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("ChooseCreditCard", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            string ccnum = TextBox4.Text;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@creditcard", ccnum));
            cmd.Parameters.Add(new SqlParameter("@orderid", orderid));



            //Executing the SQLCommand
            conn.Open();

            try { cmd1.ExecuteNonQuery(); }
            catch (SqlException)
            {
                Response.Write("Something went wrong with executing query.");
            }

            try { cmd.ExecuteNonQuery(); }
            catch (SqlException)
            {
                Response.Write("Something went wrong with executing query.");
            }
            conn.Close();
        }
        protected void TextBox4_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            Response.Redirect("Customer.aspx");
        }
    }
    }

