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

        byte[] DOCUMENTOS_OBLIGATORIOS = new byte[] { 1, 2, 3, 4, 7, 8, 10, 11, 12, 13, 14 };

        DateTime fechaNac = new DateTime();
        DateTime fechaIng = new DateTime();

        string noSocio, idSucursal, idDocumento;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void NuevoEnvio(object sender, DirectEventArgs e)
        {
            grdArchivos.Disabled = true;

            for (int i = 1; i < 17; i++)
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

        private byte[] GetFileBytes()
        {
            string noSiniestro = Session["IdSiniestro"].ToString();
            string noGuia = Session["NoGuia"].ToString();

            return documento.GetFileForSiniestro(noSiniestro, noGuia, ".pdf");
        }

        protected void InsertarEnvio(object sender, DirectEventArgs e)
        {
            if (VerifyCheckList())
            {
                int noSiniestro = Convert.ToInt32(Session["IdSiniestro"]);
                int idPaqueteria = Convert.ToInt32(cmbPaqueteria.SelectedItem.Value); //

                string extension = System.IO.Path.GetExtension(fileSelector.FileName);

                documento.UploadFileForSiniestros(fileSelector.FileBytes, noSiniestro.ToString(), txtGuia.Text, extension);

                //Hasta aquí se ha insertado correctamente el archivo, procedemos a insertar los datos del envío a la base de datos

                wsConsultaReportesDA.Error ret = reportesDA.InsertDocumentacionDA(noSiniestro, idPaqueteria, dateEnvio.SelectedDate.ToShortDateString(), txtGuia.Text);

                int idDocumentacion = 0;

                //Hasta aquí se ha insertado la entrada del envío en la base de datos. El procedimiento devuelve el número del envío y procedemos a
                //insertar en la base de datos los documentos especificos enviados

                if (int.TryParse(ret.Mensaje, out idDocumentacion))
                {
                    string loopRet = LoopThroughEachCheckBoxAndInsertThemInToTheDataBaseBecauseNoArrays(idDocumentacion);

                    if (loopRet != string.Empty) X.MessageBox.Alert("Error al insertar datos", loopRet);

                    ArchivosSiniestro(noSiniestro);

                    RestaurarArchivos(null, null);
                }
                else
                {
                    X.MessageBox.Alert("Alerta", "Ocurrio un problema al insertar los detalles del documento");
                }
            }
            else
            {
                X.MessageBox.Alert("Documentos de envío", "No has enviado el minimo de documentos obligatorios para el reclamo del siniestro").Show();
            }
        }

        private void ArchivosSiniestro(int noSiniestro)
        {
            Bitacora[] archivos = reportesDA.Bitacoras(6, noSiniestro);

            strEnvio.DataSource = archivos;
            strEnvio.DataBind();

            wd_SiniestroAsignado.Show();
        }

        private bool VerifyCheckList()
        {
            foreach (byte id in DOCUMENTOS_OBLIGATORIOS)
            {
                Checkbox chk = ComponentManager.Get<Checkbox>("chkDoc" + id);

                if (!chk.Checked) return false;
            }

            return true;
        }

        private string LoopThroughEachCheckBoxAndInsertThemInToTheDataBaseBecauseNoArrays(int idDocumentacion)
        {
            for (int i = 1; i < 17; i++)
            {
                Checkbox chk = ComponentManager.Get("chkDoc" + i.ToString()) as Checkbox;

                if (chk.Checked)
                {
                    wsConsultaReportesDA.Error err = reportesDA.InsertDetDocuDA(i, idDocumentacion);

                    if (err.Valor) return err.Mensaje;
                }
            }

            return string.Empty; //fix this bad behavior
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
            dateEnvio.Clear();
            fileSelector.ReadOnly = true;
            fileSelector.Clear();
            txtGuia.ReadOnly = true;
            txtGuia.Clear();
            cmbPaqueteria.ReadOnly = true;
            cmbPaqueteria.ClearValue();

            btnGuardarArchivo.Hidden = true;
            btnCancelarArchivo.Hidden = true;
        }

        protected void DocumentosEnvio(object sender, DirectEventArgs e)
        {
            int idEnvio = Convert.ToInt32(e.ExtraParams["ID"]);

            RestaurarArchivos(null, null);

            Bitacora[] archivos = reportesDA.Bitacoras(7, idEnvio);

            foreach (Bitacora documento in archivos)
            {
                Checkbox chk = ComponentManager.Get<Checkbox>("chkDoc" + documento.TipoDoc);

                chk.Checked = true;
            }
        }

        protected void CommandArchivos(object sender, DirectEventArgs e)
        {
            Session["NoGuia"] = e.ExtraParams["NoGuia"];

            string cmd = e.ExtraParams["Command"];

            switch (cmd)
            {
                case "Ver":
                    wndPDF.Hidden = false;
                    wndPDF.Loader.LoadContent();
                    break;

                case "Descargar":
                    Response.Clear();
                    Response.AppendHeader("content-disposition", "attachment; filename=" + Session["NoGuia"] + ".pdf");
                    Response.ContentType = "application/octet-stream";
                    Response.BinaryWrite(GetFileBytes());
                    Response.End();
                    break;
                case "Recibo":
                    int noSiniestro = Convert.ToInt32(Session["IdSiniestro"]);
                    int noDocumentacion = Convert.ToInt32(e.ExtraParams["NoDocumentacion"]);

                    Session["NoDocumentacion"] = e.ExtraParams["NoDocumentacion"];

                    Bitacora[] siniestros = reportesDA.Bitacoras(6, noSiniestro);

                    foreach (Bitacora siniestro in siniestros)
                    {
                        int tmp = Convert.ToInt32(siniestro.IdDocumentacion);

                        if (tmp == noDocumentacion)
                        {
                            DateTime date = DateTime.Now;

                            bool ret = DateTime.TryParse(siniestro.FechaReclamo, out date);

                            if (ret)
                            {
                                X.MessageBox.Alert("Fecha de Recibo", "El documento se recibio el: " + siniestro.FechaReclamo).Show();
                            }
                            else
                            {
                                dateRecibo.SelectedDate = date;

                                wndRecibo.Show();
                            }

                            return;
                        }
                    }
                    break;
            }
        }

        protected void UpdateFechaRecibo(object sender, DirectEventArgs e)
        {
            int noDocumentacion = Convert.ToInt32(Session["NoDocumentacion"]);
            string fechaRecibo = e.ExtraParams["FechaRecibo"].ToString();

            wsConsultaReportesDA.Error err = reportesDA.UpdateFechaRecDocuDA(noDocumentacion, fechaRecibo);

            dateRecibo.SelectedDate = DateTime.Now;

            wndRecibo.Hide();
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
                    this.paneArchivos.Disabled = false;
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