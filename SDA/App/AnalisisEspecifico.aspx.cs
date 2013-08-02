using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using System.Text;
using System.Linq;
using System.Globalization;
using System.IO;

namespace SDA.App
{
    public partial class AnalisisEspecifico : System.Web.UI.Page
    {        
        DateTime fechaNac = new DateTime();
        DateTime fechaIng = new DateTime();
        DateTime fechaMuerte = new DateTime();
        DateTime fechaultcaptacion = new DateTime();
        DateTime fechaultcolocacion = new DateTime();
        DateTime fechaprestamo = new DateTime();
        DateTime actual = new DateTime();
        static string idRec;
        string idBeneficiario, idCaptacion, idColocacion, cuentaplus, cuentaDI, cuentaAJuv, numerodias;
        double cuenta, cuentaAJ;

        SDA.wsInsercionDatosBen.wsInsertaDatosBeneficios analisis = new SDA.wsInsercionDatosBen.wsInsertaDatosBeneficios();
        SDA.wsInsercionDatosBen.wsInsertaDatosBeneficios beneficiario = new SDA.wsInsercionDatosBen.wsInsertaDatosBeneficios();
        SDA.wsInsercionDatosBen.wsInsertaDatosBeneficios captacion = new SDA.wsInsercionDatosBen.wsInsertaDatosBeneficios();
        SDA.wsInsercionDatosBen.wsInsertaDatosBeneficios colocacion = new SDA.wsInsercionDatosBen.wsInsertaDatosBeneficios();
        SDA.wsInsercionDatosBen.wsInsertaDatosBeneficios estatus = new SDA.wsInsercionDatosBen.wsInsertaDatosBeneficios();

        SDA.wsConsultaDatosBen.DatosSocio datossocio = new SDA.wsConsultaDatosBen.DatosSocio();
        SDA.wsConsultaDatosBen.DatosAnalisis datosanalisis = new SDA.wsConsultaDatosBen.DatosAnalisis();
        SDA.wsConsultaDatosBen.ConsultaSaldoTotalCaptacion saldocaptacion = new SDA.wsConsultaDatosBen.ConsultaSaldoTotalCaptacion();
        SDA.wsConsultaDatosBen.ConsultaSaldoTotalColocacion saldocolocacion = new SDA.wsConsultaDatosBen.ConsultaSaldoTotalColocacion();

        SDA.wsConsultaDatosBen.wsConsultaBeneficios datosSoc = new SDA.wsConsultaDatosBen.wsConsultaBeneficios();
        SDA.wsConsultaDatosBen.wsConsultaBeneficios datosAna = new SDA.wsConsultaDatosBen.wsConsultaBeneficios();
        List<SDA.wsConsultaDatos2.ConsultaBeneficiario> ben = new List<SDA.wsConsultaDatos2.ConsultaBeneficiario>();

        SDA.wsConsultaDatos2.ConsultaBeneficiarioNombres beneficiariodetalle = new SDA.wsConsultaDatos2.ConsultaBeneficiarioNombres();
        SDA.wsConsultaDatos2.wsConsultaSiniestros datosbeneficiario = new SDA.wsConsultaDatos2.wsConsultaSiniestros();

        SDA.wsConsultaDatos2.ConsultasColocaciones colocaciondetalle = new SDA.wsConsultaDatos2.ConsultasColocaciones();
        SDA.wsConsultaDatos2.ConsultaCaptaciones captaciondetalle = new SDA.wsConsultaDatos2.ConsultaCaptaciones();
        SDA.wsConsultaDatos2.wsConsultaSiniestros datoscaptacion = new SDA.wsConsultaDatos2.wsConsultaSiniestros();
        SDA.wsConsultaDatos2.wsConsultaSiniestros datoscolocacion = new SDA.wsConsultaDatos2.wsConsultaSiniestros();

        SDA.wsConsultaDatos2.wsConsultaSiniestros cuentas = new SDA.wsConsultaDatos2.wsConsultaSiniestros();
        SDA.wsInsercionDatosBen.Error ErrorOp = new SDA.wsInsercionDatosBen.Error();

        protected void Page_Load(object sender, EventArgs e)
        {            
            if (Session["IdRec"] != null)
            {
                idRec = Convert.ToString(Session["IdRec"]);
                datossocio = datosSoc.CargaDatosSocio(idRec);
                datosanalisis = datosAna.CargaDatosAnalisis(idRec);
                saldocaptacion = datosSoc.ConsultasSaldoTotalCaptacion(idRec);
                saldocolocacion = datosSoc.ConsultasSaldoTotalColocacion(idRec);
            }
                                    
        }

        public void btnAtras_Click(object sender, DirectEventArgs e)
        {
            Response.Redirect("AnalisisReclamo.aspx", true); ;
        }

