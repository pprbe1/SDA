using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using Ext.Net;
using System.Text;
using System.Web.Configuration;


namespace SDA.App
{
    public partial class SocioBeneficios : System.Web.UI.Page
    {
        wsInsercionDatosBen.wsInsertaDatosBeneficios socio = new wsInsercionDatosBen.wsInsertaDatosBeneficios();
        wsConsultaDatosBen.DatosSocioAlta datsocio = new wsConsultaDatosBen.DatosSocioAlta();
        wsConsultaDatosBen.wsConsultaBeneficios llamada = new wsConsultaDatosBen.wsConsultaBeneficios();

        wsInsercionDatosBen.wsInsertaDatosBeneficios documento = new wsInsercionDatosBen.wsInsertaDatosBeneficios();
        wsConsultaDatos2.wsConsultaSiniestros cdocumento = new wsConsultaDatos2.wsConsultaSiniestros();

        wsInsercionDatosBen.Error ErrorOper = new wsInsercionDatosBen.Error();

        DateTime fechaNac = new DateTime();
        DateTime fechaIng = new DateTime();

        string noSocio, idSucursal, idDocumento;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnBuscaSocio_Click(object sender, EventArgs e)
        {
            this.btnModificarSocio.Disabled = false;
            this.btnCancelarRegistroSocio.Disabled = false;
            if (!this.txtNumSocio.IsEmpty)
            {

                datsocio = llamada.CargaDatosSocioAlta(this.txtNumSocio.Text, this.cmbSucursal.SelectedItem.Value);
                if (datsocio.NumSocio == this.txtNumSocio.Text && datsocio.Sucursal == this.cmbSucursal.SelectedItem.Value)
                {
                    Habilitar_CamposSocio();
                    btnModificarSocio.Disabled = false;
                    //btnSiguiente.Disabled = true;
                    txtNumSocio.Disabled = true;

                    this.txtNombre.Text = datsocio.Nombre;
                    this.txtNombre2.Text = datsocio.Nombre2;
                    this.txtApellidoPat.Text = datsocio.ApellidoPat;
                    this.txtApellidoMat.Text = datsocio.ApellidoMat;
                    fechaNac = Convert.ToDateTime(datsocio.FechaNac);
                    this.dteFechaN.Text = fechaNac.ToString("dd/MM/yyyy");
                    fechaIng = Convert.ToDateTime(datsocio.FechaIng);
                    this.dteFechaI.Text = fechaIng.ToString("dd/MM/yyyy");
                    if (datsocio.Sexo == true)
                    {
                        this.rdoMasculino.Checked = true;
                    }
                    else
                    {
                        this.rdoFemenino.Checked = true;
                    }
                    this.cmbOcupacion.SelectedItem.Value = datsocio.Ocupacion;
                    this.cmbEdoCivil.SelectedItem.Value = datsocio.EdoCivil;
                    this.txtCalle.Text = datsocio.Calle;
                    this.txtNoExt.Text = datsocio.NumExt;
                    this.txtNoInt.Text = datsocio.NumInt;
                    this.cmbPaqueteria.SelectedItem.Value = datsocio.IdPaqueteria;
                    this.txtGuia.Text = datsocio.NumeroGuia;
                }
                else
                {
                    Limpia_CamposSocio();
                }
                Habilitar_CamposSocio();
                this.txtNumSocio.Disabled = true;
                this.cmbCoop.Disabled = true;
                this.cmbPlaza.Disabled = true;
                this.cmbSucursal.Disabled = true;
            }
            else
            {
                X.MessageBox.Alert("Aviso", "No has ingresado el número de socio").Show();
            }
        }


        //protected void btnSiguienteSocio_Click(object sender, EventArgs e)
        //{
        //    if (this.txtNumSocio.Text != "" && this.txtNombre.Text != "" && this.txtApellidoPat.Text != "" && this.dteFechaN.Text != ""
        //        && this.dteFechaI.Text != "" && this.txtCalle.Text != "" && this.txtNoExt.Text != "")
        //    {
        //        this.pnlPaqueteria1.Disabled = false;
        //        this.pnlPaqueteria2.Disabled = false;
        //        this.pnlPaqueteria3.Disabled = false;
        //        this.btnCancelarRegistroSocio.Disabled = true;
        //    }
        //    else
        //    {
        //        X.Msg.Alert("Aviso", "Faltan algunos campos de llenado").Show();
        //    }
        //}

