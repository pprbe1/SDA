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
    public partial class ListaaaaaasHoms : System.Web.UI.Page
    {
        wsConsultaReportesDA.wsConsultaReportesDA insercion = new wsConsultaReportesDA.wsConsultaReportesDA();

        public class Company
        {
            public int ID { get; set; }
            public string Name { get; set; }
            public double Percentage { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!X.IsAjaxRequest)
            {
                this.BindData();
            }
        }

        private void BindData()
        {
            Store store = this.GridPanel1.GetStore();
            store.DataSource = this.GetData();
            store.DataBind();
        }

        private List<Company> GetData()
        {
            return new List<Company> 
        {
            new Company { ID = 23, Name = "Luis Juarez", Percentage = 10 },
            new Company { ID = 24, Name = "Pedro Zapata", Percentage = 10 },
            new Company { ID = 25, Name = "Flor Martinez", Percentage = 10 },
            new Company { ID = 26, Name = "Ricardo Rodriguez", Percentage = 20 },
            new Company { ID = 27, Name = "Octavio Alvarado", Percentage = 20 },
            new Company { ID = 28, Name = "Mario Ayala", Percentage = 5 },
            new Company { ID = 29, Name = "Daniel Bernal", Percentage = 24 },
            new Company { ID = 30, Name = "Armando Cruz", Percentage = 1 }
        };
        }

        [DirectMethod(Namespace = "App")]
        public void Edit(dynamic items)
        {
            //Verificar en code-behind que esté todo bien. No quiero chapusas con la consola de JS

            double totalPercent = 0; 

            foreach (dynamic item in items)
                totalPercent += Convert.ToDouble(item["Percentage"].Value);

            if (totalPercent < 100)
                X.Msg.Alert("Alerta", "El porcentaje de asignacion a beneficiarios no alcanza el 100%").Show();

            else if (totalPercent > 100)
                X.Msg.Alert("Alerta", "El porcentaje de asignacion a beneficiarios excede el 100%").Show();

            else
                X.Msg.Alert("Alerta", "No hay alerta").Show();

            //Error err = insercion.InsertBeneficiarioDA();
        }
    }
}