        public void btnAgregarBeneficiario_Click(object sender, DirectEventArgs e)
        {
            this.pnlBeneficiario.Show();
            this.fcNombres.Show();
            this.fcApellidos.Show();
            this.btnAgregarBeneficiario.Disabled = false;
            this.btGuardar.Disabled = true;
        }
       
        
        public void btnAgregarBeneficiarioGrid_Click(object sender, DirectEventArgs e)
        {
            if (this.txtNombre.Text != "" && this.txtApellidoPaterno.Text != "" && this.nmrPorcentaje.Text != "")
            {
                int Op = 2;
                this.btnAgregarBeneficiario.Disabled = false;
                ErrorOp = beneficiario.InsertBeneficiario(this.txtNombre.Text.ToUpper(), this.txtNombre2.Text.ToUpper(), this.txtApellidoPaterno.Text.ToUpper(),
                                                this.txtApellidoMaterno.Text.ToUpper(), this.nmrPorcentaje.Text, (int)(Session["IdRec"]), 0,Op);

                if (ErrorOp.Valor == true)
                {
                    X.Msg.Alert("Aviso", ErrorOp.Mensaje).Show();
                }
                List<SDA.wsConsultaDatos2.ConsultaBeneficiario> beneficiarioagregado =
                        new List<SDA.wsConsultaDatos2.ConsultaBeneficiario>(datosbeneficiario.ConsultaBeneficiarios(idRec));

                this.strBeneficiario.DataSource = beneficiarioagregado;
                this.strBeneficiario.DataBind();
                Limpia_CamposBeneficiario();
            }
            else
            {
                X.Msg.Alert("Aviso","Hay algunos campos que no se han rellenado y son obligatorios").Show();
            }
        }
                
        public void CellBeneficiario_Click(object sender, DirectEventArgs e)
        {
            this.btnAgregarBeneficiario.Disabled = true;
            this.btGuardar.Disabled = false;
            RowSelectionModel sm = this.gplBeneficiario.SelectionModel.Primary as RowSelectionModel;
            StringBuilder sb = new StringBuilder();

            foreach (SelectedRow row in sm.SelectedRows)
            {
                sb.AppendFormat(row.RecordID);
            }

            idBeneficiario = sb.ToString();
            Session["IdBeneficiario"] = Convert.ToInt32(idBeneficiario);
            this.pnlBeneficiario.Show();
            this.fcNombres.Show();
            this.fcApellidos.Show();
            beneficiariodetalle = datosbeneficiario.ConsultaBeneficiariosNombres(idRec, (int)(Session["IdBeneficiario"]));
            this.txtNombre.Text = beneficiariodetalle.Nombre1;
            this.txtNombre2.Text = beneficiariodetalle.Nombre2;
            this.txtApellidoPaterno.Text = beneficiariodetalle.ApellidoPat;
            this.txtApellidoMaterno.Text = beneficiariodetalle.ApellidoMat;
            this.nmrPorcentaje.Value = beneficiariodetalle.Porcentaje;

        }

        protected void CellEliminarBeneficiario_Click(object sender, DirectEventArgs e)
        {
            idBeneficiario = e.ExtraParams["IdBeneficiario"];
            if (idBeneficiario != "")
            {
                Session["IdBeneficiario"] = Convert.ToInt32(idBeneficiario);
                beneficiario.EliminarBeneficiario((int)(Session["IdBeneficiario"]), 2);
                List<SDA.wsConsultaDatos2.ConsultaBeneficiario> beneficiarioagregado =
                                new List<SDA.wsConsultaDatos2.ConsultaBeneficiario>(datosbeneficiario.ConsultaBeneficiarios(idRec));
                this.strBeneficiario.DataSource = beneficiarioagregado;
                this.strBeneficiario.DataBind();
                Limpia_CamposBeneficiario();
                this.btGuardar.Disabled = true;
                this.btnAgregarBeneficiario.Disabled = false;
            }
        }

