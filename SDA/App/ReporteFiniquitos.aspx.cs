using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SDA.App
{
    public partial class ReporteFiniquitos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string fechaInicio, fechaFin;

            //if (DateField1.Text == "" || DateField1.Text == "01/01/0001 12:00:00 a.m.")
            //{
            //    fechaInicio = "";
            //}
            //else
            //{
            //    fechaInicio = Convert.ToDateTime(DateField1.Text).ToString("yyyy-MM-dd");
            //}

            //if (DateField2.Text == "" || DateField2.Text == "01/01/0001 12:00:00 a.m.")
            //{
            //    fechaFin = "";
            //}
            //else
            //{
            //    fechaFin = Convert.ToDateTime(DateField2.Text).ToString("yyyy-MM-dd");
            //}

            wsConsultaReportesDA.wsConsultaReportesDA reportegral = new wsConsultaReportesDA.wsConsultaReportesDA();

            List<wsConsultaReportesDA.ReporteSiniestrosDA> lista = new List<wsConsultaReportesDA.ReporteSiniestrosDA>(reportegral.ReporteSiniestros(1, "", "", 9));

            //indicadores.wsIndicadoresPrybe indica = new indicadores.wsIndicadoresPrybe();
            //List<indicadores.CoopAseg> lista = new List<indicadores.CoopAseg>(indica.CotizacionesPorCoopAseg(fechaInicio, fechaFin));

            //Store1.DataSource = lista;
            //Store1.DataBind();

            Store3.DataSource = lista;
            Store3.DataBind();
        }
    }
}