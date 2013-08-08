using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using SDA.wsConsultaReportesDA;

namespace SDA.App
{
    public partial class LogBit : System.Web.UI.UserControl
    {
        wsConsultaReportesDA.wsConsultaReportesDA reportesDA = new wsConsultaReportesDA.wsConsultaReportesDA();
        wsInsercionDatosBen.wsInsertaDatosBeneficios insertaDatos = new wsInsercionDatosBen.wsInsertaDatosBeneficios();

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void BitacoraSiniestro(int noSiniestro)
        {
            Bitacora[] bitacora = reportesDA.Bitacoras(5, noSiniestro);

            strBitacora.DataSource = bitacora;
            strBitacora.DataBind();
        }

        protected void NuevaBitacora(object sender, DirectEventArgs e)
        {
            int idSiniestro = Convert.ToInt32(Session["IdSiniestro"]);

            grdBitacora.Disabled = true;
            txtBitacora.SetValue(string.Empty);
            txtBitacora.ReadOnly = false;
            btnGuardarBitacora.Hidden = false;
            btnCancelarBitacora.Hidden = false;
        }

        protected void RestaurarBitacora(object sender, DirectEventArgs e)
        {
            grdBitacora.Disabled = false;
            txtBitacora.SetValue(string.Empty);
            txtBitacora.ReadOnly = true;
            btnGuardarBitacora.Hidden = true;
            btnCancelarBitacora.Hidden = true;
        }

        protected void InsertarBitacora(object sender, DirectEventArgs e)
        {
            int idUsuario = Convert.ToInt32(Session["Usuario"]);
            int noSiniestro = Convert.ToInt32(Session["IdSiniestro"]);

            Error err = reportesDA.InsertBitacoraDA(noSiniestro, idUsuario, txtBitacora.RawValue.ToString());

            if (err.Valor) X.MessageBox.Alert("Alerta", err.Mensaje).Show();

            BitacoraSiniestro(noSiniestro);

            RestaurarBitacora(null, null);
        }
    }
}