        public void btGuardarBeneficiario_Click(object sender, DirectEventArgs e)
        {
            if (this.txtNombre.Text != "" && this.txtApellidoPaterno.Text != "" && this.nmrPorcentaje.Text != "")
            {
                int Op = 1;
                ErrorOp = beneficiario.InsertBeneficiario(this.txtNombre.Text.ToUpper(), this.txtNombre2.Text.ToUpper(), this.txtApellidoPaterno.Text.ToUpper(),
                                                    this.txtApellidoMaterno.Text.ToUpper(), this.nmrPorcentaje.Text, (int)(Session["IdRec"]), (int)(Session["IdBeneficiario"]),Op);
               
                if (ErrorOp.Valor == true)
                {
                    X.Msg.Alert("Aviso", ErrorOp.Mensaje).Show();
                }

                List<SDA.wsConsultaDatos2.ConsultaBeneficiario> beneficiarioagregado =
                        new List<SDA.wsConsultaDatos2.ConsultaBeneficiario>(datosbeneficiario.ConsultaBeneficiarios(idRec));

                this.strBeneficiario.DataSource = beneficiarioagregado;
                this.strBeneficiario.DataBind();
                Limpia_CamposBeneficiario();
                this.btnAgregarBeneficiario.Disabled = false;
                this.btGuardar.Disabled = true;
            }
        }      


        
        public void btnCuentas_Click(object sender, DirectEventArgs e)
        {
            List<SDA.wsConsultaDatos2.ConsultaBeneficiario> beneficiarioagregado =
                        new List<SDA.wsConsultaDatos2.ConsultaBeneficiario>(datosbeneficiario.ConsultaBeneficiarios(idRec));
            if (beneficiarioagregado.Count != 0)
            {
                //fechaMuerte = Convert.ToDateTime(this.dteFechaMuerte.Text);
                fechaIng = Convert.ToDateTime(datossocio.FechaIng);
                Session["FechaIngreso"] = fechaIng;
                Session["FechaMuerte"] = fechaMuerte;
                this.dteFechaUltimoMovimiento.MaxDate = Convert.ToDateTime(Session["FechaMuerte"]);
                this.dteFechaUltimoMovimiento.MinDate = Convert.ToDateTime(Session["FechaIngreso"]);
                this.dteFechaOtorgado.MinDate = Convert.ToDateTime(Session["FechaIngreso"]);
                this.dteFechaOtorgado.MaxDate = Convert.ToDateTime(Session["FechaMuerte"]);
                this.dteFechaUltimoMovimientoCol.MinDate = Convert.ToDateTime(Session["FechaIngreso"]);
                this.dteFechaUltimoMovimientoCol.MaxDate = Convert.ToDateTime(Session["FechaMuerte"]);
                //this.wdwCuentas.Show();                
                Session["CuentaCaptacion"] = 2;
                this.strCuentas.DataSource = new List<SDA.wsConsultaDatos2.Cuentas>(cuentas.ConsultaCuentas(idRec, (int)(Session["CuentaCaptacion"])));
                this.strCuentas.DataBind();
                this.pnlProteccionAhorros.Collapsed = false;
                this.frmBeneficiario.Collapsed = true;
                Habilita_CamposCaptacion();
                Habilita_CamposColocacion();
            }
            else
            {
                X.Msg.Alert("Aviso", "No has registrado un beneficiario").Show();
            }           
        }
 

        public void btnAgregarCuentaCaptacion_Click(object sender, DirectEventArgs e)
        {
            if (this.nmrMonto.Text == "")
            {
                X.MessageBox.Alert("Aviso", "Hay algunos campos que no han sido completados y son obligatorios").Show();
            }
            else
            {
                //if (this.chkDobleIndemnizacion.Checked == true || this.chkAditamentoJuventud.Checked == true)
                //{
                    //if (this.chkDobleIndemnizacion.Checked == true)
                    //{
                        Session["Plus"] = 4;
                        cuenta = Convert.ToDouble(this.nmrMonto.Text) * 2;
                        cuentaDI = this.nmrMonto.Text;
                        cuentaAJuv = "0";
                        cuentaplus = Convert.ToString(cuenta);
                        Session["DobleI"] = 1;
                        Session["AditamentoJ"] = 0;
                    //}
                    //if (this.chkAditamentoJuventud.Checked == true)
                    //{
                        Session["Plus"] = 5;
                        //cuentaAJ = Convert.ToDouble(this.cbAditamentoPorcentaje.Value);
                        cuenta = (Convert.ToDouble(this.nmrMonto.Text) * cuentaAJ) / 100;
                        cuenta = cuenta + Convert.ToDouble(this.nmrMonto.Text);
                        cuentaplus = Convert.ToString(cuenta);
                        cuentaAJuv = Convert.ToString(cuenta);
                        cuentaDI = "0";
                        Session["AditamentoJ"] = 1;
                        Session["DobleI"] = 0;
                        //analisis.InsertPLusCaptacion((int)(Session["IdRec"]), Convert.ToString(this.cbAditamentoPorcentaje.Value));
                    //}

                    //if (this.chkDobleIndemnizacion.Checked == true && this.chkAditamentoJuventud.Checked == true)
                    //{
                        Session["Plus"] = 6;
                        //cuentaAJ = Convert.ToDouble(this.cbAditamentoPorcentaje.Value);
                        cuenta = (Convert.ToDouble(this.nmrMonto.Text) * cuentaAJ) / 100;
                        cuenta = cuenta + (Convert.ToDouble(this.nmrMonto.Text) * 2);
                        cuentaplus = Convert.ToString(cuenta);
                        cuentaDI = this.nmrMonto.Text;
                        cuentaAJuv = Convert.ToString(Convert.ToDouble(this.nmrMonto.Text) * cuentaAJ / 100);
                        Session["AditamentoJ"] = 1;
                        Session["DobleI"] = 1;
                        //analisis.InsertPLusCaptacion((int)(Session["IdRec"]), Convert.ToString(this.cbAditamentoPorcentaje.Value));
                    //}
                //}
                //else
                //{
                    Session["Plus"] = 1;
                    cuentaplus = this.nmrMonto.Text;
                    Session["AditamentoJ"] = 0;
                    Session["DobleI"] = 0;
                    cuentaAJuv = "0";
                    cuentaDI = "0";
                    analisis.InsertPLusCaptacion((int)(Session["IdRec"]), "0");

                //}


                actual = DateTime.Today;
                fechaultcaptacion = Convert.ToDateTime(this.dteFechaUltimoMovimiento.Text);
                fechaMuerte = Convert.ToDateTime(Session["FechaMuerte"]);
                if (DateTime.Compare(fechaultcaptacion, actual) > 0 || DateTime.Compare(fechaMuerte, fechaultcaptacion) < 0)
                {
                    X.Msg.Alert("Aviso", "La fecha ingresada es mayor a la actual o a la fecha de muerte").Show();
                }
                else
                {
                    ErrorOp = captacion.InsertCaptacion(this.nmrMonto.Text, fechaultcaptacion.ToString("dd/MM/yyyy"), Convert.ToInt32(this.cbCuentas.SelectedItem.Value),
                        cuentaAJuv, cuentaDI, (int)(Session["IdRec"]), (int)(Session["Plus"]), 0, (int)(Session["AditamentoJ"]), (int)(Session["DobleI"]), cuentaplus);
                    if (ErrorOp.Valor == true)
                    {
                        X.Msg.Alert("Aviso", "").Show();
                    }

                    List<SDA.wsConsultaDatos2.ConsultaCaptacion> datcaptacion =
                                    new List<SDA.wsConsultaDatos2.ConsultaCaptacion>(datoscaptacion.ConsultaCaptacionGeneral(idRec));
                    this.strCaptacion.DataSource = datcaptacion;
                    this.strCaptacion.DataBind();
                    Limpia_CamposCaptacion();
                    Carga_SaldoTotalCaptacion();
                }
            }
        }

