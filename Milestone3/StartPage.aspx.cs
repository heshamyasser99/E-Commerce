using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Milestone3
{
    public partial class StartPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

  

        protected void customerreg(object sender, EventArgs e)
        {
            Response.Redirect("CustomerRegister.aspx");
        }

        protected void vendorreg(object sender, EventArgs e)
        {
            Response.Redirect("VendorRegister.aspx");
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Response.Redirect("userLogin.aspx");
        }
    }
}