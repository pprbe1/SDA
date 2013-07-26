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
    public partial class DocPendientes : System.Web.UI.Page
    {
        wsConsultaReportesDA.wsConsultaReportesDA reportesDA = new wsConsultaReportesDA.wsConsultaReportesDA();
        wsInsercionDatosBen.wsInsertaDatosBeneficios insertaDatos = new wsInsercionDatosBen.wsInsertaDatosBeneficios();

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void BuscarSiniestros(object sender, DirectEventArgs e)
        {
            if (txtNumSocio.Text != string.Empty)
            {
                Session["OperacionDocPend"] = "1";
                Session["EntidadDocPend"] = txtNumSocio.Text;
            }
            else
            {
                Session["OperacionDocPend"] = "2";
                Session["EntidadDocPend"] = cmbSucursal.SelectedItem.Value;
            }

            ActualizarSiniestros();
        }

        private void ActualizarSiniestros()
        {
            int operacion = Convert.ToInt32(Session["OperacionDocPend"]);
            int entidad = Convert.ToInt32(Session["EntidadDocPend"]);

            DocumentoPendiente[] documentos = null;

            int idSucursal = Convert.ToInt32(cmbSucursal.SelectedItem.Value);

            switch (operacion)
            {
                case 1:
                    string noSocio = Session["EntidadDocPend"].ToString();
                    documentos = reportesDA.DocumentacionPendiente(idSucursal, noSocio);
                    break;

                case 2:
                    documentos = reportesDA.DocumentacionPendiente(idSucursal, string.Empty);
                    break;
            }

            strDocPend.DataSource = documentos;
            strDocPend.DataBind();
        }

        protected void PrepararEnvio(object sender, DirectEventArgs e)
        {
            txtGuia.Clear();
            dateEnvio.Clear();
            cmbPaqueteria.ClearValue();

            wndDatosEnvio.Hidden = false;
        }

        protected void RealizarEnvio(object sender, DirectEventArgs e)
        {
            string noGuia = txtGuia.Text;
            string fechaEnvio = dateEnvio.Text;
            int idPaqueteria = Convert.ToInt32(cmbPaqueteria.SelectedItem.Value);

            foreach (SelectedRow envio in smDocumentos.SelectedRows)
            {
                int idDocumentacion = Convert.ToInt32(envio.RecordID);

                Error err = reportesDA.InsertDocumentacionDA(0, idPaqueteria, fechaEnvio, noGuia, idDocumentacion);

                if (err.Valor)
                    X.Msg.Alert("Alerta", err.Mensaje).Show();
            }

            wndDatosEnvio.Hidden = true;

            ActualizarSiniestros();
        }
    }
}