        public void btnModificarCaptacion_Click(object sender, DirectEventArgs e)
        {
            if (this.nmrMonto.Text == "")
            {
                X.MessageBox.Alert("Aviso", "Hay algunos campos que no han sido completados y son obligatorios").Show();
            }
            else
            {
                // (this.chkDobleIndemnizacion.Checked == true || this.chkAditamentoJuventud.Checked == true)
                //
                   //if (this.chkDobleIndemnizacion.Checked == true)
                    //{
                        Session["Plus"] = 4;
                        cuenta = Convert.ToDouble(this.nmrMonto.Text) * 2;
                        cuentaplus = Convert.ToString(cuenta);
                        cuentaDI = this.nmrMonto.Text;
                        cuentaAJuv = "0";
                        Session["DobleI"] = 1;
                        Session["AditamentoJ"] = 0;
                    //}
                    //if (this.chkAditamentoJuventud.Checked == true)
                    //{
                        Session["Plus"] = 5;
                        //cuentaAJ = Convert.ToDouble(this.cbAditamentoPorcentaje.Value);
                        cuenta = (Convert.ToDouble(this.nmrMonto.Text) * cuentaAJ) / 100 + Convert.ToDouble(this.nmrMonto.Text);
                        cuentaAJuv = Convert.ToString(cuenta);
                        cuentaDI = "0";
                        cuentaplus = Convert.ToString(cuenta);
                        Session["AditamentoJ"] = 1;
                        Session["DobleI"] = 0;
                        //analisis.InsertPLusCaptacion((int)(Session["IdRec"]), Convert.ToString(this.cbAditamentoPorcentaje.Value));
                    //}

                    //if (this.chkDobleIndemnizacion.Checked == true && this.chkAditamentoJuventud.Checked == true)
                    //{
                        Session["Plus"] = 6;
                        //cuentaAJ = Convert.ToDouble(this.cbAditamentoPorcentaje.Value);
                        cuenta = (Convert.ToDouble(this.nmrMonto.Text) * cuentaAJ) / 100;
                        cuentaplus = Convert.ToString((cuenta + (Convert.ToDouble(this.nmrMonto.Text) * 2)));
                        cuentaDI = this.nmrMonto.Text;
                        cuentaAJuv = Convert.ToString(((Convert.ToDouble(this.nmrMonto.Text) * cuentaAJ) / 100) + Convert.ToDouble(this.nmrMonto.Text));
                        Session["AditamentoJ"] = 1;
                        Session["DobleI"] = 1;
                        //analisis.InsertPLusCaptacion((int)(Session["IdRec"]), Convert.ToString(this.cbAditamentoPorcentaje.Value));
                    //}
                //}
                //else
                //{
                    Session["Plus"] = 1;
                    cuentaplus = this.nmrMonto.Text;
                    Session["AditamentoJ"] = 0;
                    Session["DobleI"] = 0;
                    cuentaDI = "0";
                    cuentaAJuv = "0";
                    analisis.InsertPLusCaptacion((int)(Session["IdRec"]), "0");
                //}
                actual = DateTime.Today;
                fechaMuerte = Convert.ToDateTime(Session["FechaMuerte"]);
                fechaultcaptacion = Convert.ToDateTime(this.dteFechaUltimoMovimiento.Text);
                if (DateTime.Compare(fechaultcaptacion, actual) > 0 || DateTime.Compare(fechaMuerte, fechaultcaptacion) < 0)
                {
                    X.Msg.Alert("Aviso", "La fecha ingresada es mayor a la actual o a la fecha de muerte").Show();
                }
                else
                {
                    ErrorOp = captacion.InsertCaptacion(this.nmrMonto.Text, fechaultcaptacion.ToString("dd/MM/yyyy"), Convert.ToInt32(this.cbCuentas.SelectedItem.Value),
                        cuentaAJuv, cuentaDI, (int)(Session["IdRec"]), (int)(Session["Plus"]), (int)(Session["IdCaptacion"]), (int)(Session["AditamentoJ"]), (int)(Session["DobleI"]), cuentaplus);
                    if (ErrorOp.Valor == true)
                    {
                        X.Msg.Alert("Aviso", "").Show();
                    }
                    List<SDA.wsConsultaDatos2.ConsultaCaptacion> datcaptacion =
                                    new List<SDA.wsConsultaDatos2.ConsultaCaptacion>(datoscaptacion.ConsultaCaptacionGeneral(idRec));
                    this.strCaptacion.DataSource = datcaptacion;
                    this.strCaptacion.DataBind();
                    Limpia_CamposCaptacion();
                    this.btnModificarCaptacion.Disabled = true;
                    this.btnAgregarCuentaCaptacion.Disabled = false;
                    Carga_SaldoTotalCaptacion();
                }

            }
        }

