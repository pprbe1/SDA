﻿using System;
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

            wsConsultaReportesDA.Siniestro[] siniestros = null;

            switch (operacion)
            {
                case 1:
                    siniestros = reportesDA.Siniestros(operacion, entidad, string.Empty);
                    break;

                case 3:
                    siniestros = reportesDA.Siniestros(operacion, 0, Convert.ToString(Session["Entidad"]));
                    break;
            }
            
            this.strReclamosGral.DataSource = siniestros;
            this.strReclamosGral.DataBind();
        }

        protected void InformacionSiniestro(object sender, DirectEventArgs e)
        {
            int idSocio = Convert.ToInt32(e.ExtraParams["ID"]);

            Siniestro[] siniestro = reportesDA.Siniestros(4, idSocio, string.Empty);

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
            Session["Usuario"] = "1"; //este vato es Administrador Prybe S.C.

            int idUsuario = Convert.ToInt32(Session["Usuario"]);
            int noSiniestro = Convert.ToInt32(Session["IdSiniestro"]);

            Error err = reportesDA.InsertBitacoraDA(noSiniestro, idUsuario, txtBitacora.RawValue.ToString());

            if (err.Valor) X.MessageBox.Alert("Alerta", err.Mensaje).Show();

            BitacoraSiniestro(noSiniestro);

            RestaurarBitacora(null, null);
        }
    }
}