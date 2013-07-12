using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using System.Text;


namespace SDA.App
{
    public partial class AnalisisReclamo : System.Web.UI.Page
    {
        wsConsultaDatos2.wsConsultaSiniestros reclamos = new wsConsultaDatos2.wsConsultaSiniestros();

        wsConsultaDatosBen.DatosSocio datossocio = new wsConsultaDatosBen.DatosSocio();
        wsConsultaDatosBen.wsConsultaBeneficios datosSoc = new wsConsultaDatosBen.wsConsultaBeneficios();


        string idReclamo;
        int Op;


        protected void Page_Load(object sender, EventArgs e)
        {
            this.strReclamo.DataSource = new List<wsConsultaDatos2.ConsultaReclamo>();
            if (!X.IsAjaxRequest)
            {
                this.strReclamo.DataBind();
            }
        }

        protected void btnBuscarSiniestros_Click(object sender, DirectEventArgs e)
        {
            if (this.txtNumSocio.Text != "")
            {
                Op = 2;
            }
            else
            {
                Op = 1;
            }
            List<wsConsultaDatos2.ConsultaReclamoGeneral> consultareclamosdetalle =
                new List<wsConsultaDatos2.ConsultaReclamoGeneral>(reclamos.ConsultaReclamosGeneral(Convert.ToInt32(this.cbSucursal.SelectedItem.Value), Op, this.txtNumSocio.Text));
            this.strReclamosGral.DataSource = consultareclamosdetalle;
            this.strReclamosGral.DataBind();
            this.txtNumSocio.Text = "";
        }


        protected void CellAnalisisSiniestro_Click(object sender, DirectEventArgs e)
        {
            RowSelectionModel sm = this.gplAnalisis.SelectionModel.Primary as RowSelectionModel;
            StringBuilder sb = new StringBuilder();

            foreach (SelectedRow row in sm.SelectedRows)
            {
                sb.AppendFormat(row.RecordID);
            }

            idReclamo = sb.ToString();

            Session["IdRec"] = Convert.ToInt32(idReclamo);

            datossocio = datosSoc.CargaDatosSocio(idReclamo);
            this.lblNombreSocio.Text = datossocio.Nombre;
            this.lblNumeroSocio.Text = datossocio.NumSocio;
            this.lblOcupacionSocio.Text = datossocio.Ocupacion;
            this.lblSucursalSocio.Text = datossocio.Sucursal;
            this.lblNumeroSiniestro.Text = datossocio.NumReclamo;
            this.lblPlaza.Text = datossocio.Plaza;
            this.lblCooperativa.Text = datossocio.Cooperativa;
            this.lblEstadoBeneficio.Text = datossocio.EstadoBeneficio;
            this.wdwInformacionSiniestro.Show();

        }
                
        protected void btnAceptarAnalisis_Click(object sender, DirectEventArgs e)
        {
            if (Session["IdRec"] != null)
            {
                Response.Redirect("AnalisisEspecifico.aspx", true); ; //aqui 
            }
        }

        //protected void btnBuscarSiniestrosMod_Click(object sender, DirectEventArgs e)
        //{
        //    if (this.txtNoSocio.Text != "")
        //    {
        //        Op = 2;
        //    }
        //    else
        //    {
        //        Op = 1;
        //    }
        //    List<ConsultaBeneficios.wsConsultaDatos2.ConsultaReclamoGeneral> consultareclamosgeneral =
        //        new List<ConsultaBeneficios.wsConsultaDatos2.ConsultaReclamoGeneral>(reclamos.ConsultaReclamosGeneral(Convert.ToInt32(this.cbScl.SelectedItem.Value),Op,this.txtNoSocio.Text));
        //    this.strReclamosGral.DataSource = consultareclamosgeneral;
        //    this.strReclamosGral.DataBind();
        //}

        //protected void CellSiniestroModificar_Click(object sender, DirectEventArgs e)
        //{
        //    RowSelectionModel sm = this.gplAnalisisModificar.SelectionModel.Primary as RowSelectionModel;
        //    StringBuilder sb = new StringBuilder();

        //    foreach (SelectedRow row in sm.SelectedRows)
        //    {
        //        sb.AppendFormat(row.RecordID);
        //    }

        //    idReclamo = sb.ToString();

        //    Session["IdRec"] = Convert.ToInt32(idReclamo);

        //    Response.Redirect("AnalisisEspecifico.aspx", true); ; //aqui

        //}




       
    }
}