        public void btnGuardarCaptacion_Click(object sender, DirectEventArgs e)
        {
            this.pnlProteccionAhorros.Collapsed = true;
            this.pnlProteccionPrestamos.Collapsed = false;
        }

        public void CellCuentaCaptacion_Click(object sender, DirectEventArgs e)
        {
            RowSelectionModel sm = this.gplCaptacion.SelectionModel.Primary as RowSelectionModel;
            StringBuilder sb = new StringBuilder();

            foreach (SelectedRow row in sm.SelectedRows)
            {
                sb.AppendFormat(row.RecordID);
            }

            idCaptacion = sb.ToString();
            Session["IdCaptacion"] = Convert.ToInt32(idCaptacion);
            captaciondetalle = datoscaptacion.ConsultaCaptacionDetalle(idRec, idCaptacion);
            //this.cbAditamentoPorcentaje.Value = datosanalisis.Aditamento_Juv;
            this.cbCuentas.SelectedItem.Value = captaciondetalle.Captacion;
            this.nmrMonto.Value = captaciondetalle.Saldo;
            fechaultcaptacion = Convert.ToDateTime (captaciondetalle.UltimoMovimiento);
            this.dteFechaUltimoMovimiento.Text = fechaultcaptacion.ToString("dd/MM/yyyy");
            if (captaciondetalle.AditamentoJ == true)
            {
                //this.chkAditamentoJuventud.Checked = true;
            }
            else
            {
                //this.chkAditamentoJuventud.Checked = false;
            }
            if (captaciondetalle.DobleI == true)
            {
                //this.chkDobleIndemnizacion.Checked = true;
            }
            else
            {
                //this.chkDobleIndemnizacion.Checked = false;
            }
            this.btnAgregarCuentaCaptacion.Disabled = true;
            this.btnModificarCaptacion.Disabled = false;
            this.btnCancelarCuentaCaptacion.Disabled = false;
        }

        public void btnCancelarCuentaCaptacion_Click(object sender, DirectEventArgs e)
        {
            Limpia_CamposCaptacion();
            this.btnCancelarCuentaCaptacion.Disabled = true;
            this.btnModificarCaptacion.Disabled = true;
            this.btnAgregarCuentaCaptacion.Disabled = false;
        }

        protected void CellEliminarCaptacion_Click(object sender, DirectEventArgs e)
        {
            idCaptacion = e.ExtraParams["IdCaptacion"];
            if (idCaptacion != "")
            {
                Session["IdCapatacion"] = Convert.ToInt32(idCaptacion);
                captacion.EliminarCaptacion((int)(Session["IdCapatacion"]), 3);
                List<SDA.wsConsultaDatos2.ConsultaCaptacion> cuentascaptacion =
                new List<SDA.wsConsultaDatos2.ConsultaCaptacion>(datoscaptacion.ConsultaCaptacionGeneral(idRec));
                this.strCaptacion.DataSource = cuentascaptacion;
                this.strCaptacion.DataBind();
                this.btnAgregarCuentaCaptacion.Disabled = false;
                this.btnModificarCaptacion.Disabled = true;
                Limpia_CamposCaptacion();
                Carga_SaldoTotalCaptacion();
            }
        }




