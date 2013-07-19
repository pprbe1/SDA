using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using System.Text;
using System.IO;
using SDA.wsConsultaReportesDA;

namespace SDA.App
{
    public partial class AnalisisReclamo : System.Web.UI.Page
    {
        wsConsultaReportesDA.wsConsultaReportesDA reportesDA = new wsConsultaReportesDA.wsConsultaReportesDA();
        wsInsercionDatosBen.wsInsertaDatosBeneficios insertaDatos = new wsInsercionDatosBen.wsInsertaDatosBeneficios();

        byte[] DOCUMENTOS_OBLIGATORIOS = new byte[] { 1, 2, 3, 4, 7, 8, 10, 11, 12, 13, 14 };

        protected void BuscarSiniestros(object sender, DirectEventArgs e)
        {
            if (txtNumSocio.Text != string.Empty)
            {
                Session["Operacion"] = 3;
                Session["Entidad"] = txtNumSocio.Text;
            }
            else
            {
                Session["Operacion"] = 1;
                Session["Entidad"] = cmbSucursal.SelectedItem.Value;
            }

            ActualizarSiniestros();
        }

        private void ActualizarSiniestros()
        {
            int operacion = Convert.ToInt32(Session["Operacion"]);
            int entidad = Convert.ToInt32(Session["Entidad"]);

            wsConsultaReportesDA.Siniestro[] siniestros;

            siniestros = reportesDA.Siniestros(operacion, entidad);

            this.strReclamosGral.DataSource = siniestros;
            this.strReclamosGral.DataBind();
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

            Error err = reportesDA.UpdateFechaRecDocuDA(noDocumentacion, fechaRecibo);

            dateRecibo.SelectedDate = DateTime.Now;

            wndRecibo.Hide();
        }

        private byte[] GetFileBytes()
        {
            string noSiniestro = Session["IdSiniestro"].ToString();
            string noGuia = Session["NoGuia"].ToString();

            return insertaDatos.GetFileForSiniestro(noSiniestro, noGuia, ".pdf");
        }

        protected void InformacionSiniestro(object sender, DirectEventArgs e)
        {
            int idSocio = Convert.ToInt32(e.ExtraParams["ID"]);

            Siniestro[] siniestro = reportesDA.Siniestros(4, idSocio);

            SaveSessionVarsFor(siniestro[0]);

            dspNombreSocio.Text = siniestro[0].Nombre;
            dspNumeroSocio.Text = siniestro[0].NoSocio;
            dspOcupacionSocio.Text = siniestro[0].Ocupacion;
            dspSucursal.Text = siniestro[0].Sucursal;
            dspNumeroSiniestro.Text = siniestro[0].NoSiniestro;
            dspPlaza.Text = siniestro[0].Plaza;
            dspCooperativa.Text = siniestro[0].Coop;

            cmbEstadoSin.SetRawValue(siniestro[0].StatusSiniestro);

            btnGuardarEstadoSin.Disabled = true;

            int noSiniestro = Convert.ToInt32(Session["IdSiniestro"]);

            BitacoraSiniestro(noSiniestro);
            ArchivosSiniestro(noSiniestro);

            RestaurarArchivos(null, null);
            RestaurarBitacora(null, null);

            this.wndInformacionSiniestro.Show();
        }

        protected void UpdateEstadoSiniestro(object sender, DirectEventArgs e)
        {
            int noSiniestro = Convert.ToInt32(Session["IdSiniestro"]);
            int noEstadoSin = Convert.ToInt32(e.ExtraParams["EstadoSin"]);

            Error err = reportesDA.UpdateStatusSiniestroDA(noSiniestro, noEstadoSin);

            btnGuardarEstadoSin.Disabled = true;

            ActualizarSiniestros();
        }

        private void SaveSessionVarsFor(Siniestro siniestro)
        {
            Session["NoSocio"] = siniestro.NoSocio;
            Session["IdSiniestro"] = siniestro.NoSiniestro;
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

            RestaurarArchivos(null, null);

            Bitacora[] archivos = reportesDA.Bitacoras(7, idEnvio);

            foreach (Bitacora documento in archivos)
            {
                Checkbox chk = ComponentManager.Get<Checkbox>("chkDoc" + documento.TipoDoc);

                chk.Checked = true;
            }
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

        
        protected void InsertarBitacora(object sender, DirectEventArgs e)
        {
            Session["Usuario"] = "1"; //este vato es Administrador Prybe S.C.

            int idUsuario = Convert.ToInt32(Session["Usuario"]);
            int noSiniestro = Convert.ToInt32(Session["IdSiniestro"]);

            Error err = reportesDA.InsertBitacoraDA(noSiniestro, 1, idUsuario, txtBitacora.RawValue.ToString());

            if (err.Valor) X.MessageBox.Alert("Alerta", err.Mensaje).Show();

            BitacoraSiniestro(noSiniestro);

            RestaurarBitacora(null, null);
        }

        protected void InsertarEnvio(object sender, DirectEventArgs e)
        {
            if (VerifyCheckList())
            {
                int noSiniestro = Convert.ToInt32(Session["IdSiniestro"]);
                int idPaqueteria = Convert.ToInt32(cmbPaqueteria.Value);

                string extension = System.IO.Path.GetExtension(fileSelector.FileName);

                insertaDatos.UploadFileForSiniestros(fileSelector.FileBytes, noSiniestro.ToString(), txtGuia.Text, extension);

                //Hasta aquí se ha insertado correctamente el archivo, procedemos a insertar los datos del envío a la base de datos

                Error ret = reportesDA.InsertDocumentacionDA(noSiniestro, idPaqueteria, dateEnvio.SelectedDate.ToShortDateString(), txtGuia.Text);

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
    }
}