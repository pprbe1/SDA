using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;

namespace SDA
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        //pagAnterior pagAnt = new pagAnterior();
        Controles.wsControlesAcceso GlobalOBD = new Controles.wsControlesAcceso();
        OBD_danos.wsDataConnection data = new OBD_danos.wsDataConnection();
        //public static List<pagAnterior> listaPagAnterior = new List<pagAnterior>();
        //CotizadorWeb.Default Acceso = new CotizadorWeb.Default();

        /// <summary>
        /// Carga la pagina y verifica si se nego el acceso a alguna sección para mandar un mensaje
        /// </summary>
        protected void Page_Load(object sender, EventArgs e)
        {
            ResourceManager.GetInstance();
            //// ***** Validacion de acceso *****
            //if (!Acceso.Revisa_Permisos(150))
            //{
            //    Session["Acess"] = false; Response.Redirect("/Default.aspx");
            //}
        }

        /*  ----------------------------------------------------------------------------------------
        *                  Funcion encargada de hacer la navegación hacia atras
        *                  Asociada al boton PreviusPage
        *  ----------------------------------------------------------------------------------------*/
        protected void Regresa_DirectEvent(object sender, Ext.Net.DirectEventArgs e)
        {
            //int n;
            //n = listaPagAnterior.IndexOf(listaPagAnterior.Last());
            ////  Verifica que n sea mayor que 0 para validar que hay elementos en la lista de navegación
            //if (n > 0)
            //{
            //    //  Toma la dirección de la pagina previa, 
            //    //  la borra de la lista y pasa a dicha pagina
            //    pagAnt = listaPagAnterior.ElementAt(n - 1);
            //    listaPagAnterior.RemoveAt(n - 1);
            //    listaPagAnterior.Remove(listaPagAnterior.Last());
            //    Response.Redirect(pagAnt.uri);
            //}
        }

        /*  ----------------------------------------------------------------------------------------
        *                  Si el usuario cierra sesión desde la opcion 'Cerrar sesion' del header, 
        *                  actualiza el 'Estatus' de 'En linea' a 'Fuera de linea'
        *  ----------------------------------------------------------------------------------------*/
        protected void HeadLoginStatus_LoggingOut(object sender, LoginCancelEventArgs e)
        {
            ////  Verifica que la variable de sesion 'Ejecutivo' no sea nula 
            //if (Session["Ejecutivo"] != null)
            //{
            //    //  Cambia el estatus del usuario a fuera de linea al cerrar sesión
            //    GlobalOBD.EstatusUser((int)(Session["Ejecutivo"]), 4);
            //}
        }

        public void imgFAQs_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

        public void imgAbout_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

        /*  ----------------------------------------------------------------------------------------
        *                  Controles de la ventana para enviar correos a PRYBE
        *  ----------------------------------------------------------------------------------------*/
        //  Muestra ventana de contacto
        public void imgContacto_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Default.aspx");
            //wdContacto.Show();
            //if (Session["NombreCompleto"] != null)
            //{
            //    txtEjecutivo.Text = Convert.ToString(Session["NombreCompleto"]);
            //}
            //if (Session["CorreoEjecutivo"] != null)
            //{
            //    txtDe.Text = Convert.ToString(Session["CorreoEjecutivo"]);
            //}
        }
        //  Oculta ventana de contacto
        public void Contacto_Cancelar(object sender, Ext.Net.DirectEventArgs e)
        {
            //wdContacto.Close();
        }
        //  Evento para enviar el correo electronico
        public void Contacto_Envia(object sender, Ext.Net.DirectEventArgs e)
        {
            //correoPrybe.wsCorreoPrybe correoEnvia = new correoPrybe.wsCorreoPrybe();
            //string mensaje;
            ////  Almacena nombre de variable del webconfig
            //string correo;
            ////  En base al tipo de contacto determina a quien se le enviara el correo
            //tmpValue = Convert.ToInt32(cbMotivo.Value);
            //switch (tmpValue)
            //{
            //    case 1:
            //        correo = "correo1";
            //        break;
            //    case 2:
            //        correo = "correo1";
            //        break;
            //    case 3:
            //        correo = "correo1";
            //        break;
            //    case 4:
            //        correo = "correo1";
            //        break;
            //    case 5:
            //        correo = "correo1";
            //        break;
            //    default:
            //        correo = "correo1";
            //        break;
            //}
            ////  Si se tienen todos los datos necesarios se envia correo y se cacha mensaje
            //if (txtDe.Text.Trim() != "" && txtAsunto.Text.Trim() != "" && txtContenido.Text.Trim() != "")
            //{
            //    data.InsertTicket(Convert.ToInt32(Session["Ejecutivo"]), 1, txtAsunto.Text, txtContenido.Text, 1, "");
            //    mensaje = correoEnvia.EnviaCorreo(WebConfigurationManager.AppSettings.Get(correo), txtDe.Text, txtAsunto.Text, txtContenido.Text, true);
            //    GeneraMensaje("Contacto", mensaje, 'I');
            //    wdContacto.Close();

            //}
            //else //  En caso contrario se manda mensaje informando que faltan datos
            //{
            //    GeneraMensaje("Introduzca los datos correctos",
            //                     "No introdujo todos los datos, verifique su contenido y vuelva a intentarlo", 'W');
            //}

        }

        /*  ----------------------------------------------------------------------------------------
        *                  Genera machote de asunto y mensaje del correo
        *  ----------------------------------------------------------------------------------------*/
        public void Select_Click(object sender, Ext.Net.DirectEventArgs e)
        {

            //string p1 = "No. de Póliza: ", p2 = "", p3 = "", p4 = "", p5 = "", p6 = "", salto = "" + Environment.NewLine + Environment.NewLine;
            //StringBuilder Contenido = new StringBuilder();
            //tmpValue = Convert.ToInt32(cbMotivo.Value);
            ////   De acuerdo a la seleccion de la lista, genera el machote del mensaje
            //switch (tmpValue)
            //{
            //    case 1:
            //        p2 = "Fecha de Cancelación: ";
            //        p3 = "Motivo de Cancelación: ";
            //        break;
            //    case 2:
            //        p2 = "Fecha de Endoso: ";
            //        p3 = "Motivo de Endoso: ";
            //        break;
            //    case 3:
            //        p1 = "Fecha: ";
            //        p2 = "Detalles de la duda: ";
            //        break;
            //    case 4:
            //        p1 = "Fecha: ";
            //        p2 = "¿Consideras que la capacitación para el uso del portal fue buena?: ";
            //        p3 = "¿Tuviste alguna duda respecto al uso del portal?:";
            //        p4 = "En términos generales, ¿Como calificarías la capacitación?:";
            //        p5 = "¿Que observaciones puedes realizar acerca de la capacitación?:";
            //        p6 = "¿Que observaciones tienes sobre el portal?";
            //        break;
            //    case 5:
            //        p1 = "Fecha: ";
            //        p2 = "Motivo de contacto: ";
            //        break;
            //    default:
            //        txtContenido.Text = "Motivo... ";
            //        break;
            //}
            //Contenido.AppendFormat("<strong>" + "Asunto: " + cbMotivo.SelectedItem.Text + "</strong>" + "<br/>" + "<br/>"
            //    + "<strong>" + "{0}" + "</strong>" + "<br/>" + "<br/>"
            //    + "<strong>" + "{1}" + "</strong>" + "<br/>" + "<br/>"
            //    + "<strong>" + "{2}" + "</strong>" + "<br/>" + "<br/>"
            //    + "<strong>" + "{3}" + "</strong>" + "<br/>" + "<br/>"
            //    + "<strong>" + "{4}" + "</strong>" + "<br/>" + "<br/>"
            //    + "<strong>" + "{5}" + "</strong>" + "<br/>" + "<br/>",
            //    p1, p2, p3, p4, p5, p6);
            //this.txtContenido.Text = Contenido.ToString();

            //this.txtAsunto.Text = txtEjecutivo.Text.ToUpper() + ": " + cbMotivo.SelectedItem.Text;
        }

        /// <summary>
        /// Funcion que genera los mensajes con iconos especificos
        /// </summary>
        /// <param name="Titulo">Titulo del mensaje</param>
        /// <param name="Contenido">Contenido del mensaje</param>
        /// <param name="Icon">Icono que llevara el mensaje (Q:Pregunta I:Informacion W:Precaución E:Error)</param>
        public void GeneraMensaje(string Titulo, string Contenido, char Icon)
        {
            //MessageBox.Icon Icono = new MessageBox.Icon();

            ////  Selección del icono de acuerdo a parametro recibido
            //switch (Icon)
            //{
            //    case 'Q':   // Pregunta
            //        Icono = MessageBox.Icon.QUESTION;
            //        break;
            //    case 'I':   // Informacion
            //        Icono = MessageBox.Icon.INFO;
            //        break;
            //    case 'W':   // Precaución
            //        Icono = MessageBox.Icon.WARNING;
            //        break;
            //    case 'E':   // Error
            //        Icono = MessageBox.Icon.ERROR;
            //        break;
            //}

            ////  Muestra mensaje con los parametros indicados
            //X.Msg.Show(new MessageBoxConfig
            //{
            //    Title = Titulo,
            //    Message = Contenido,
            //    Buttons = MessageBox.Button.OK,
            //    Icon = Icono
            //});
        }

        /// <summary>
        /// WEBMETHOD encargado de enviar mensaje que niega permiso de acceso a una pajina determinada
        /// </summary>
        [DirectMethod]
        public void DoConfirm()
        {
            //X.Msg.Confirm("Sin acceso!!!", "No tiene los permisos suficientes para acceder a esta pagina, consulte con el administrador.",
            //    new MessageBoxButtonsConfig
            //    {
            //        Yes = new MessageBoxButtonConfig
            //        {
            //            Handler = "Prybe.Yes()",
            //            Text = "Aceptar"
            //        }
            //    }).Show();
        }


    }
}