        public void btnAgregarCuentaColocacion_Click(object sender, DirectEventArgs e)
        {
            if (this.dteFechaOtorgado.Text != "" && this.nmrMontoColocacion.Text != "" && this.nmrTasaInteres.Text != "" && this.sfPlazo.Text != ""
               && this.dteFechaUltimoMovimientoCol.Text != "" && this.nmrSaldoPrincipal.Text != "")
            {
                Session["PP"] = 2;
                Session["TipoCuenta"] = 1;

                fechaprestamo = Convert.ToDateTime(this.dteFechaOtorgado.Text);
                fechaultcolocacion = Convert.ToDateTime(this.dteFechaUltimoMovimientoCol.Text);
                TimeSpan dias = Convert.ToDateTime(Session["FechaMuerte"]) - fechaultcolocacion;
                if (dias.Days > 180)
                {
                    numerodias = "180";
                }
                else
                {
                    numerodias = dias.Days.ToString();
                }
                double ic = ((Convert.ToDouble(this.nmrSaldoPrincipal.Text) * (Convert.ToDouble(this.nmrTasaInteres.Text) / 100)) / 30.4) * Convert.ToInt32(numerodias);
                double total = Convert.ToDouble(this.nmrSaldoPrincipal.Text) + ic;
                string intereses = Convert.ToString(ic);
                string totalpagar = total.ToString();
                actual = DateTime.Today;
                fechaMuerte = Convert.ToDateTime(Session["FechaMuerte"]);
                if (Convert.ToDouble(this.nmrSaldoPrincipal.Text) > Convert.ToDouble(this.nmrMontoColocacion.Text))
                {
                    X.Msg.Alert("Aviso", "El saldo principal no puede ser mayor al Monto del préstamo").Show();
                }
                else
                {
                    if (DateTime.Compare(fechaultcolocacion, actual) > 0 || DateTime.Compare(fechaMuerte, fechaultcolocacion) < 0)
                    {
                        X.Msg.Alert("Aviso", "La fecha ingresada es mayor a la actual o la fecha de muerte").Show();
                    }
                    else
                    {
                        ErrorOp = colocacion.InsertColocacion(fechaprestamo.ToString("dd/MM/yyyy"), this.nmrTasaInteres.Text, Convert.ToInt32(this.sfPlazo.Text),
                                                    fechaultcolocacion.ToString("dd/MM/yyyy"), this.nmrSaldoPrincipal.Text,
                                                    Convert.ToInt32(this.cbTipoPrestamo.SelectedItem.Value), (int)(Session["TipoCuenta"]),
                                                    Convert.ToInt32(idRec), this.nmrMontoColocacion.Text, 0, (int)(Session["PP"]), totalpagar, intereses);
                        if (ErrorOp.Valor == true)
                        {
                            X.Msg.Alert("Aviso","").Show();
                        }
                        List<SDA.wsConsultaDatos2.ConsultaColocacion> datcolocacion =
                                        new List<SDA.wsConsultaDatos2.ConsultaColocacion>(datoscolocacion.ConsultaColocaciones(idRec));
                        this.strColocacion.DataSource = datcolocacion;
                        this.strColocacion.DataBind();
                        Limpia_CamposColocacion();
                        Carga_SaldoTotalColocacion();
                    }
                }
            }
            else
            {
                X.Msg.Alert("Aviso", "Hay algunos campos que no han sido completados y son obligatorios").Show();
            }
        }

        public void btnModificarColocacion_Click(object sender, DirectEventArgs e)
        {
            if (this.dteFechaOtorgado.Text != "" && this.nmrMontoColocacion.Text != "" && this.nmrTasaInteres.Text != "" && this.sfPlazo.Text != ""
               && this.dteFechaUltimoMovimientoCol.Text != "" && this.nmrSaldoPrincipal.Text != "")
            {
                Session["PP"] = 2;
                Session["TipoCuenta"] = 1;

                fechaprestamo = Convert.ToDateTime(this.dteFechaOtorgado.Text);
                fechaultcolocacion = Convert.ToDateTime(this.dteFechaUltimoMovimientoCol.Text);
                TimeSpan dias = Convert.ToDateTime(Session["FechaMuerte"]) - fechaultcolocacion;
                if (dias.Days > 180)
                {
                    numerodias = "180";
                }
                else
                {
                    numerodias = dias.Days.ToString();
                }
                double ic = ((Convert.ToDouble(this.nmrSaldoPrincipal.Text) * (Convert.ToDouble(this.nmrTasaInteres.Text) / 100)) / 30.4) * Convert.ToInt32(numerodias);
                double total = Convert.ToDouble(this.nmrSaldoPrincipal.Text) + ic;
                string intereses = Convert.ToString(ic);
                string totalpagar = total.ToString();
                actual = DateTime.Today;
                fechaMuerte = Convert.ToDateTime(Session["FechaMuerte"]);
                if (Convert.ToDouble(this.nmrSaldoPrincipal.Text) > Convert.ToDouble(this.nmrMontoColocacion.Text))
                {
                    X.Msg.Alert("Aviso", "El saldo principal no puede ser mayor al Monto del préstamo").Show();
                }
                else
                {
                    if (DateTime.Compare(fechaultcolocacion, actual) > 0 || DateTime.Compare(fechaMuerte, fechaultcolocacion) < 0)
                    {
                        X.Msg.Alert("Aviso", "La fecha ingresada es mayor a la actual o la fecha de muerte").Show();
                    }
                    else
                    {
                        ErrorOp = colocacion.InsertColocacion(fechaprestamo.ToString("dd/MM/yyyy"), this.nmrTasaInteres.Text, Convert.ToInt32(this.sfPlazo.Text),
                                                    fechaultcolocacion.ToString("dd/MM/yyyy"), this.nmrSaldoPrincipal.Text,
                                                    Convert.ToInt32(this.cbTipoPrestamo.SelectedItem.Value), (int)(Session["TipoCuenta"]),
                                                    Convert.ToInt32(idRec), this.nmrMontoColocacion.Text, (int)(Session["IdColocacion"]), (int)(Session["PP"]), totalpagar, intereses);
                        if (ErrorOp.Valor == true)
                        {
                            X.Msg.Alert("Aviso","").Show();
                        }

                        List<SDA.wsConsultaDatos2.ConsultaColocacion> datcolocacion =
                                        new List<SDA.wsConsultaDatos2.ConsultaColocacion>(datoscolocacion.ConsultaColocaciones(idRec));
                        this.strColocacion.DataSource = datcolocacion;
                        this.strColocacion.DataBind();
                        Limpia_CamposColocacion();
                        this.btnModificarColocacion.Disabled = true;
                        this.btnAgregarCuentaColocacion.Disabled = false;
                        Carga_SaldoTotalColocacion();
                    }

                }
            }
            else
            {
                X.Msg.Alert("Aviso", "Hay algunos campos que no han sido completados y son obligatorios").Show();
            }

        }

