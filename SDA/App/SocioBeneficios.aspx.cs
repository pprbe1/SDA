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
using SDA.wsInsercionDatosBen;
using SDA.wsConsultaReportesDA;

namespace SDA.App
{
    public partial class SocioBeneficios : System.Web.UI.Page
    {
        wsInsercionDatosBen.wsInsertaDatosBeneficios socio = new wsInsercionDatosBen.wsInsertaDatosBeneficios();
        wsConsultaDatosBen.DatosSocioAlta datsocio = new wsConsultaDatosBen.DatosSocioAlta();
        wsConsultaDatosBen.wsConsultaBeneficios llamada = new wsConsultaDatosBen.wsConsultaBeneficios();

        wsInsercionDatosBen.wsInsertaDatosBeneficios documento = new wsInsercionDatosBen.wsInsertaDatosBeneficios();
        wsConsultaDatos2.wsConsultaSiniestros cdocumento = new wsConsultaDatos2.wsConsultaSiniestros();

        wsConsultaReportesDA.wsConsultaReportesDA reportesDA = new wsConsultaReportesDA.wsConsultaReportesDA();

        wsInsercionDatosBen.Error ErrorOper = new wsInsercionDatosBen.Error();
        wsCPM.wsPrybeCPM SocioCPM = new wsCPM.wsPrybeCPM();
        wsCPM.SocioCPM ConsultaSocioCPM = new wsCPM.SocioCPM();

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
                Session["NumeroSocio"] = txtNumSocio.Text;
                Session["Sucursal"] = cmbSucursal.SelectedItem.Value;
                //datsocio = llamada.CargaDatosSocioAlta(this.txtNumSocio.Text, this.cmbSucursal.SelectedItem.Value);
                ConsultaSocioCPM = SocioCPM.ObtenSocioCPM(txtNumSocio.Text, "PRYBE");
                if (!this.txtNumSocio.IsEmpty)
                {
                    Habilitar_CamposSocio();
                    btnModificarSocio.Disabled = false;
                    //btnSiguiente.Disabled = true;
                    txtNumSocio.Disabled = true;

                    this.txtNombre.Text = ConsultaSocioCPM.PrimerNombre;
                    this.txtNombre2.Text = ConsultaSocioCPM.SegundoNombre;
                    this.txtApellidoPat.Text = ConsultaSocioCPM.PrimerApellido;
                    this.txtApellidoMat.Text = ConsultaSocioCPM.SegundoApellido;
                    fechaNac = Convert.ToDateTime(ConsultaSocioCPM.FechaNacimiento);
                    this.dteFechaN.Text = fechaNac.ToString("dd/MM/yyyy");
                    fechaIng = Convert.ToDateTime(ConsultaSocioCPM.FechaIngreso);
                    this.dteFechaI.Text = fechaIng.ToString("dd/MM/yyyy");
                    if (ConsultaSocioCPM.Sexo == true)
                    {
                        this.rdoMasculino.Checked = true;
                    }
                    else
                    {
                        this.rdoFemenino.Checked = true;
                    }
                    cmbEdoCivil.Select(0);
                    switch (ConsultaSocioCPM.EstadoCivil)
                    {
                        case "C":
                            cmbEdoCivil.Select(0);
                            break;

                        case "D":
                            cmbEdoCivil.Select(3);
                            break;

                        case "L":
                            cmbEdoCivil.Select(4);
                            break;

                        case "S":
                            cmbEdoCivil.Select(1);
                            break;

                        case "V":
                            cmbEdoCivil.Select(2);
                            break;
                    }
                    this.txtCP.Text = ConsultaSocioCPM.CP;
                    this.txtCalle.Text = ConsultaSocioCPM.Calle;
                    this.txtNoExt.Text = ConsultaSocioCPM.NoExterior;
                    this.txtNoInt.Text = ConsultaSocioCPM.NoInterior;
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
                X.Get("maskDiv").AddCls("x-hide-display");
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
            
            if (this.txtNombre.Text != "" && this.txtApellidoPat.Text != "" && this.dteFechaN.Text != ""
               && this.dteFechaI.Text != "" && this.txtCalle.Text != "" && this.txtNoExt.Text != "")
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

                    ErrorOper = socio.InsertSocioBeneficio(Convert.ToString(Session["NumeroSocio"]), this.txtNombre.Text.ToUpper(), this.txtNombre2.Text.ToUpper(), this.txtApellidoPat.Text.ToUpper(),
                                   this.txtApellidoMat.Text.ToUpper(), fechaNac.ToString("dd/MM/yyyy"), fechaIng.ToString("dd/MM/yyyy"), (int)(Session["Sexo"]), "", "", "",
                                   Convert.ToInt32(this.cmbOcupacion.SelectedItem.Value), Convert.ToInt32(this.cmbEdoCivil.SelectedItem.Value),
                                   Convert.ToInt32(Session["Sucursal"]), Convert.ToString(ano), 1, this.txtCalle.Text.ToUpper(),
                                   this.txtNoExt.Text.ToUpper(), this.txtNoInt.Text.ToUpper(), 1);

                    Session["IdSiniestro"] = dfNumeroSiniestro2.Text = ErrorOper.Mensaje;
                    this.paneLol.Disabled = false;
                    this.pnlSocio.Disabled = true;
                }
                this.btnCancelarRegistroSocio.Disabled = true;
                this.btnModificarSocio.Disabled = true;
                //pnlAgregarDocumentacion.Disabled = false;
            }
            else
            {
                X.Msg.Alert("Aviso", "Faltan algunos campos de llenado").Show();
            }
        }


        protected void btnAceptarPaqueterias_DirectClick(object sender, Ext.Net.DirectEventArgs e)
        {

        }

        protected void btnAceptarNumSin_Click(object sender, DirectEventArgs e)
        {
            wd_SiniestroAsignado.Hide();
        }


        protected void btnModificarDatos_Click(object sender, DirectEventArgs e)
        {
            this.pnlSocio.Disabled = false;
            this.btnModificarSocio.Disabled = false;

            //this.pnlAgregarDocumentacion.Disabled = true;
        }

        protected void btnBuscaCP_DirectClick(object sender, DirectEventArgs e)
        {
            bool cpcheck;
            //X.Get("maskDiv").AddCls("x-hide-display");//Oculta la máscara de bloqueo de pantalla
            cpcheck = true;
            Session["BuscaCP"] = cpcheck;
        }
        protected void btnCancelarRegistroSocio_DirectClick(object sneder, DirectEventArgs e)
        {
            Limpia_CamposSocio();
            //this.btnSiguiente.Disabled = true;
            this.btnModificarSocio.Disabled = true;
            this.fcNumSocio.Disabled = false;
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
            this.cbEstado.Disabled = true;
            this.cbMunicipio.Disabled = true;
            this.cbColonia.Disabled = true;
            this.txtCP.Disabled = true;
            this.btnBuscaCP.Disabled = true;
            this.txtCalle.Disabled = true;
            this.txtNumSocio.Text = "";
            this.cfCP.Disabled = true;
            this.btnCancelarRegistroSocio.Disabled = true;
        }


        protected void btnAgregarDocumento_Click(object sender, DirectEventArgs e)
        {

            //ErrorOper = documento.InsertDocumento(Convert.ToInt32(this.cmbDocumentos.SelectedItem.Value), (int)(Session["Id_Sucursal"]),
              //                           Convert.ToString(Session["No_Socio"]), 1);

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
            this.cbEstado.Disabled = false;
            this.cbMunicipio.Disabled = false;
            this.cbColonia.Disabled = false;
            this.txtCP.Disabled = false;
            this.btnBuscaCP.Disabled = false;
            this.fcNumero.Disabled = false;
            this.cfCP.Disabled = false;
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
            this.txtCP.Text = "";
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