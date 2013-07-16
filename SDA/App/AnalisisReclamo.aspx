<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="AnalisisReclamo.aspx.cs" Inherits="SDA.App.AnalisisReclamo" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<html>
<head>
<script type="text/javascript">
    var template = '<span style="color:{0};font-weight:800;">{1}</span>';
    
    String.prototype.format = function () {
        var args = arguments;
        return this.replace(/{(\d+)}/g, function (match, number) {
            return typeof args[number] != 'undefined' ? args[number] : match;
        });
    };

    var Estado = function (value) {
        return template.format((value == 'PRE Analisis') ? "#985C4C" :
                               (value == 'Enviado') ? "#7DB1D5" :
                               (value == 'Valoracion') ? "#297ACC" :
                               (value == 'Aprobado') ? "#3EB13E" :
                               (value == 'Cotizacion rechazada') ? "#FF4D4D" : "#5E6E82", value);
    }

    function MostrarMensaje(sender, record, index) {
        Ext.getCmp('txtBitacora').setValue(record.data.mensaje);
    }
    </script>
</head>
<body>
    <ext:ResourceManager ID="ResourceManager1" runat="server" Theme="Gray" />
    
    <ext:Store ID="strCoop" runat="server">
        <Proxy>
            <ext:AjaxProxy runat="server" Url="http://seguros.prybe.coop/WSPrybeBDa/wspbd/wsCargaCombos.asmx/CargaCoop">
                <ActionMethods Read="POST" />
                    <Reader>
                    <ext:XmlReader Record="Cooperativa" />
                </Reader>
            </ext:AjaxProxy>
        </Proxy>
        <Model>
            <ext:Model ID="Model1" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Type="String" Mapping="Id" />
                    <ext:ModelField Name="name" Type="String" Mapping="Nombre" />                        
                </Fields>
            </ext:Model>
        </Model>
        <Listeners>
            <Load Handler="#{cmbCoop}.setValue(#{cmbCoop}.getStore().getAt(0).get('id')); #{cmbPlaza}.clearValue(); #{strPlaza}.load();" />
        </Listeners>         
    </ext:Store>

    <ext:Store ID="strPlaza" runat="server" AutoLoad="false">
        <Proxy>
            <ext:AjaxProxy runat="server" Url="http://seguros.prybe.coop/WSPrybeBDa/wspbd/wsCargaCombos.asmx/CargaPlaza">
                <ActionMethods Read="POST" />
                    <Reader>
                    <ext:XmlReader Record="Plaza" />
                </Reader>
            </ext:AjaxProxy>
        </Proxy>
        <Model>
            <ext:Model ID="Model2" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Type="String" Mapping="Id" />
                    <ext:ModelField Name="name" Type="String" Mapping="Nombre" />                        
                </Fields>
            </ext:Model>
        </Model>
        <Parameters>
            <ext:StoreParameter Name="IdCoop" Value="#{cmbCoop}.getValue()" Mode="Raw" />              
        </Parameters>
        <Listeners>
            <Load Handler="#{cmbPlaza}.setValue(#{cmbPlaza}.getStore().getAt(0).get('id')); #{cmbSucursal}.clearValue(); #{strSucursal}.load();" />
        </Listeners>          
    </ext:Store>

    <ext:Store ID="strSucursal" runat="server" AutoLoad="false">
        <Proxy>
            <ext:AjaxProxy runat="server" Url="http://seguros.prybe.coop/WSPrybeBDa/wspbd/wsCargaCombos.asmx/CargaSucursal">
                <ActionMethods Read="POST" />
                    <Reader>
                    <ext:XmlReader Record="Sucursal" />
                </Reader>
            </ext:AjaxProxy>
        </Proxy>
        <Model>
            <ext:Model ID="Model3" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Type="String" Mapping="Id" />
                    <ext:ModelField Name="name" Type="String" Mapping="Nombre" />                        
                </Fields>
            </ext:Model>
        </Model>
        <Parameters>
            <ext:StoreParameter Name="IdPlaza" Value="#{cmbPlaza}.getValue()" Mode="Raw" />              
        </Parameters>
        <Listeners>
            <Load Handler="#{cmbSucursal}.setValue(#{cmbSucursal}.store.getAt(0).get('id'));" />
        </Listeners> 
    </ext:Store> 

    <ext:Store ID="strBitacora" runat="server">
        <Model>
            <ext:Model ID="Model4" runat="server">
                <Fields>
                    <ext:ModelField Name="numbitacora" Mapping="IdBitacora" />
                    <ext:ModelField Name="fecha" Mapping="Fecha" Type="Date" />
                    <ext:ModelField Name="status" Mapping="Status" />
                    <ext:ModelField Name="usuario" Mapping="Usuario" />
                    <ext:ModelField Name="mensaje" Mapping="Mensaje" />
                </Fields>
            </ext:Model>
        </Model>
        <Reader>
            <ext:ArrayReader />
        </Reader>
    </ext:Store>

    <ext:Store ID="strReclamosGral" runat="server">
        <Model>
            <ext:Model ID="Model5" runat="server">
                <Fields>
                    <ext:ModelField Name="numsiniestro" Mapping="NoSiniestro" />
                    <ext:ModelField Name="numsocio" Mapping="NoSocio" />
                    <ext:ModelField Name="nombre" Mapping="Nombre" />
                    <ext:ModelField Name="fecharec" Mapping="FechaReclamo" />
                    <ext:ModelField Name="estadosiniestro" Mapping="StatusSiniestro" />
                </Fields>
            </ext:Model>
        </Model>
        <Reader>
            <ext:ArrayReader />
        </Reader>
    </ext:Store>

    <ext:Store ID="strEnvio" runat="server">
        <Model>
            <ext:Model ID="Model6" runat="server">
                <Fields>
                    <ext:ModelField Name="numdocumentacion" Mapping="IdDocumentacion" />
                    <ext:ModelField Name="paqueteria" Mapping="Paqueteria" />
                    <ext:ModelField Name="numguia" Mapping="NoGuia" />
                    <ext:ModelField Name="fechaenvio" Mapping="FechaEnvio" />
                    <ext:ModelField Name="fechareclamo" Mapping="FechaReclamo" />
                </Fields>
            </ext:Model>
        </Model>
        <Reader>
            <ext:ArrayReader />
        </Reader>
    </ext:Store>

    <ext:Store ID="strArchivos" runat="server">
        <Model>
            <ext:Model ID="Model7" runat="server">
                <Fields>
                    <ext:ModelField Name="numdoc" Mapping="TipoDoc" />
                </Fields>
            </ext:Model>
        </Model>
        <Reader>
            <ext:ArrayReader />
        </Reader>
    </ext:Store>

    <ext:FormPanel ID="frmAnalisisNuevo" runat="server" Border="true" Layout="Form" Title="Filtro Análisis Siniestros"
        AutoWidth="true" AutoHeight="true" Icon="FolderFind">
        <Items> 
            <ext:Panel ID="pnlFiltro" runat="server" Border="false" Header="false" Height="50"
                Layout="Column" Padding="10" BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')">
                <Items> 
                    <ext:Panel runat="server" ID="plnCooperativa" Layout="Form" LabelAlign="Right" LabelWidth="90"
                        ColumnWidth=".26" BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')"
                        Border="false">
                        <Items>
                            <ext:ComboBox ID="cmbCoop" runat="server" StoreID="strCoop" Editable="true" Width="130"
                                TypeAhead="true" Mode="Local" ForceSelection="true" TriggerAction="All" SelectOnFocus="true"
                                DisplayField="name" ValueField="id" ValueNotFoundText="Cargando..." EmptyText="Selecciona tu cooperativa..."
                                FieldLabel="Cooperativa" Resizable="true">
                                <Listeners>
                                    <Select Handler="#{cmbPlaza}.clearValue();#{strPlaza}.load();" />
                                </Listeners>                           
                            </ext:ComboBox>                     
                        </Items>
                    </ext:Panel>
                    <ext:Panel runat="server" ID="plnPlaza" Layout="Form" LabelAlign="Right" LabelWidth="65"
                        ColumnWidth=".24" Border="false" BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')">
                        <Items>
                            <ext:ComboBox ID="cmbPlaza" runat="server" StoreID="strPlaza" Editable="true" Width="130"
                                TypeAhead="true" Mode="Local" ForceSelection="true" TriggerAction="All" SelectOnFocus="true"
                                DisplayField="name" ValueField="id" ValueNotFoundText="Cargando..." EmptyText="Selecciona tu Plaza..."
                                FieldLabel="Plaza">
                                <Listeners>
                                    <Select Handler="#{cmbSucursal}.clearValue();#{strSucursal}.load();" />
                                </Listeners>                          
                            </ext:ComboBox>
                        </Items>
                    </ext:Panel>
                    <ext:Panel runat="server" ID="plnSucursal" Layout="Form" LabelAlign="Right" LabelWidth="75"
                        ColumnWidth=".25" Border="false" BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')">
                        <Items>
                            <ext:ComboBox ID="cmbSucursal" runat="server" StoreID="strSucursal" Editable="false"
                                Width="130" TypeAhead="true" Mode="Local" ForceSelection="true" TriggerAction="All"
                                DisplayField="name" ValueField="id" EmptyText="Selecciona tu Sucursal..." ValueNotFoundText="Cargando..."
                                FieldLabel="Sucursal">
                            </ext:ComboBox>                      
                        </Items>
                    </ext:Panel>
                    <ext:Panel runat="server" ID="pnlBusquedaSiniestro" Layout="Form" LabelAlign="Right"
                        LabelWidth="20" ColumnWidth=".25" Border="false" BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')">
                        <Items>
                            <ext:FieldContainer ID="fcBusqSiniestro" runat="server" Layout="ColumnLayout">
                                <Items>
                                    <ext:TextField ID="txtNumSocio" runat="server" EmptyText="No. Socio (Opcional)" ColumnWidth=".5" />
                                    <ext:Button ID="btnBuscar" runat="server" Text="Buscar" Icon="Find" ColumnWidth=".5">
                                        <DirectEvents>
                                            <Click OnEvent="BuscarSiniestros"></Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </Items>
                            </ext:FieldContainer>
                        </Items>
                    </ext:Panel>
                </Items>                     
            </ext:Panel>
            <ext:Panel ID="Panel1" runat="server" Layout="Form" Border="true">
                <Items>
                    <ext:GridPanel ID="grdAnalisis" runat="server" Height="460" Border="false" Title="Siniestros"
                        AutoWidth="true" StoreID="strReclamosGral" Region="Center" Icon="PageEdit" Frame="false">
                        <Features>                                               
                            <ext:GridFilters>
                                <Filters>
                                    <ext:StringFilter DataIndex="numsocio" />
                                    <ext:NumericFilter DataIndex="numsiniestro"/>
                                    <ext:StringFilter DataIndex="nombre" />                                                                              
                                    <ext:ListFilter DataIndex="estadob"  
                                        Options="Verificado,Falta Documento,PRE Analisis, Enviado, Valoracion,
                                        Aprobado,Liberado" />
                                </Filters>
                            </ext:GridFilters>
                        </Features>
                        <ColumnModel>
                            <Columns>
                                <ext:Column runat="server" Header="No. Siniestro" DataIndex="numsiniestro" Align="Left"></ext:Column>
                                <ext:Column runat="server" ColumnID="Socio" Header="No. Socio" DataIndex="numsocio" Align="Left"></ext:Column>
                                <ext:Column runat="server" Width="250" Header="Nombre" DataIndex="nombre" Align="Left" Flex="1"></ext:Column>
                                <ext:Column runat="server" Header="Estado Siniestro" DataIndex="estadosiniestro" Align="Center">
                                    <Renderer Fn="Estado" />
                                </ext:Column>
                            </Columns>
                        </ColumnModel>
                        <SelectionModel>
                            <ext:RowSelectionModel ID="RowSelectionModel1" runat="server"   >
                                <DirectEvents>
                                    <Select OnEvent="InformacionSiniestro">
                                        <ExtraParams>
                                            <ext:Parameter Name="ID" Value="Ext.value(record.data.numsiniestro)" Mode="Raw" ></ext:Parameter>
                                        </ExtraParams>                                                                                                                      
                                    </Select>
                                </DirectEvents>
                                </ext:RowSelectionModel>
                        </SelectionModel>
                        <BottomBar>
                            <ext:PagingToolbar ID="PagingToolbar1" runat="server" PageSize="15" HideRefresh="true" />
                        </BottomBar>
                    </ext:GridPanel>
                </Items>
            </ext:Panel>
        </Items>             
    </ext:FormPanel>
  
    <ext:Window 
        ID="wndInformacionSiniestro" 
        runat="server" 
        Icon="Group" 
        Title="Analísis del Siniestro"
        Width="800"
        Height="600"
        Closable="false"
        Hidden="true"
        Modal="true"
        ButtonAlign="Center"
        Layout="FitLayout">
        <Items>     
            <ext:TabPanel ID="tabSiniestro" runat="server" Layout="FitLayout">
                <Items>
                    <ext:Panel ID="paneInfo" runat="server" Title="Informacion" Layout="ColumnLayout" Padding="20">
                        <Items>
                            <ext:Panel ID="paneLabels" runat="server" ColumnWidth=".4" Border="false">
                                <Items>
                                    <ext:Label ID="dspNumeroSiniestro" runat="server" Text="Número de Siniestro: " Width="150" StyleSpec="color: #696969; font-weight:700; font-size:14px;"/>
                                    <ext:Label runat="server" Html="<br />" />
                                    <ext:Label ID="dspNumeroSocio" runat="server" Text="Número de Socio: " Width="150" StyleSpec="color: #696969; font-weight:700; font-size:14px;"/>
                                    <ext:Label ID="Label1" runat="server" Html="<br />" />
                                    <ext:Label ID="dspNombreSocio" runat="server" Text="Nombre: " Width="150" StyleSpec="color: #696969; font-weight:700; font-size:14px;"/>
                                    <ext:Label ID="Label2" runat="server" Html="<br />" />
                                    <ext:Label ID="dspOcupacionSocio" runat="server" Text="Ocupación: " Width="150" StyleSpec="color: #696969; font-weight:700; font-size:14px;"/>
                                    <ext:Label ID="Label3" runat="server" Html="<br />" />
                                    <ext:Label ID="dspCooperativa" runat="server" Text="Cooperativa: " Width="150" StyleSpec="color: #696969; font-weight:700; font-size:14px;"/>
                                    <ext:Label ID="Label4" runat="server" Html="<br />" />
                                    <ext:Label ID="dspPlaza" runat="server" Text="Plaza: " Width="150" StyleSpec="color: #696969; font-weight:700; font-size:14px;"/>
                                    <ext:Label ID="Label5" runat="server" Html="<br />" />
                                    <ext:Label ID="dspSucursalSocio" runat="server" Text="Sucursal: " Width="150" StyleSpec="color: #696969; font-weight:700; font-size:14px;"/>
                                    <ext:Label ID="Label6" runat="server" Html="<br />" />
                                    <ext:Label ID="dspEstadoBeneficio" runat="server" Text="Estado del Siniestro: " Width="150" StyleSpec="color: #696969; font-weight:700; font-size:14px;"/>
                                </Items>
                            </ext:Panel>
                            <ext:Panel ID="paneData" runat="server" ColumnWidth=".6" Border="false">
                                <Items>
                                    <ext:Label ID="lblNumeroSiniestro" runat="server" Width="300" StyleSpec="color: #246BB2; font-weight:bold; font-size:24px;"/>
                                    <ext:Label ID="Label7" runat="server" Html="<br />" />
                                    <ext:Label ID="lblNumeroSocio" runat="server" Width="250" StyleSpec="font-weight:bold;font-size:16px;"/>
                                    <ext:Label ID="Label8" runat="server" Html="<br />" />
                                    <ext:Label ID="lblNombreSocio" runat="server" Width="250" />
                                    <ext:Label ID="Label9" runat="server" Html="<br />" />
                                    <ext:Label ID="lblOcupacionSocio" runat="server" Width="250" />
                                    <ext:Label ID="Label10" runat="server" Html="<br />" />
                                    <ext:Label ID="lblCooperativa" runat="server" Width="300" />
                                    <ext:Label ID="Label11" runat="server" Html="<br />" />
                                    <ext:Label ID="lblPlaza" runat="server" Width="300" />
                                    <ext:Label ID="Label12" runat="server" Html="<br />" />
                                    <ext:Label ID="lblSucursalSocio" runat="server" Width="250" />
                                    <ext:Label ID="Label13" runat="server" Html="<br />" />
                                    <ext:ComboBox ID="cmbEstadoBeneficio" runat="server" Width="250" />
                                </Items>
                            </ext:Panel>
                        </Items>
                    </ext:Panel>
                    <ext:Panel ID="paneBitacora" runat="server" Title="Bitacora" Layout="ColumnLayout">
                        <Items>
                            <ext:GridPanel ID="grdBitacora" runat="server" ColumnWidth=".6" StoreID="strBitacora">
                                <ColumnModel>
                                    <Columns>
                                        <ext:Column runat="server" Header="Fecha" DataIndex="fecha" Align="Center" />
                                        <ext:Column runat="server" Header="Estado" DataIndex="status" Align="Center" />
                                        <ext:Column runat="server" Header="Usuario" DataIndex="usuario" Align="Left" Flex="1" />
                                    </Columns>
                                </ColumnModel>
                                <Listeners>
                                    <Select Fn="MostrarMensaje" />
                                </Listeners>
                                <Buttons>
                                    <ext:Button ID="btnNuevaBitacora" runat="server" Icon="Pencil" Text="Nueva Entrada" OnDirectClick="NuevaBitacora" />
                                </Buttons>
                            </ext:GridPanel>
                            <ext:FormPanel ID="frmBitacora" runat="server" ColumnWidth=".4" Title="Detalles/Nueva Bitacora" Border="false" Layout="FitLayout">
                                <Items>
                                    <ext:TextArea ID="txtBitacora" runat="server" EmptyText="Escriba aquí el texto de la bitacora..." Height="300" Width="120" ReadOnly="true" AllowBlank="false" />
                                </Items>
                                <Buttons>
                                    <ext:Button ID="btnGuardarBitacora" runat="server" Text="Guardar" Icon="Disk" Hidden="true" FormBind="true" />
                                    <ext:Button ID="btnCancelarBitacora" runat="server" Text="Cancelar" Icon="Cancel" Hidden="true" OnDirectClick="RestaurarBitacora" />
                                </Buttons>
                            </ext:FormPanel>
                        </Items>
                    </ext:Panel>
                    <ext:Panel ID="paneArchivos" runat="server" Title="Archivos" Layout="ColumnLayout">
                        <Items>
                            <ext:GridPanel ID="grdArchivos" runat="server" ColumnWidth=".6" StoreID="strEnvio">
                                <ColumnModel>
                                    <Columns>
                                        <ext:Column runat="server" Header="Fecha Envio" DataIndex="fechaenvio" Align="Center" />
                                        <ext:Column runat="server" Header="Paquteria" DataIndex="paqueteria" Align="Center" />
                                        <ext:Column runat="server" Header="N° Guia" DataIndex="numguia" Align="Left" Flex="1"/>
                                    </Columns>
                                </ColumnModel>
                                <DirectEvents>
                                    <Select OnEvent="DocumentosEnvio" >
                                        <ExtraParams>
                                            <ext:Parameter Name="ID" Value="Ext.value(record.data.numdocumentacion)" Mode="Raw" />
                                        </ExtraParams>
                                    </Select>
                                </DirectEvents>
                                <Buttons>
                                    <ext:Button ID="btnNuevoEnvio" runat="server" Icon="Box" Text="Nuevo Envio" OnDirectClick="NuevoEnvio" />
                                </Buttons>
                            </ext:GridPanel>
                            <ext:FormPanel ID="frmArchivos" runat="server" ColumnWidth=".4" Title="Detalles/Nuevo Archivo" >
                                <Items>
                                    <ext:FormPanel ID="frmArchivosOpciones" runat="server" Border="false" Padding="5">
                                        <Items>
                                            <ext:CheckboxGroup ID="chkGroup" runat="server" ColumnsNumber="2">
                                                <Items>
                                                    <ext:Checkbox ID="chkDoc1" CellId="1" runat="server" ReadOnly="true" BoxLabel="Solicitud de Beneficios" IndicatorTip="Original de Formato de Solicitud de Beneficios" />
                                                    <ext:Checkbox ID="chkDoc2" CellId="2" runat="server" ReadOnly="true" BoxLabel="Solicitud de Ingreso" IndicatorTip="Original de Solicitud de ingreso" />
                                                    <ext:Checkbox ID="chkDoc3" CellId="3" runat="server" ReadOnly="true" BoxLabel="Designacion de Beneficiarios" IndicatorTip="Original de Designación de beneficiarios" />
                                                    <ext:Checkbox ID="chkDoc4" CellId="4" runat="server" ReadOnly="true" BoxLabel="Contrato de Dep. a Plazo Fijo Inicial y Subsecuentes" IndicatorTip="Original de Contrato de depósito a plazo fijo inicial y subsecuentes" />
                                                    <ext:Checkbox ID="chkDoc5" CellId="5" runat="server" ReadOnly="true" BoxLabel="Solicitud de Prestamo de cada credito reclamado" IndicatorTip="Original de Solicitud de préstamo (de cada uno de los créditos reclamados)" />
                                                    <ext:Checkbox ID="chkDoc6" CellId="6" runat="server" ReadOnly="true" BoxLabel="Pagaré o Línea de Crédito" IndicatorTip="Original de Pagaré o línea de crédito (de cada uno de los créditos reclamados)" />
                                                    <ext:Checkbox ID="chkDoc7" CellId="7" runat="server" ReadOnly="true" BoxLabel="Auxiliar de Parte Social" IndicatorTip="Original de Auxiliar de parte social" />
                                                    <ext:Checkbox ID="chkDoc8" CellId="8" runat="server" ReadOnly="true" BoxLabel="Auxiliar de Cada Cuenta de Captación" IndicatorTip="Original de Auxiliar de cada una de las cuentas de captación" />
                                                    <ext:Checkbox ID="chkDoc9" CellId="9" runat="server" ReadOnly="true" BoxLabel="Auxiliar de Cada Préstamo" IndicatorTip="Original de Auxiliar de cada préstamo reclamado" />
                                                    <ext:Checkbox ID="chkDoc10" CellId="10" runat="server" ReadOnly="true" BoxLabel="Acta de Defunción del Socio" IndicatorTip="Original Acta de defunción del socio" />
                                                    <ext:Checkbox ID="chkDoc11" CellId="11" runat="server" ReadOnly="true" BoxLabel="Acta de Nacimiento del Socio" IndicatorTip="Copia de Acta de nacimiento del socio" />
                                                    <ext:Checkbox ID="chkDoc12" CellId="12" runat="server" ReadOnly="true" BoxLabel="Acta de Nacimiento de cada Beneficiario" IndicatorTip="Copia de Acta de nacimiento de cada uno de los beneficiarios" />
                                                    <ext:Checkbox ID="chkDoc13" CellId="13" runat="server" ReadOnly="true" BoxLabel="Identificación Oficial del Socio" IndicatorTip="Copia de Identificación oficial del socio" />
                                                    <ext:Checkbox ID="chkDoc14" CellId="14" runat="server" ReadOnly="true" BoxLabel="Identificación Oficial de Cada Beneficiario" IndicatorTip="Copia de Identificación oficial de cada uno de los beneficiarios" />
                                                    <ext:Checkbox ID="chkDoc15" CellId="15" runat="server" ReadOnly="true" BoxLabel="Parte del Ministerio Público" IndicatorTip="Parte Oficial del M.P., para aquellos casos de que el fallecimiento hubiera sido de manera violenta (homicidio, suicidio, accidental)" />
                                                    <ext:Checkbox ID="chkDoc16" CellId="16" runat="server" ReadOnly="true" BoxLabel="Dictamen Médico" IndicatorTip="Dictamen médico emitido por una institución pública del sector salud (IMSS, ISSSTE, SSA) que determine la incapacidad total y permanente a causa de accidente" />
                                                </Items>
                                            </ext:CheckboxGroup>
                                        </Items>
                                    </ext:FormPanel>
                                    <ext:FormPanel ID="frmArchivosOpciones2" runat="server" Border="false" Padding="5" AnchorHorizontal="100">
                                        <Items>
                                            <ext:DateField ID="dateEnvio" runat="server" ReadOnly="true" FieldLabel="Fecha de Envio" AllowBlank="false" />
                                            <ext:FileUploadField ID="fileSelector" runat="server" FieldLabel="Archivo" ReadOnly="true" AllowBlank="false" />
                                            <ext:TextField ID="txtGuia" runat="server" EmptyText="N° de Guia" FieldLabel="Guia" ReadOnly="true" AllowBlank="false" />
                                            <ext:ComboBox ID="cmbPaqueteria" runat="server" FieldLabel="Paqueteria" ReadOnly="true" AllowBlank="false" />
                                        </Items>
                                    </ext:FormPanel>
                                </Items>
                                <Buttons>
                                    <ext:Button ID="btnGuardarArchivo" runat="server" Text="Guardar" Icon="Disk" Hidden="true" FormBind="true">
                                        <DirectEvents>
                                            <Click OnEvent="UploadFile" />
                                        </DirectEvents>
                                    </ext:Button>
                                    <ext:Button ID="btnCancelarArchivo" runat="server" Text="Cancelar" Icon="Cancel" Hidden="true" OnDirectClick="RestaurarArchivos" />
                                </Buttons>
                            </ext:FormPanel>
                        </Items>
                    </ext:Panel>
                </Items>
            </ext:TabPanel>                                
        </Items>
        <Buttons>
            <ext:Button ID="CancelButton" runat="server" Text="Cerrar" Icon="Cancel">
                <Listeners>
                    <Click Handler="#{wndInformacionSiniestro}.hide();" />
                </Listeners>
            </ext:Button>
        </Buttons>
    </ext:Window>
</body>