        public void CellCuentaColocacion_Click(object sender, DirectEventArgs e)
        {
            RowSelectionModel sm = this.gplColocacion.SelectionModel.Primary as RowSelectionModel;
            StringBuilder sb = new StringBuilder();

            foreach (SelectedRow row in sm.SelectedRows)
            {
                sb.AppendFormat(row.RecordID);
            }

            idColocacion = sb.ToString();
            Session["IdColocacion"] = Convert.ToInt32(idColocacion);

            colocaciondetalle = datoscolocacion.ConsultaColocacionDetalle(idRec, idColocacion);
            fechaprestamo = Convert.ToDateTime(colocaciondetalle.FechaPrest);
            this.dteFechaOtorgado.Text = fechaprestamo.ToString("dd/MM/yyyy");
            this.nmrMontoColocacion.Value = colocaciondetalle.Monto;
            this.cbTipoPrestamo.SelectedItem.Value = colocaciondetalle.IdTipoPrestamo;
            this.nmrTasaInteres.Value = colocaciondetalle.TasaInt;
            this.sfPlazo.Text = colocaciondetalle.Plazo;
            fechaultcolocacion = Convert.ToDateTime(colocaciondetalle.UltimoMovColocacion);
            this.dteFechaUltimoMovimientoCol.Text = fechaultcolocacion.ToString("dd/MM/yyyy");
            this.nmrSaldoPrincipal.Value = colocaciondetalle.SaldoColocacion;
            this.btnModificarColocacion.Disabled = false;
            this.btnCancelarCuentaColocacion.Disabled = false;
            this.btnAgregarCuentaColocacion.Disabled = true;

        }

        public void btnCancelarCuentaColocacion_Click(object sender, DirectEventArgs e)
        {
            Limpia_CamposColocacion();
            this.btnCancelarCuentaColocacion.Disabled = true;
            this.btnModificarColocacion.Disabled = true;
            this.btnAgregarCuentaColocacion.Disabled = false;
        }

        protected void CellEliminarColocacion_Click(object sender, DirectEventArgs e)
        {
            idColocacion = e.ExtraParams["IdColocacion"];
            if (idColocacion != "")
            {
                Session["IdColocacion"] = Convert.ToInt32(idColocacion);
                captacion.EliminarColocacion ((int)(Session["IdColocacion"]), 4);
                List<SDA.wsConsultaDatos2.ConsultaColocacion> cuentascolocacion =
                new List<SDA.wsConsultaDatos2.ConsultaColocacion>(datoscolocacion.ConsultaColocaciones(idRec));
                this.strColocacion.DataSource = cuentascolocacion;
                this.strColocacion.DataBind();
                this.btnAgregarCuentaColocacion.Disabled = false;
                this.btnModificarColocacion.Disabled = true;
                Limpia_CamposColocacion();
                Carga_SaldoTotalColocacion();
            }
        }
       
        public void btnCerrarCuentas_Click(object sender, DirectEventArgs e)
        {
            //this.wdwCuentas.Close();
            Response.Redirect("AnalisisReclamo.aspx", true); ;
        }



        public void btnAnalisisAprobado_Click(object sender, DirectEventArgs e)
        {
            estatus.EstatusReclamo(7, (int)(Session["IdRec"]));
            Response.Redirect("AnalisisReclamo.aspx", true); ;
        }