        protected void btnModificarSocio_DirectClick(object sender, Ext.Net.DirectEventArgs e)
        {
            this.btnModificarSocio.Disabled = true;
            if (this.txtNumSocio.Text != "" && this.txtNombre.Text != "" && this.txtApellidoPat.Text != "" && this.dteFechaN.Text != ""
               && this.dteFechaI.Text != "" && this.txtCalle.Text != "" && this.txtNoExt.Text != "")
            {
                this.btnCancelarRegistroSocio.Disabled = true;
                pnlAgregarDocumentacion.Disabled = false;
            }
            else
            {
                X.Msg.Alert("Aviso", "Faltan algunos campos de llenado").Show();
            }
        }


        protected void btnAceptarPaqueterias_DirectClick(object sender, Ext.Net.DirectEventArgs e)
        {

            if (this.rdoMasculino.Checked == true)
            {
                Session["Sexo"] = 1;
            }
            else
            {
                Session["Sexo"] = 0;
            }

            DateTime hoy = new DateTime();
            DateTime actual = new DateTime();
            hoy = DateTime.Now;
            actual = DateTime.Today;
            int ano = DateTime.Now.Year;
            fechaNac = Convert.ToDateTime(this.dteFechaN.Text);
            fechaIng = Convert.ToDateTime(this.dteFechaI.Text);

            if (DateTime.Compare(fechaIng, actual) > 0 || DateTime.Compare(fechaNac, actual) > 0)
            {
                X.Msg.Alert("Error", "La fecha es mayor a la actual").Show();
            }
            else
            {

                ErrorOper = socio.InsertSocioBeneficio(this.txtNumSocio.Text.ToUpper(), this.txtNombre.Text.ToUpper(), this.txtNombre2.Text.ToUpper(), this.txtApellidoPat.Text.ToUpper(),
                               this.txtApellidoMat.Text.ToUpper(), fechaNac.ToString("dd/MM/yyyy"), fechaIng.ToString("dd/MM/yyyy"), (int)(Session["Sexo"]), "", "", "",
                               Convert.ToInt32(this.cmbOcupacion.SelectedItem.Value), Convert.ToInt32(this.cmbEdoCivil.SelectedItem.Value),
                               Convert.ToInt32(this.cmbSucursal.SelectedItem.Value), Convert.ToString(ano), hoy.ToString("dd/MM/yyyy"), Convert.ToInt32(this.cmbColonia.SelectedItem.Value), this.txtCalle.Text.ToUpper(),
                               this.txtNoExt.Text.ToUpper(), this.txtNoInt.Text.ToUpper(), 1, 1, Convert.ToInt32(this.cmbPaqueteria.SelectedItem.Value), this.txtGuia.Text.ToUpper());
                if (ErrorOper.Valor == true)
                {
                    X.Msg.Alert("Aviso", "No se pudo ingresar los datos del socio, intentelo nuevamente").Show();
                }

                Session["Id_Sucursal"] = Convert.ToInt32(this.cmbSucursal.SelectedItem.Value);
                Session["No_Socio"] = Convert.ToString(this.txtNumSocio.Text.ToUpper());
                noSocio = Convert.ToString(Session["No_Socio"]);
                idSucursal = Convert.ToString(Session["Id_Sucursal"]);

                this.pnlAgregarDocumentacion.Disabled = false;
                this.pnlSocio.Disabled = true;
                Carga_CamposDocumentos();
            }
        }

        protected void btnModificarDatos_Click(object sender, DirectEventArgs e)
        {
            this.pnlSocio.Disabled = false;
            this.btnModificarSocio.Disabled = false;

            this.pnlAgregarDocumentacion.Disabled = true;
        }


        protected void btnCancelarRegistroSocio_DirectClick(object sneder, DirectEventArgs e)
        {
            Limpia_CamposSocio();
            //this.btnSiguiente.Disabled = true;
            this.btnModificarSocio.Disabled = true;
            this.btnBuscarSocio.Disabled = false;
            this.txtNumSocio.Disabled = false;
            this.cmbCoop.Disabled = false;
            this.cmbPlaza.Disabled = false;
            this.cmbSucursal.Disabled = false;
            this.dteFechaI.Disabled = true;
            this.dteFechaN.Disabled = true;
            this.fcNombres.Disabled = true;
            this.fcApellidos.Disabled = true;
            this.fcNumero.Disabled = true;
            this.rdoSexo.Disabled = true;
            this.cmbOcupacion.Disabled = true;
            this.cmbEdoCivil.Disabled = true;
            this.cmbEstado.Disabled = true;
            this.cmbMunicipio.Disabled = true;
            this.cmbColonia.Disabled = true;
            this.cmbCP.Disabled = true;
            this.txtCalle.Disabled = true;
            this.txtNumSocio.Text = "";
            this.btnCancelarRegistroSocio.Disabled = false;
        }


