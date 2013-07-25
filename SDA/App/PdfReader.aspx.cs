using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SDA.wsInsercionDatosBen;

namespace SDA.App
{
    public partial class PdfReader : System.Web.UI.Page
    {
        wsInsertaDatosBeneficios getter = new wsInsertaDatosBeneficios();

        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request.Url.Segments.Last();

            if (action.Equals("load"))
            {
                WriteBytesFromFile();
                return;
            }
        }

        public void WriteBytesFromFile()
        {
            string folder = Session["IdSiniestro"].ToString();
            string file = Session["NoDocumentacion"].ToString();

            Response.Clear();
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.BinaryWrite(getter.GetFileForSiniestro(folder, file, ".pdf"));
        }
    }
}