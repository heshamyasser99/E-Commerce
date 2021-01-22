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
    public partial class OffersPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e){
            if (Session["username"] == null)
            {
                Response.Redirect("userLogin.aspx");
            }
            else
            {
                LoadOffers(sender, e);
            }
           
        }
        protected void LoadOffers(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("viewOffers", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            conn.Open();
            //IF the output is a table, then we can read the records one at a time
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            //table and columns init
            Table tbl = new Table();
            tbl.CellPadding = 8;
            TableRow tr1 = new TableRow();
            TableCell tcOffID = new TableCell();
            TableCell tcAmount = new TableCell();
            TableCell tcExpiry = new TableCell();

            tcOffID.Text = "Offer ID";
            tcAmount.Text = "Amount";
            tcExpiry.Text = "Expiry";
            tr1.Cells.Add(tcOffID);
            tr1.Cells.Add(tcAmount);
            tr1.Cells.Add(tcExpiry);
            tbl.Rows.Add(tr1);

            //add rows of products
            while (rdr.Read())
            {
                int offerID = rdr.GetInt32(rdr.GetOrdinal("offer_id"));
                int offerAmount = rdr.GetInt32(rdr.GetOrdinal("offer_amount"));
                DateTime expiryDate = rdr.GetDateTime(rdr.GetOrdinal("expiry_date"));

                TableRow tr = new TableRow();
                TableCell tcOfferID = new TableCell();
                tcOfferID.Text = offerID.ToString();
                TableCell tcOfferAmount = new TableCell();
                tcOfferAmount.Text = offerAmount.ToString();
                TableCell tcExpiryDate = new TableCell();
                tcExpiryDate.Text = expiryDate.ToString();
                tr.Cells.Add(tcOfferID);
                tr.Cells.Add(tcOfferAmount);
                tr.Cells.Add(tcExpiryDate);
                tbl.Rows.Add(tr);
            }
            form1.Controls.Add(tbl);
        }

        protected void CreateOfferBtn_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("addOffer", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string Amount = amount.Text;
            string Expiry = expiryDate.Text;
            int Amount1 = 0;
            DateTime Expiry1;
            if (Amount == "" || Expiry == "")
            {
                Response.Write("You can not have an empty value for an attribute");
            }
            else
            {
                bool flag1 = false;
                bool flag2 = false;
                try
                {
                    Amount1 = int.Parse(Amount);
                    flag1 = true;
                }
                catch (Exception) { Response.Write("Value you entered for Amount couldn't be converted to int"); }
                try
                {
                    Expiry1 = DateTime.Parse(Expiry);
                    flag2 = true;
                }
                catch (Exception) { Response.Write("Value you entered for Expiry Date couldn't be converted to DateTime"); }
                //pass parameters to the stored procedure
                cmd.Parameters.Add(new SqlParameter("@offeramount", Amount1));
                cmd.Parameters.Add(new SqlParameter("@expiry_date", Expiry));

                //Executing the SQLCommand
                conn.Open();
                try
                {
                    //ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Offer added')", true);
                    cmd.ExecuteNonQuery();
                    Page.Response.Redirect(Page.Request.Url.ToString(), true);
                }
                catch (SqlException ex)
                {
                    System.Diagnostics.Debug.WriteLine(ex.Message);
                }
                conn.Close();
            }
        }

        protected void AddToProductBtn_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("applyOffer", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string OfferID = addOfferId.Text;
            string SerialNo = serialNo.Text;
            int OfferID1 = 0;
            int SerialNo1 = 0;
            if (OfferID == "" || SerialNo == "")
            {
                Response.Write("You can not have an empty value for an attribute");
            }
            else
            {
                //Serial to int, Price to Decimal
                bool flag1 = false;
                bool flag2 = false;
                try
                {
                    OfferID1 = int.Parse(OfferID);
                    flag1 = true;
                }
                catch (Exception) { Response.Write("Value you entered for Offer ID couldn't be converted to int."); }
                try
                {
                    SerialNo1 = int.Parse(SerialNo);
                    flag2 = true;
                }
                catch (Exception) { Response.Write("Value you entered for Serial Number couldn't be converted to int."); }

                string Username = (string)(Session["username"]);
                //change Username to "hadeel.adel" for testing
                cmd.Parameters.Add(new SqlParameter("@vendorname", Username));
                cmd.Parameters.Add(new SqlParameter("@offerid", OfferID1));
                cmd.Parameters.Add(new SqlParameter("@serial", SerialNo1));

                //Executing the SQLCommand
                conn.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                    Response.Write("Offer "+OfferID1+" added to product "+SerialNo1);
                }
                catch (SqlException ex)
                {
                    System.Diagnostics.Debug.WriteLine(ex.Message);
                }
                conn.Close();
            }
        }

        protected void RemoveBtn_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("checkandremoveExpiredoffer", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string OfferID = removeOfferID.Text;
            int OfferID1 = 0;
            if (OfferID == "")
            {
                Response.Write("You can not have an empty value for an attribute");
            }
            else
            {
                bool flag = false;
                try
                {
                    OfferID1 = int.Parse(OfferID);
                    flag = true;
                }
                catch (Exception) { Response.Write("Value you entered for Offer ID couldn't be converted to int"); }
                //pass parameters to the stored procedure
                cmd.Parameters.Add(new SqlParameter("@offerid", OfferID1));

                //Executing the SQLCommand
                conn.Open();
                try
                {
                    cmd.ExecuteNonQuery();
                    Page.Response.Redirect(Page.Request.Url.ToString(), true);
                   // ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Offer removed')", true);
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