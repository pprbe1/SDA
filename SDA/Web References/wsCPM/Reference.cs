﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Este código fue generado por una herramienta.
//     Versión de runtime:4.0.30319.18213
//
//     Los cambios en este archivo podrían causar un comportamiento incorrecto y se perderán si
//     se vuelve a generar el código.
// </auto-generated>
//------------------------------------------------------------------------------

// 
// Microsoft.VSDesigner generó automáticamente este código fuente, versión=4.0.30319.18213.
// 
#pragma warning disable 1591

namespace SDA.wsCPM {
    using System;
    using System.Web.Services;
    using System.Diagnostics;
    using System.Web.Services.Protocols;
    using System.Xml.Serialization;
    using System.ComponentModel;
    
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.18213")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Web.Services.WebServiceBindingAttribute(Name="wsPrybeCPMSoap", Namespace="http://qa.prybe.coop/WSPrybeCPM/wspcpm/wsPrybeCPM.asmx")]
    public partial class wsPrybeCPM : System.Web.Services.Protocols.SoapHttpClientProtocol {
        
        private System.Threading.SendOrPostCallback ObtenSocioCPMOperationCompleted;
        
        private System.Threading.SendOrPostCallback ObtenPermisoCPMOperationCompleted;
        
        private bool useDefaultCredentialsSetExplicitly;
        
        /// <remarks/>
        public wsPrybeCPM() {
            this.Url = global::SDA.Properties.Settings.Default.SDA_wsCPM_wsPrybeCPM;
            if ((this.IsLocalFileSystemWebService(this.Url) == true)) {
                this.UseDefaultCredentials = true;
                this.useDefaultCredentialsSetExplicitly = false;
            }
            else {
                this.useDefaultCredentialsSetExplicitly = true;
            }
        }
        
        public new string Url {
            get {
                return base.Url;
            }
            set {
                if ((((this.IsLocalFileSystemWebService(base.Url) == true) 
                            && (this.useDefaultCredentialsSetExplicitly == false)) 
                            && (this.IsLocalFileSystemWebService(value) == false))) {
                    base.UseDefaultCredentials = false;
                }
                base.Url = value;
            }
        }
        
        public new bool UseDefaultCredentials {
            get {
                return base.UseDefaultCredentials;
            }
            set {
                base.UseDefaultCredentials = value;
                this.useDefaultCredentialsSetExplicitly = true;
            }
        }
        
        /// <remarks/>
        public event ObtenSocioCPMCompletedEventHandler ObtenSocioCPMCompleted;
        
        /// <remarks/>
        public event ObtenPermisoCPMCompletedEventHandler ObtenPermisoCPMCompleted;
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://qa.prybe.coop/WSPrybeCPM/wspcpm/wsPrybeCPM.asmx/ObtenSocioCPM", RequestNamespace="http://qa.prybe.coop/WSPrybeCPM/wspcpm/wsPrybeCPM.asmx", ResponseNamespace="http://qa.prybe.coop/WSPrybeCPM/wspcpm/wsPrybeCPM.asmx", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public SocioCPM ObtenSocioCPM(string NoSocio, string Usuario) {
            object[] results = this.Invoke("ObtenSocioCPM", new object[] {
                        NoSocio,
                        Usuario});
            return ((SocioCPM)(results[0]));
        }
        
        /// <remarks/>
        public void ObtenSocioCPMAsync(string NoSocio, string Usuario) {
            this.ObtenSocioCPMAsync(NoSocio, Usuario, null);
        }
        
        /// <remarks/>
        public void ObtenSocioCPMAsync(string NoSocio, string Usuario, object userState) {
            if ((this.ObtenSocioCPMOperationCompleted == null)) {
                this.ObtenSocioCPMOperationCompleted = new System.Threading.SendOrPostCallback(this.OnObtenSocioCPMOperationCompleted);
            }
            this.InvokeAsync("ObtenSocioCPM", new object[] {
                        NoSocio,
                        Usuario}, this.ObtenSocioCPMOperationCompleted, userState);
        }
        
