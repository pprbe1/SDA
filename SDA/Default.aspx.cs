using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;

namespace SDA
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ResourceManager.GetInstance();
        }

        protected void Button_Click(object sender, Ext.Net.DirectEventArgs e)
        {
            Response.Redirect("/App/Menu.aspx");
        }
    }
}
