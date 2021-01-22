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
    public partial class ViewProducts : System.Web.UI.Page
    {
        protected void TableMaker(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("vendorviewProducts", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                string Username = (string)(Session["username"]);
                //change Username to "hadeel.adel" for testing.
                cmd.Parameters.Add(new SqlParameter("@vendorname", Username));
            }
            catch (Exception) { Response.Write("Error reading username"); }
            conn.Open();
            //IF the output is a table, then we can read the records one at a time
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            //table and columns init
            Table tbl = new Table();
            tbl.CellPadding = 8;
            TableRow tr1 = new TableRow();
            TableCell tcID = new TableCell();
            TableCell tcName = new TableCell();
            TableCell tcCategory = new TableCell();
            TableCell tcDescription = new TableCell();
            TableCell tcFinPrice = new TableCell();
            TableCell tcPrice = new TableCell();
            TableCell tcColor = new TableCell();
            TableCell tcAvailable = new TableCell();
            TableCell tcRate = new TableCell();
            TableCell tcCustomerUser = new TableCell();
            TableCell tcCustOrderID = new TableCell();
            tcID.Text = "ID";
            tcName.Text = "Name";
            tcCategory.Text = "Category";
            tcDescription.Text = "Description";
            tcFinPrice.Text = "Final Price";
            tcPrice.Text = "Price";
            tcColor.Text = "Color";
            tcAvailable.Text = "Available";
            tcRate.Text = "Rate";
            tcCustomerUser.Text = "Customer_User";
            tcCustOrderID.Text = "Customer_Order_ID";
            tr1.Cells.Add(tcID);
            tr1.Cells.Add(tcName);
            tr1.Cells.Add(tcCategory);
            tr1.Cells.Add(tcDescription);
            tr1.Cells.Add(tcFinPrice);
            tr1.Cells.Add(tcPrice);
            tr1.Cells.Add(tcColor);
            tr1.Cells.Add(tcAvailable);
            tr1.Cells.Add(tcRate);
            tr1.Cells.Add(tcCustomerUser);
            tr1.Cells.Add(tcCustOrderID);
            tbl.Rows.Add(tr1);

            //add rows of products
            while (rdr.Read())
            {
                int prodID = rdr.GetInt32(rdr.GetOrdinal("serial_no"));
                string prodName = rdr.GetString(rdr.GetOrdinal("product_name"));
                string prodCategory = rdr.GetString(rdr.GetOrdinal("category"));
                string prodDescription = rdr.GetString(rdr.GetOrdinal("product_description"));
                decimal prodFinPrice = rdr.GetDecimal(rdr.GetOrdinal("final_price"));
                decimal prodPrice = rdr.GetDecimal(rdr.GetOrdinal("price"));
                string prodColor = rdr.GetString(rdr.GetOrdinal("color"));
                bool prodAvailable = rdr.GetBoolean(rdr.GetOrdinal("available"));
                int prodRate = 0;
                try { prodRate = rdr.GetInt32(rdr.GetOrdinal("rate")); }
                catch (Exception) { }
                string prodCustomerUser = "Null";
                try { prodCustomerUser = rdr.GetString(rdr.GetOrdinal("customer_username")); }
                catch (Exception) { }
                int prodOrderId = -1;
                try { prodOrderId = rdr.GetInt32(rdr.GetOrdinal("customer_order_id")); }
                catch (Exception) { }
                TableRow tr = new TableRow();
                TableCell tcprodID = new TableCell();
                tcprodID.Text = prodID.ToString();
                TableCell tcprodName = new TableCell();
                tcprodName.Text = prodName;
                TableCell tcprodCategory = new TableCell();
                tcprodCategory.Text = prodCategory;
                TableCell tcprodDescription = new TableCell();
                tcprodDescription.Text = prodDescription;
                TableCell tcprodFinPrice = new TableCell();
                tcprodFinPrice.Text = prodFinPrice.ToString();
                TableCell tcprodPrice = new TableCell();
                tcprodPrice.Text = prodPrice.ToString();
                TableCell tcprodColor = new TableCell();
                tcprodColor.Text = prodColor;
                TableCell tcprodAvailable = new TableCell();
                tcprodAvailable.Text = prodAvailable.ToString();
                TableCell tcprodRate = new TableCell();
                tcprodRate.Text = prodRate.ToString();
                TableCell tcprodCustUser = new TableCell();
                tcprodCustUser.Text = prodCustomerUser;
                TableCell tcprodCustOrd = new TableCell();
                tcprodCustOrd.Text = prodOrderId.ToString();
                tr.Cells.Add(tcprodID);
                tr.Cells.Add(tcprodName);
                tr.Cells.Add(tcprodCategory);
                tr.Cells.Add(tcprodDescription);
                tr.Cells.Add(tcprodFinPrice);
                tr.Cells.Add(tcprodPrice);
                tr.Cells.Add(tcprodColor);
                tr.Cells.Add(tcprodAvailable);
                tr.Cells.Add(tcprodRate);
                tr.Cells.Add(tcprodCustUser);
                tr.Cells.Add(tcprodCustOrd);
                tbl.Rows.Add(tr);
            }
            form1.Controls.Add(tbl);

        }
        protected void Page_Load(object sender, EventArgs e)

        {
            if (Session["username"] == null)
            {
                Response.Redirect("userLogin.aspx");
            }
            else
            {
                TableMaker(sender, e);
            }
        }
    }
}