        private void OnObtenSocioCPMOperationCompleted(object arg) {
            if ((this.ObtenSocioCPMCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.ObtenSocioCPMCompleted(this, new ObtenSocioCPMCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://qa.prybe.coop/WSPrybeCPM/wspcpm/wsPrybeCPM.asmx/ObtenPermisoCPM", RequestNamespace="http://qa.prybe.coop/WSPrybeCPM/wspcpm/wsPrybeCPM.asmx", ResponseNamespace="http://qa.prybe.coop/WSPrybeCPM/wspcpm/wsPrybeCPM.asmx", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public PermisoCPM ObtenPermisoCPM(string Usuario, string Password) {
            object[] results = this.Invoke("ObtenPermisoCPM", new object[] {
                        Usuario,
                        Password});
            return ((PermisoCPM)(results[0]));
        }
        
        /// <remarks/>
        public void ObtenPermisoCPMAsync(string Usuario, string Password) {
            this.ObtenPermisoCPMAsync(Usuario, Password, null);
        }
        
        /// <remarks/>
        public void ObtenPermisoCPMAsync(string Usuario, string Password, object userState) {
            if ((this.ObtenPermisoCPMOperationCompleted == null)) {
                this.ObtenPermisoCPMOperationCompleted = new System.Threading.SendOrPostCallback(this.OnObtenPermisoCPMOperationCompleted);
            }
            this.InvokeAsync("ObtenPermisoCPM", new object[] {
                        Usuario,
                        Password}, this.ObtenPermisoCPMOperationCompleted, userState);
        }
        
        private void OnObtenPermisoCPMOperationCompleted(object arg) {
            if ((this.ObtenPermisoCPMCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.ObtenPermisoCPMCompleted(this, new ObtenPermisoCPMCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        public new void CancelAsync(object userState) {
            base.CancelAsync(userState);
        }
        
        private bool IsLocalFileSystemWebService(string url) {
            if (((url == null) 
                        || (url == string.Empty))) {
                return false;
            }
            System.Uri wsUri = new System.Uri(url);
            if (((wsUri.Port >= 1024) 
                        && (string.Compare(wsUri.Host, "localHost", System.StringComparison.OrdinalIgnoreCase) == 0))) {
                return true;
            }
            return false;
        }
    }
    
    /// <comentarios/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.0.30319.18213")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace="http://qa.prybe.coop/WSPrybeCPM/wspcpm/wsPrybeCPM.asmx")]
    public partial class SocioCPM {
        
        private Error errorField;
        
        private string primerNombreField;
        
        private string segundoNombreField;
        
        private string primerApellidoField;
        
        private string segundoApellidoField;
        
        private string tipoSocioField;
        
        private string statusSocioField;
        
        private string noSocioTitularField;
        
        private string sucursalField;
        
        private string plazaField;
        
        private bool sexoField;
        
        private string fechaNacimientoField;
        
        private string rFCField;
        
        private string cURPField;
        
        private string calleField;
        
        private string noExteriorField;
        
        private string noInteriorField;
        
        private string estadoField;
        
        private string municipioField;
        
        private string coloniaField;
        
        private string cpField;
        
        private string ladaField;
        
        private string telefonoField;
        
        private string emailField;
        
        private string ocupacionField;
        
        private string estadoCivilField;
        
        private string fechaIngresoField;
        
        /// <comentarios/>
        public Error Error {
            get {
                return this.errorField;
            }
            set {
                this.errorField = value;
            }
        }
        
        /// <comentarios/>
        public string PrimerNombre {
            get {
                return this.primerNombreField;
            }
            set {
                this.primerNombreField = value;
            }
        }
        
        /// <comentarios/>
        public string SegundoNombre {
            get {
                return this.segundoNombreField;
            }
            set {
                this.segundoNombreField = value;
            }
        }
        
        /// <comentarios/>
        public string PrimerApellido {
            get {
                return this.primerApellidoField;
            }
            set {
                this.primerApellidoField = value;
            }
        }
        
        /// <comentarios/>
        public string SegundoApellido {
            get {
                return this.segundoApellidoField;
            }
            set {
                this.segundoApellidoField = value;
            }
        }
        
        /// <comentarios/>
        public string TipoSocio {
            get {
                return this.tipoSocioField;
            }
            set {
                this.tipoSocioField = value;
            }
        }
        
        /// <comentarios/>
        public string StatusSocio {
            get {
                return this.statusSocioField;
            }
            set {
                this.statusSocioField = value;
            }
        }
        
        /// <comentarios/>
        public string NoSocioTitular {
            get {
                return this.noSocioTitularField;
            }
            set {
                this.noSocioTitularField = value;
            }
        }
        
        /// <comentarios/>
        public string Sucursal {
            get {
                return this.sucursalField;
            }
            set {
                this.sucursalField = value;
            }
        }
        
        /// <comentarios/>
        public string Plaza {
            get {
                return this.plazaField;
            }
            set {
                this.plazaField = value;
            }
        }
        
        /// <comentarios/>
        public bool Sexo {
            get {
                return this.sexoField;
            }
            set {
                this.sexoField = value;
            }
        }
        
        /// <comentarios/>
        public string FechaNacimiento {
            get {
                return this.fechaNacimientoField;
            }
            set {
                this.fechaNacimientoField = value;
            }
        }
        
        /// <comentarios/>
        public string RFC {
            get {
                return this.rFCField;
            }
            set {
                this.rFCField = value;
            }
        }
        
        /// <comentarios/>
        public string CURP {
            get {
                return this.cURPField;
            }
            set {
                this.cURPField = value;
            }
        }
        
        /// <comentarios/>
        public string Calle {
            get {
                return this.calleField;
            }
            set {
                this.calleField = value;
            }
        }
        
        /// <comentarios/>
        public string NoExterior {
            get {
                return this.noExteriorField;
            }
            set {
                this.noExteriorField = value;
            }
        }
        
        /// <comentarios/>
        public string NoInterior {
            get {
                return this.noInteriorField;
            }
            set {
                this.noInteriorField = value;
            }
        }
        
        /// <comentarios/>
        public string Estado {
            get {
                return this.estadoField;
            }
            set {
                this.estadoField = value;
            }
        }
        
        /// <comentarios/>
        public string Municipio {
            get {
                return this.municipioField;
            }
            set {
                this.municipioField = value;
            }
        }
        
        /// <comentarios/>
        public string Colonia {
            get {
                return this.coloniaField;
            }
            set {
                this.coloniaField = value;
            }
        }
        
        /// <comentarios/>
        public string CP {
            get {
                return this.cpField;
            }
            set {
                this.cpField = value;
            }
        }
        
        /// <comentarios/>
        public string Lada {
            get {
                return this.ladaField;
            }
            set {
                this.ladaField = value;
            }
        }
        
        /// <comentarios/>
        public string Telefono {
            get {
                return this.telefonoField;
            }
            set {
                this.telefonoField = value;
            }
        }
        
        /// <comentarios/>
        public string Email {
            get {
                return this.emailField;
            }
            set {
                this.emailField = value;
            }
        }
        
        /// <comentarios/>
        public string Ocupacion {
            get {
                return this.ocupacionField;
            }
            set {
                this.ocupacionField = value;
            }
        }
        
        /// <comentarios/>
        public string EstadoCivil {
            get {
                return this.estadoCivilField;
            }
            set {
                this.estadoCivilField = value;
            }
        }
        
        /// <comentarios/>
        public string FechaIngreso {
            get {
                return this.fechaIngresoField;
            }
            set {
                this.fechaIngresoField = value;
            }
        }
    }
    
    /// <comentarios/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.0.30319.18213")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace="http://qa.prybe.coop/WSPrybeCPM/wspcpm/wsPrybeCPM.asmx")]
    public partial class Error {
        
        private bool valorField;
        
        private string mensajeField;
        
        /// <comentarios/>
        public bool Valor {
            get {
                return this.valorField;
            }
            set {
                this.valorField = value;
            }
        }
        
        /// <comentarios/>
        public string Mensaje {
            get {
                return this.mensajeField;
            }
            set {
                this.mensajeField = value;
            }
        }
    }
    
    /// <comentarios/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.0.30319.18213")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace="http://qa.prybe.coop/WSPrybeCPM/wspcpm/wsPrybeCPM.asmx")]
    public partial class PermisoCPM {
        
        private Error errorField;
        
        private string permisoField;
        
        /// <comentarios/>
        public Error Error {
            get {
                return this.errorField;
            }
            set {
                this.errorField = value;
            }
        }
        
        /// <comentarios/>
        public string Permiso {
            get {
                return this.permisoField;
            }
            set {
                this.permisoField = value;
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.18213")]
    public delegate void ObtenSocioCPMCompletedEventHandler(object sender, ObtenSocioCPMCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.18213")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class ObtenSocioCPMCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal ObtenSocioCPMCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public SocioCPM Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((SocioCPM)(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.18213")]
    public delegate void ObtenPermisoCPMCompletedEventHandler(object sender, ObtenPermisoCPMCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.18213")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class ObtenPermisoCPMCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal ObtenPermisoCPMCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public PermisoCPM Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((PermisoCPM)(this.results[0]));
            }
        }
    }
}

#pragma warning restore 1591