        protected void btnAgregarDocumento_Click(object sender, DirectEventArgs e)
        {

            ErrorOper = documento.InsertDocumento(Convert.ToInt32(this.cmbDocumentos.SelectedItem.Value), (int)(Session["Id_Sucursal"]),
                                         Convert.ToString(Session["No_Socio"]), 1);

            if (ErrorOper.Valor == true)
            {
                X.Msg.Alert("Aviso", ErrorOper.Mensaje).Show();
            }
            List<wsConsultaDatos2.ConsultaDocumentoSocio> agregado =
                new List<wsConsultaDatos2.ConsultaDocumentoSocio>(cdocumento.ConsultaDocumentos(Convert.ToString(Session["No_Socio"]), Convert.ToString(Session["Id_Sucursal"])));
            //this.strDocumentosAgregados.DataSource = agregado;
            //this.strDocumentosAgregados.DataBind();
        }

        protected void CellEliminarDocumento_Click(object sender, DirectEventArgs e)
        {
            //X.Msg.Confirm("Confirmar", "¿Eliminar documento de la lista?").Show();

            idDocumento = e.ExtraParams["IdDoc"];
            if (idDocumento != "")
            {
                Session["IdDocumento"] = Convert.ToInt32(idDocumento);
                documento.EliminarDocumento((int)(Session["IdDocumento"]), 1);
                List<wsConsultaDatos2.ConsultaDocumentoSocio> documentossocio =
                new List<wsConsultaDatos2.ConsultaDocumentoSocio>(cdocumento.ConsultaDocumentos(Convert.ToString(Session["No_Socio"]), Convert.ToString(Session["Id_Sucursal"])));
                //this.strDocumentosAgregados.DataSource = documentossocio;
                //this.strDocumentosAgregados.DataBind();
            }
            else
            {
                X.Msg.Alert("Aviso", "Seleccione primero el documento").Show();
            }
        }

        protected void btnGuardar_Click(object sender, DirectEventArgs e)
        {
            Response.Redirect("SocioBeneficios.aspx", true); ;
        }

        protected void CellSeguimientoReclamo_Click(object sender, DirectEventArgs e)
        {

        }


        public void Habilitar_CamposSocio()
        {
            this.fcNombres.Disabled = false;
            this.fcApellidos.Disabled = false;
            this.dteFechaI.Disabled = false;
            this.dteFechaN.Disabled = false;
            this.cmbOcupacion.Disabled = false;
            this.cmbEdoCivil.Disabled = false;
            this.txtCalle.Disabled = false;
            this.txtNoExt.Disabled = false;
            this.txtNoInt.Disabled = false;
            this.rdoSexo.Disabled = false;
            this.cmbEstado.Disabled = false;
            this.cmbMunicipio.Disabled = false;
            this.cmbColonia.Disabled = false;
            this.cmbCP.Disabled = false;
            this.fcNumero.Disabled = false;
            this.fcNumSocio.Disabled = true;
            //this.btnSiguiente.Disabled = false;
        }

        public void Limpia_CamposSocio()
        {
            this.txtNombre.Text = "";
            this.txtNombre2.Text = "";
            this.txtApellidoPat.Text = "";
            this.txtApellidoMat.Text = "";
            this.dteFechaN.Value = EmptyValue.EmptyString;
            this.dteFechaI.Value = EmptyValue.EmptyString;
            this.txtCalle.Text = "";
            this.txtNoInt.Text = "";
            this.txtNoExt.Text = "";
        }

        public void Carga_CamposDocumentos()
        {
            List<wsConsultaDatos2.ConsultaDocumentoSocio> documentossocio =
                new List<wsConsultaDatos2.ConsultaDocumentoSocio>(cdocumento.ConsultaDocumentos(Convert.ToString(Session["No_Socio"]), Convert.ToString(Session["Id_Sucursal"])));
            //this.strDocumentosAgregados.DataSource = documentossocio;
            //this.strDocumentosAgregados.DataBind();
        }
    }
}