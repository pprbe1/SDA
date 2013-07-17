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

            Session["IdSocio"] = idSocio;
            Session["NoSiniestro"] = siniestro[0].NoSiniestro;

            this.lblNombreSocio.Text = siniestro[0].Nombre;
            this.lblNumeroSocio.Text = siniestro[0].NoSocio;
            this.lblOcupacionSocio.Text = siniestro[0].Ocupacion;
            this.lblSucursalSocio.Text = siniestro[0].Sucursal;
            this.lblNumeroSiniestro.Text = siniestro[0].NoSiniestro;
            this.lblPlaza.Text = siniestro[0].Plaza;
            this.lblCooperativa.Text = siniestro[0].Coop;
            //this.cmbEstadoBeneficio.Text = datossocio.EstadoBeneficio;
            this.wndInformacionSiniestro.Show();
        }

        protected void BitacoraSiniestro(object sender, DirectEventArgs e)
        {

        }

        protected void ArchivosSiniestro(object sender, DirectEventArgs e)
        {

        }
    }
}