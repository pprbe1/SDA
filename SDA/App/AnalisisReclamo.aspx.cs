using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using System.Text;
using SDA.wsConsultaReportesDA;

namespace SDA.App
{
    public partial class AnalisisReclamo : System.Web.UI.Page
    {
        wsConsultaReportesDA.wsConsultaReportesDA reportesDA = new wsConsultaReportesDA.wsConsultaReportesDA();
        wsInsercionDatosBen.wsInsertaDatosBeneficios insertaDatos = new wsInsercionDatosBen.wsInsertaDatosBeneficios();

        protected void BuscarSiniestros(object sender, DirectEventArgs e)
        {
            wsConsultaReportesDA.Siniestro[] siniestros;
            int operacion;
            int entidad;

            if (txtNumSocio.Text != string.Empty)
            {
                operacion = 3;
                entidad = Convert.ToInt32(txtNumSocio.Text);
            }
            else
            {
                operacion = 1;
                entidad = Convert.ToInt32(cmbSucursal.SelectedItem.Value);
            }

            siniestros = reportesDA.Siniestros(operacion, entidad);

            this.strReclamosGral.DataSource = siniestros;
            this.strReclamosGral.DataBind();
        }

        protected void UploadFile(object sender, DirectEventArgs e)
        {
            byte[] bytes = fileSelector.FileBytes;
            string noSiniestro = Session["NoSiniestro"].ToString();
            string noGuia = txtGuia.Text;
            string extension = System.IO.Path.GetExtension(fileSelector.FileName);

            insertaDatos.UploadFileForSiniestros(bytes, noSiniestro, noGuia, extension);
        }

        protected void InformacionSiniestro(object sender, DirectEventArgs e)
        {
            int idSocio = Convert.ToInt32(e.ExtraParams["ID"]);
            
            Siniestro[] siniestro = reportesDA.Siniestros(4, idSocio);

            SaveSessionVarsFor(siniestro[0]);

            this.lblNombreSocio.Text = siniestro[0].Nombre;
            this.lblNumeroSocio.Text = siniestro[0].NoSocio;
            this.lblOcupacionSocio.Text = siniestro[0].Ocupacion;
            this.lblSucursalSocio.Text = siniestro[0].Sucursal;
            this.lblNumeroSiniestro.Text = siniestro[0].NoSiniestro;
            this.lblPlaza.Text = siniestro[0].Plaza;
            this.lblCooperativa.Text = siniestro[0].Coop;
            //this.cmbEstadoBeneficio.Text = datossocio.EstadoBeneficio;

            int noSiniestro = Convert.ToInt32(Session["NoSiniestro"]);

            BitacoraSiniestro(noSiniestro);
            ArchivosSiniestro(noSiniestro);

            this.wndInformacionSiniestro.Show();
        }

        private void SaveSessionVarsFor(Siniestro siniestro)
        {
            Session["NoSocio"] = siniestro.NoSocio;
            Session["NoSiniestro"] = siniestro.NoSiniestro;
            Session["NoEstado"] = siniestro.StatusSiniestro;
        }

        private void BitacoraSiniestro(int noSiniestro)
        {
            Bitacora[] bitacora = reportesDA.Bitacoras(5, noSiniestro);

            strBitacora.DataSource = bitacora;
            strBitacora.DataBind();
        }

        private void ArchivosSiniestro(int noSiniestro)
        {
            Bitacora[] archivos = reportesDA.Bitacoras(6, noSiniestro);

            strEnvio.DataSource = archivos;
            strEnvio.DataBind();
        }

        protected void DocumentosEnvio(object sender, DirectEventArgs e)
        {
            int idEnvio = Convert.ToInt32(e.ExtraParams["ID"]);

            Bitacora[] archivo = reportesDA.Bitacoras(7, idEnvio);

            foreach (Bitacora documento in archivo)
            {
                Checkbox chk = ComponentManager.Get("chkDoc" + documento.TipoDoc) as Checkbox;

                chk.Checked = true;
            }
        }

        protected void NuevaBitacora(object sender, DirectEventArgs e)
        {
            int idSiniestro = Convert.ToInt32(Session["NoSiniestro"]);

            grdBitacora.Disabled = true;
            txtBitacora.SetValue(string.Empty);
            txtBitacora.ReadOnly = false;
            btnGuardarBitacora.Hidden = false;
            btnCancelarBitacora.Hidden = false;
        }

        protected void NuevoEnvio(object sender, DirectEventArgs e)
        {
            grdArchivos.Disabled = true;

            for(int i = 1; i<17; i++)
            {
                Checkbox chk = ComponentManager.Get("chkDoc" + i.ToString()) as Checkbox;
                chk.Value = 0;
                chk.ReadOnly = false;
            }

            dateEnvio.ReadOnly = false;
            fileSelector.ReadOnly = false;
            txtGuia.ReadOnly = false;
            cmbPaqueteria.ReadOnly = false;

            btnGuardarArchivo.Hidden = false;
            btnCancelarArchivo.Hidden = false;
        }

        protected void RestaurarBitacora(object sender, DirectEventArgs e)
        {
            grdBitacora.Disabled = false;
            txtBitacora.SetValue(string.Empty);
            txtBitacora.ReadOnly = true;
            btnGuardarBitacora.Hidden = true;
            btnCancelarBitacora.Hidden = true;
        }

        protected void RestaurarArchivos(object sender, DirectEventArgs e)
        {
            grdArchivos.Disabled = false;

            for (int i = 1; i < 17; i++)
            {
                Checkbox chk = ComponentManager.Get("chkDoc" + i.ToString()) as Checkbox;
                chk.Value = 0;
                chk.ReadOnly = true;
            }

            dateEnvio.ReadOnly = true;
            fileSelector.ReadOnly = true;
            txtGuia.ReadOnly = true;
            cmbPaqueteria.ReadOnly = true;

            btnGuardarArchivo.Hidden = true;
            btnCancelarArchivo.Hidden = true;
        }

        protected void InsertarBitacora(object sender, DirectEventArgs e)
        {
            int noSiniestro = Convert.ToInt32(Session["NoSiniestro"]);

            reportesDA.InsertBitacoraDA(noSiniestro, 0, 0, txtBitacora.Text);
        }

        protected void InsertarEnvio(object sender, DirectEventArgs e)
        {
            int noSiniestro = Convert.ToInt32(Session["NoSiniestro"]);
            int idPaqueteria = Convert.ToInt32(cmbPaqueteria.Value);

            reportesDA.InsertDocumentacionDA(noSiniestro, idPaqueteria, dateEnvio.Text, txtGuia.Text);
        }
    }
}