﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Este código fue generado por una herramienta.
//     Versión de runtime:4.0.30319.1008
//
//     Los cambios en este archivo podrían causar un comportamiento incorrecto y se perderán si
//     se vuelve a generar el código.
// </auto-generated>
//------------------------------------------------------------------------------

// 
// Microsoft.VSDesigner generó automáticamente este código fuente, versión=4.0.30319.1008.
// 
#pragma warning disable 1591

namespace SDA.wsConsultaReportesDA {
    using System;
    using System.Web.Services;
    using System.Diagnostics;
    using System.Web.Services.Protocols;
    using System.ComponentModel;
    using System.Xml.Serialization;
    
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Web.Services.WebServiceBindingAttribute(Name="wsConsultaReportesDASoap", Namespace="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx")]
    public partial class wsConsultaReportesDA : System.Web.Services.Protocols.SoapHttpClientProtocol {
        
        private System.Threading.SendOrPostCallback SiniestrosOperationCompleted;
        
        private System.Threading.SendOrPostCallback BitacorasOperationCompleted;
        
        private System.Threading.SendOrPostCallback UpdateStatusSiniestroDAOperationCompleted;
        
        private System.Threading.SendOrPostCallback InsertBitacoraDAOperationCompleted;
        
        private System.Threading.SendOrPostCallback InsertDocumentacionDAOperationCompleted;
        
        private System.Threading.SendOrPostCallback UpdateFechaRecDocuDAOperationCompleted;
        
        private System.Threading.SendOrPostCallback InsertDetDocuDAOperationCompleted;
        
        private System.Threading.SendOrPostCallback ConsultaNumSiniestroDAOperationCompleted;
        
        private bool useDefaultCredentialsSetExplicitly;
        
        /// <remarks/>
        public wsConsultaReportesDA() {
            this.Url = global::SDA.Properties.Settings.Default.SDA_wsConsultaReportesDA_wsConsultaReportesDA;
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
        public event SiniestrosCompletedEventHandler SiniestrosCompleted;
        
        /// <remarks/>
        public event BitacorasCompletedEventHandler BitacorasCompleted;
        
        /// <remarks/>
        public event UpdateStatusSiniestroDACompletedEventHandler UpdateStatusSiniestroDACompleted;
        
        /// <remarks/>
        public event InsertBitacoraDACompletedEventHandler InsertBitacoraDACompleted;
        
        /// <remarks/>
        public event InsertDocumentacionDACompletedEventHandler InsertDocumentacionDACompleted;
        
        /// <remarks/>
        public event UpdateFechaRecDocuDACompletedEventHandler UpdateFechaRecDocuDACompleted;
        
        /// <remarks/>
        public event InsertDetDocuDACompletedEventHandler InsertDetDocuDACompleted;
        
        /// <remarks/>
        public event ConsultaNumSiniestroDACompletedEventHandler ConsultaNumSiniestroDACompleted;
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx/Siniestr" +
            "os", RequestNamespace="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx", ResponseNamespace="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public Siniestro[] Siniestros(int Operacion, int IdEntidad, string NoSocio) {
            object[] results = this.Invoke("Siniestros", new object[] {
                        Operacion,
                        IdEntidad,
                        NoSocio});
            return ((Siniestro[])(results[0]));
        }
        
        /// <remarks/>
        public void SiniestrosAsync(int Operacion, int IdEntidad, string NoSocio) {
            this.SiniestrosAsync(Operacion, IdEntidad, NoSocio, null);
        }
        
        /// <remarks/>
        public void SiniestrosAsync(int Operacion, int IdEntidad, string NoSocio, object userState) {
            if ((this.SiniestrosOperationCompleted == null)) {
                this.SiniestrosOperationCompleted = new System.Threading.SendOrPostCallback(this.OnSiniestrosOperationCompleted);
            }
            this.InvokeAsync("Siniestros", new object[] {
                        Operacion,
                        IdEntidad,
                        NoSocio}, this.SiniestrosOperationCompleted, userState);
        }
        
        private void OnSiniestrosOperationCompleted(object arg) {
            if ((this.SiniestrosCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.SiniestrosCompleted(this, new SiniestrosCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx/Bitacora" +
            "s", RequestNamespace="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx", ResponseNamespace="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public Bitacora[] Bitacoras(int Operacion, int IdEntidad) {
            object[] results = this.Invoke("Bitacoras", new object[] {
                        Operacion,
                        IdEntidad});
            return ((Bitacora[])(results[0]));
        }
        
        /// <remarks/>
        public void BitacorasAsync(int Operacion, int IdEntidad) {
            this.BitacorasAsync(Operacion, IdEntidad, null);
        }
        
        /// <remarks/>
        public void BitacorasAsync(int Operacion, int IdEntidad, object userState) {
            if ((this.BitacorasOperationCompleted == null)) {
                this.BitacorasOperationCompleted = new System.Threading.SendOrPostCallback(this.OnBitacorasOperationCompleted);
            }
            this.InvokeAsync("Bitacoras", new object[] {
                        Operacion,
                        IdEntidad}, this.BitacorasOperationCompleted, userState);
        }
        
        private void OnBitacorasOperationCompleted(object arg) {
            if ((this.BitacorasCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.BitacorasCompleted(this, new BitacorasCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx/UpdateSt" +
            "atusSiniestroDA", RequestNamespace="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx", ResponseNamespace="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public Error UpdateStatusSiniestroDA(int IdSiniestro, int StatusSiniestro) {
            object[] results = this.Invoke("UpdateStatusSiniestroDA", new object[] {
                        IdSiniestro,
                        StatusSiniestro});
            return ((Error)(results[0]));
        }
        
        /// <remarks/>
        public void UpdateStatusSiniestroDAAsync(int IdSiniestro, int StatusSiniestro) {
            this.UpdateStatusSiniestroDAAsync(IdSiniestro, StatusSiniestro, null);
        }
        
        /// <remarks/>
        public void UpdateStatusSiniestroDAAsync(int IdSiniestro, int StatusSiniestro, object userState) {
            if ((this.UpdateStatusSiniestroDAOperationCompleted == null)) {
                this.UpdateStatusSiniestroDAOperationCompleted = new System.Threading.SendOrPostCallback(this.OnUpdateStatusSiniestroDAOperationCompleted);
            }
            this.InvokeAsync("UpdateStatusSiniestroDA", new object[] {
                        IdSiniestro,
                        StatusSiniestro}, this.UpdateStatusSiniestroDAOperationCompleted, userState);
        }
        
        private void OnUpdateStatusSiniestroDAOperationCompleted(object arg) {
            if ((this.UpdateStatusSiniestroDACompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.UpdateStatusSiniestroDACompleted(this, new UpdateStatusSiniestroDACompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx/InsertBi" +
            "tacoraDA", RequestNamespace="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx", ResponseNamespace="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public Error InsertBitacoraDA(int IdSiniestro, int Usuario, string Mensaje) {
            object[] results = this.Invoke("InsertBitacoraDA", new object[] {
                        IdSiniestro,
                        Usuario,
                        Mensaje});
            return ((Error)(results[0]));
        }
        
        /// <remarks/>
        public void InsertBitacoraDAAsync(int IdSiniestro, int Usuario, string Mensaje) {
            this.InsertBitacoraDAAsync(IdSiniestro, Usuario, Mensaje, null);
        }
        
        /// <remarks/>
        public void InsertBitacoraDAAsync(int IdSiniestro, int Usuario, string Mensaje, object userState) {
            if ((this.InsertBitacoraDAOperationCompleted == null)) {
                this.InsertBitacoraDAOperationCompleted = new System.Threading.SendOrPostCallback(this.OnInsertBitacoraDAOperationCompleted);
            }
            this.InvokeAsync("InsertBitacoraDA", new object[] {
                        IdSiniestro,
                        Usuario,
                        Mensaje}, this.InsertBitacoraDAOperationCompleted, userState);
        }
        
        private void OnInsertBitacoraDAOperationCompleted(object arg) {
            if ((this.InsertBitacoraDACompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.InsertBitacoraDACompleted(this, new InsertBitacoraDACompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx/InsertDo" +
            "cumentacionDA", RequestNamespace="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx", ResponseNamespace="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public Error InsertDocumentacionDA(int IdSiniestro, int IdPaqueteria, string FechaEnvio, string NoGuia) {
            object[] results = this.Invoke("InsertDocumentacionDA", new object[] {
                        IdSiniestro,
                        IdPaqueteria,
                        FechaEnvio,
                        NoGuia});
            return ((Error)(results[0]));
        }
        
        /// <remarks/>
        public void InsertDocumentacionDAAsync(int IdSiniestro, int IdPaqueteria, string FechaEnvio, string NoGuia) {
            this.InsertDocumentacionDAAsync(IdSiniestro, IdPaqueteria, FechaEnvio, NoGuia, null);
        }
        
        /// <remarks/>
        public void InsertDocumentacionDAAsync(int IdSiniestro, int IdPaqueteria, string FechaEnvio, string NoGuia, object userState) {
            if ((this.InsertDocumentacionDAOperationCompleted == null)) {
                this.InsertDocumentacionDAOperationCompleted = new System.Threading.SendOrPostCallback(this.OnInsertDocumentacionDAOperationCompleted);
            }
            this.InvokeAsync("InsertDocumentacionDA", new object[] {
                        IdSiniestro,
                        IdPaqueteria,
                        FechaEnvio,
                        NoGuia}, this.InsertDocumentacionDAOperationCompleted, userState);
        }
        
        private void OnInsertDocumentacionDAOperationCompleted(object arg) {
            if ((this.InsertDocumentacionDACompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.InsertDocumentacionDACompleted(this, new InsertDocumentacionDACompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx/UpdateFe" +
            "chaRecDocuDA", RequestNamespace="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx", ResponseNamespace="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public Error UpdateFechaRecDocuDA(int IdDocumentacion, string FechaRecibido) {
            object[] results = this.Invoke("UpdateFechaRecDocuDA", new object[] {
                        IdDocumentacion,
                        FechaRecibido});
            return ((Error)(results[0]));
        }
        
        /// <remarks/>
        public void UpdateFechaRecDocuDAAsync(int IdDocumentacion, string FechaRecibido) {
            this.UpdateFechaRecDocuDAAsync(IdDocumentacion, FechaRecibido, null);
        }
        
        /// <remarks/>
        public void UpdateFechaRecDocuDAAsync(int IdDocumentacion, string FechaRecibido, object userState) {
            if ((this.UpdateFechaRecDocuDAOperationCompleted == null)) {
                this.UpdateFechaRecDocuDAOperationCompleted = new System.Threading.SendOrPostCallback(this.OnUpdateFechaRecDocuDAOperationCompleted);
            }
            this.InvokeAsync("UpdateFechaRecDocuDA", new object[] {
                        IdDocumentacion,
                        FechaRecibido}, this.UpdateFechaRecDocuDAOperationCompleted, userState);
        }
        
        private void OnUpdateFechaRecDocuDAOperationCompleted(object arg) {
            if ((this.UpdateFechaRecDocuDACompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.UpdateFechaRecDocuDACompleted(this, new UpdateFechaRecDocuDACompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx/InsertDe" +
            "tDocuDA", RequestNamespace="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx", ResponseNamespace="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public Error InsertDetDocuDA(int IdTipoDoc, int IdDocumentacion) {
            object[] results = this.Invoke("InsertDetDocuDA", new object[] {
                        IdTipoDoc,
                        IdDocumentacion});
            return ((Error)(results[0]));
        }
        
        /// <remarks/>
        public void InsertDetDocuDAAsync(int IdTipoDoc, int IdDocumentacion) {
            this.InsertDetDocuDAAsync(IdTipoDoc, IdDocumentacion, null);
        }
        
        /// <remarks/>
        public void InsertDetDocuDAAsync(int IdTipoDoc, int IdDocumentacion, object userState) {
            if ((this.InsertDetDocuDAOperationCompleted == null)) {
                this.InsertDetDocuDAOperationCompleted = new System.Threading.SendOrPostCallback(this.OnInsertDetDocuDAOperationCompleted);
            }
            this.InvokeAsync("InsertDetDocuDA", new object[] {
                        IdTipoDoc,
                        IdDocumentacion}, this.InsertDetDocuDAOperationCompleted, userState);
        }
        
        private void OnInsertDetDocuDAOperationCompleted(object arg) {
            if ((this.InsertDetDocuDACompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.InsertDetDocuDACompleted(this, new InsertDetDocuDACompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx/Consulta" +
            "NumSiniestroDA", RequestNamespace="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx", ResponseNamespace="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public NumSiniestro ConsultaNumSiniestroDA(int IdSiniestro) {
            object[] results = this.Invoke("ConsultaNumSiniestroDA", new object[] {
                        IdSiniestro});
            return ((NumSiniestro)(results[0]));
        }
        
        /// <remarks/>
        public void ConsultaNumSiniestroDAAsync(int IdSiniestro) {
            this.ConsultaNumSiniestroDAAsync(IdSiniestro, null);
        }
        
        /// <remarks/>
        public void ConsultaNumSiniestroDAAsync(int IdSiniestro, object userState) {
            if ((this.ConsultaNumSiniestroDAOperationCompleted == null)) {
                this.ConsultaNumSiniestroDAOperationCompleted = new System.Threading.SendOrPostCallback(this.OnConsultaNumSiniestroDAOperationCompleted);
            }
            this.InvokeAsync("ConsultaNumSiniestroDA", new object[] {
                        IdSiniestro}, this.ConsultaNumSiniestroDAOperationCompleted, userState);
        }
        
        private void OnConsultaNumSiniestroDAOperationCompleted(object arg) {
            if ((this.ConsultaNumSiniestroDACompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.ConsultaNumSiniestroDACompleted(this, new ConsultaNumSiniestroDACompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
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
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.0.30319.1009")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx")]
    public partial class Siniestro {
        
        private string noSiniestroField;
        
        private string noSocioField;
        
        private string nombreField;
        
        private string fechaReclamoField;
        
        private string statusSiniestroField;
        
        private string ocupacionField;
        
        private string coopField;
        
        private string plazaField;
        
        private string sucursalField;
        
        /// <comentarios/>
        public string NoSiniestro {
            get {
                return this.noSiniestroField;
            }
            set {
                this.noSiniestroField = value;
            }
        }
        
        /// <comentarios/>
        public string NoSocio {
            get {
                return this.noSocioField;
            }
            set {
                this.noSocioField = value;
            }
        }
        
        /// <comentarios/>
        public string Nombre {
            get {
                return this.nombreField;
            }
            set {
                this.nombreField = value;
            }
        }
        
        /// <comentarios/>
        public string FechaReclamo {
            get {
                return this.fechaReclamoField;
            }
            set {
                this.fechaReclamoField = value;
            }
        }
        
        /// <comentarios/>
        public string StatusSiniestro {
            get {
                return this.statusSiniestroField;
            }
            set {
                this.statusSiniestroField = value;
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
        public string Coop {
            get {
                return this.coopField;
            }
            set {
                this.coopField = value;
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
        public string Sucursal {
            get {
                return this.sucursalField;
            }
            set {
                this.sucursalField = value;
            }
        }
    }
    
    /// <comentarios/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.0.30319.1009")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx")]
    public partial class NumSiniestro {
        
        private string numeroSiniestroField;
        
        /// <comentarios/>
        public string NumeroSiniestro {
            get {
                return this.numeroSiniestroField;
            }
            set {
                this.numeroSiniestroField = value;
            }
        }
    }
    
    /// <comentarios/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.0.30319.1009")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx")]
    public partial class Error {
        
        private string mensajeField;
        
        private bool valorField;
        
        /// <comentarios/>
        public string Mensaje {
            get {
                return this.mensajeField;
            }
            set {
                this.mensajeField = value;
            }
        }
        
        /// <comentarios/>
        public bool Valor {
            get {
                return this.valorField;
            }
            set {
                this.valorField = value;
            }
        }
    }
    
    /// <comentarios/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Xml", "4.0.30319.1009")]
    [System.SerializableAttribute()]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Xml.Serialization.XmlTypeAttribute(Namespace="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx")]
    public partial class Bitacora {
        
        private string idBitacoraField;
        
        private System.DateTime fechaField;
        
        private string statusField;
        
        private string usuarioField;
        
        private string mensajeField;
        
        private string idDocumentacionField;
        
        private string paqueteriaField;
        
        private string noGuiaField;
        
        private string fechaEnvioField;
        
        private string fechaReclamoField;
        
        private string tipoDocField;
        
        /// <comentarios/>
        public string IdBitacora {
            get {
                return this.idBitacoraField;
            }
            set {
                this.idBitacoraField = value;
            }
        }
        
        /// <comentarios/>
        public System.DateTime Fecha {
            get {
                return this.fechaField;
            }
            set {
                this.fechaField = value;
            }
        }
        
        /// <comentarios/>
        public string Status {
            get {
                return this.statusField;
            }
            set {
                this.statusField = value;
            }
        }
        
        /// <comentarios/>
        public string Usuario {
            get {
                return this.usuarioField;
            }
            set {
                this.usuarioField = value;
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
        
        /// <comentarios/>
        public string IdDocumentacion {
            get {
                return this.idDocumentacionField;
            }
            set {
                this.idDocumentacionField = value;
            }
        }
        
        /// <comentarios/>
        public string Paqueteria {
            get {
                return this.paqueteriaField;
            }
            set {
                this.paqueteriaField = value;
            }
        }
        
        /// <comentarios/>
        public string NoGuia {
            get {
                return this.noGuiaField;
            }
            set {
                this.noGuiaField = value;
            }
        }
        
        /// <comentarios/>
        public string FechaEnvio {
            get {
                return this.fechaEnvioField;
            }
            set {
                this.fechaEnvioField = value;
            }
        }
        
        /// <comentarios/>
        public string FechaReclamo {
            get {
                return this.fechaReclamoField;
            }
            set {
                this.fechaReclamoField = value;
            }
        }
        
        /// <comentarios/>
        public string TipoDoc {
            get {
                return this.tipoDocField;
            }
            set {
                this.tipoDocField = value;
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    public delegate void SiniestrosCompletedEventHandler(object sender, SiniestrosCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class SiniestrosCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal SiniestrosCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public Siniestro[] Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((Siniestro[])(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    public delegate void BitacorasCompletedEventHandler(object sender, BitacorasCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class BitacorasCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal BitacorasCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public Bitacora[] Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((Bitacora[])(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    public delegate void UpdateStatusSiniestroDACompletedEventHandler(object sender, UpdateStatusSiniestroDACompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class UpdateStatusSiniestroDACompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal UpdateStatusSiniestroDACompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public Error Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((Error)(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    public delegate void InsertBitacoraDACompletedEventHandler(object sender, InsertBitacoraDACompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class InsertBitacoraDACompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal InsertBitacoraDACompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public Error Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((Error)(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    public delegate void InsertDocumentacionDACompletedEventHandler(object sender, InsertDocumentacionDACompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class InsertDocumentacionDACompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal InsertDocumentacionDACompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public Error Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((Error)(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    public delegate void UpdateFechaRecDocuDACompletedEventHandler(object sender, UpdateFechaRecDocuDACompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class UpdateFechaRecDocuDACompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal UpdateFechaRecDocuDACompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public Error Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((Error)(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    public delegate void InsertDetDocuDACompletedEventHandler(object sender, InsertDetDocuDACompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class InsertDetDocuDACompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal InsertDetDocuDACompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public Error Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((Error)(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    public delegate void ConsultaNumSiniestroDACompletedEventHandler(object sender, ConsultaNumSiniestroDACompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class ConsultaNumSiniestroDACompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal ConsultaNumSiniestroDACompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public NumSiniestro Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((NumSiniestro)(this.results[0]));
            }
        }
    }
}

#pragma warning restore 1591