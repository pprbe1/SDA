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
    public partial class FileUploadBit : System.Web.UI.UserControl
    {
        wsConsultaReportesDA.wsConsultaReportesDA reportesDA = new wsConsultaReportesDA.wsConsultaReportesDA();
        wsInsercionDatosBen.wsInsertaDatosBeneficios insertaDatos = new wsInsercionDatosBen.wsInsertaDatosBeneficios();

        public bool CanEdit { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        [DirectMethod]
        public void CargarArchivos()
        {
            int noSiniestro = Convert.ToInt32(Session["IdSiniestro"]);
            ArchivosSiniestro(noSiniestro);
        }

        protected void UpdateFechaRecibo(object sender, DirectEventArgs e)
        {
            if (!CanEdit) return;

            int noDocumentacion = Convert.ToInt32(Session["NoDocumentacion"]);
            string fechaRecibo = e.ExtraParams["FechaRecibo"].ToString();

            Error err = reportesDA.UpdateFechaRecDocuDA(noDocumentacion, fechaRecibo);

            dateRecibo.SelectedDate = DateTime.Now;

            wndRecibo.Hide();
        }

        private void ArchivosSiniestro(int noSiniestro)
        {
            Bitacora[] archivos = reportesDA.Bitacoras(6, noSiniestro);

            strEnvio.DataSource = archivos;
            strEnvio.DataBind();
        }

        protected void InsertarEnvio(object sender, DirectEventArgs e)
        {
            int noSiniestro = Convert.ToInt32(Session["IdSiniestro"]);
            
            string extension = System.IO.Path.GetExtension(fileSelector.FileName);

            long size = fileSelector.FileContent.Length;

            Error ret = reportesDA.InsertDocumentacionDA(noSiniestro, 0, string.Empty, string.Empty, 0);

            int idDocumentacion = 0;
            bool pushFile = int.TryParse(ret.Mensaje, out idDocumentacion);
            
            if (pushFile)
            {
                insertaDatos.UploadFileForSiniestros(fileSelector.FileBytes, noSiniestro.ToString(), idDocumentacion.ToString(), extension);

                string loopRet = LoopThroughEachCheckBoxAndInsertThemInToTheDataBaseBecauseNoArrays(idDocumentacion);

                if (loopRet != string.Empty) X.MessageBox.Alert("Error al insertar datos", loopRet);

                ArchivosSiniestro(noSiniestro);

                RestaurarArchivos(null, null);
            }
            else
            {
                X.MessageBox.Alert("Alerta", ret.Mensaje).Show();
            }

            
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

        protected void NuevoEnvio(object sender, DirectEventArgs e)
        {
            grdArchivos.Disabled = true;

            for (int i = 1; i < 17; i++)
            {
                Checkbox chk = ComponentManager.Get("chkDoc" + i.ToString()) as Checkbox;
                chk.Value = 0;
                chk.ReadOnly = false;
            }

            fileSelector.ReadOnly = false;

            btnGuardarArchivo.Hidden = false;
            btnCancelarArchivo.Hidden = false;
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

            fileSelector.ReadOnly = true;
            fileSelector.Clear();

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

        private byte[] GetFileBytes()
        {
            string noSiniestro = Session["IdSiniestro"].ToString();
            string noGuia = Session["NoGuia"].ToString();

            return insertaDatos.GetFileForSiniestro(noSiniestro, noGuia, ".pdf");
        }

        protected void CommandArchivos(object sender, DirectEventArgs e)
        {
            Session["NoDocumentacion"] = e.ExtraParams["NoDocumentacion"];

            string cmd = e.ExtraParams["Command"];

            switch (cmd)
            {
                case "Ver":
                    wndPDF.Hidden = false;
                    wndPDF.Loader.LoadContent();
                    break;

                case "Descargar":
                    Response.Clear();
                    Response.AppendHeader("content-disposition", "attachment; filename=" + Session["NoDocumentacion"] + ".pdf");
                    Response.ContentType = "application/octet-stream";
                    Response.BinaryWrite(GetFileBytes());
                    Response.End();
                    break;
                case "Recibo":
                    int noDocumentacion = Convert.ToInt32(e.ExtraParams["NoDocumentacion"]);
                    int noSiniestro = Convert.ToInt32(Session["IdSiniestro"]);

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

    }
}