        protected void EdadMuerte(object sender, DirectEventArgs e)
        {
            //fechaMuerte = Convert.ToDateTime(this.dteFechaMuerte.Text);
            int edadAnos = fechaMuerte.Year - fechaNac.Year;
            if (fechaMuerte.Month < fechaNac.Month || (fechaMuerte.Month == fechaNac.Month &&
            fechaMuerte.Day < fechaNac.Day))
                edadAnos--;
            Session["EdadMuerte"] = edadAnos;
            //this.lblEdadMuerte.Text = Convert.ToString(edadAnos);
        }

        protected void Habilita_CamposBeneficiario()
        {
            this.txtNombre.Disabled = false;
            this.txtNombre2.Disabled = false;
            this.txtApellidoPaterno.Disabled = false;
            this.txtApellidoMaterno.Disabled = false;
            this.nmrPorcentaje.Disabled = false;
            this.btnAgregarBeneficiario.Disabled = false;
        }
        
        protected void Carga_CamposBeneficiario()
        {
            List<SDA.wsConsultaDatos2.ConsultaBeneficiario> beneficiarioagregado =
                                new List<SDA.wsConsultaDatos2.ConsultaBeneficiario>(datosbeneficiario.ConsultaBeneficiarios(idRec));
            this.strBeneficiario.DataSource = beneficiarioagregado;
            this.strBeneficiario.DataBind();
        }

        protected void Habilita_CamposCaptacion()
        {
            this.cbCuentas.Disabled = false;
            this.nmrMonto.Disabled = false;
            this.dteFechaUltimoMovimiento.Disabled = false;
            //this.chkAditamentoJuventud.Disabled = false;
            //this.chkDobleIndemnizacion.Disabled = false;
            this.btnAgregarCuentaCaptacion.Disabled = false;
            this.nmrPorcentaje.Disabled = false;
            this.btnGuardarCapatacion.Disabled = false;
        }

        protected void Carga_CamposCaptacion()
        {
            List<SDA.wsConsultaDatos2.ConsultaCaptacion> cuentascaptacion =
                new List<SDA.wsConsultaDatos2.ConsultaCaptacion>(datoscaptacion.ConsultaCaptacionGeneral(idRec));
            this.strCaptacion.DataSource = cuentascaptacion;
            this.strCaptacion.DataBind();
                        
        }

        protected void Carga_SaldoTotalCaptacion()
        {
            saldocaptacion = datosSoc.ConsultasSaldoTotalCaptacion(idRec);
            this.lblSaldoTotal.Text = saldocaptacion.SaldoCaptacion.ToString("$#,##0.00");

        }

        protected void Habilita_CamposColocacion()
        {
            this.dteFechaOtorgado.Disabled = false;
            this.nmrMontoColocacion.Disabled = false;
            this.nmrTasaInteres.Disabled = false;
            this.nmrSaldoPrincipal.Disabled = false;
            this.sfPlazo.Disabled = false;
            this.dteFechaUltimoMovimientoCol.Disabled = false;
            this.cbTipoPrestamo.Disabled = false;
            this.btnAgregarCuentaColocacion.Disabled = false;
        }
        
        protected void Carga_CamposColocacion()
        {
            List<SDA.wsConsultaDatos2.ConsultaColocacion> cuentascolocacion =
                new List<SDA.wsConsultaDatos2.ConsultaColocacion>(datoscolocacion.ConsultaColocaciones(idRec));
            this.strColocacion.DataSource = cuentascolocacion;
            this.strColocacion.DataBind();
        }

        protected void Carga_SaldoTotalColocacion()
        {
            saldocolocacion = datosSoc.ConsultasSaldoTotalColocacion(idRec);
            this.lblSaldoTotalColocacion.Text = saldocolocacion.SaldoColocacion.ToString("$#,##0.00");
        }

        protected void Limpia_CamposBeneficiario()
        {
            this.txtNombre.Text = "";
            this.txtNombre2.Text = "";
            this.txtApellidoPaterno.Text = "";
            this.txtApellidoMaterno.Text = "";
            this.nmrPorcentaje.Value = EmptyValue.EmptyString;
        }

        protected void Limpia_CamposCaptacion()
        {
            this.cbCuentas.Value = "";
            this.nmrMonto.Value = EmptyValue.EmptyString;
            this.dteFechaUltimoMovimiento.Text = "";
            //this.cbAditamentoPorcentaje.Value = "";
            //this.chkAditamentoJuventud.Checked = false;
            //this.chkDobleIndemnizacion.Checked = false;
        }
       
        protected void Limpia_CamposColocacion()
        {
            this.dteFechaOtorgado.Text = "";
            this.nmrMontoColocacion.Value = EmptyValue.EmptyString;
            this.cbTipoPrestamo.SelectedItem.Value = "1";
            this.nmrTasaInteres.Value = EmptyValue.EmptyString;
            this.sfPlazo.Value = EmptyValue.EmptyString;
            this.dteFechaUltimoMovimientoCol.Text = "";
            this.nmrSaldoPrincipal.Value = EmptyValue.EmptyString;
        }
    }
}