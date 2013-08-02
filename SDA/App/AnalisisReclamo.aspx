<%@ Page Title="Analisis del Siniestro" Language="C#" AutoEventWireup="true" CodeBehind="AnalisisReclamo.aspx.cs" Inherits="SDA.App.AnalisisReclamo" ValidateRequest="false" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register TagPrefix="SDA" TagName="FileUploadBit" Src="/App/FileUploadBit.ascx" %>

<!DOCTYPE html>

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
            return template.format((value == 'Analisis') ? "#DBA901" :
                (value == 'Enviado') ? "#B45F04" :
                (value == 'Recibido') ? "#328ED3" :
                (value == 'Proceso de pago') ? "#194B96" :
                (value == 'Rechazado') ? "#DF0101" :
                (value == 'Req. Adicional') ? "#8904B1" :
                (value == 'Pagado') ? "#0F9726" : "#5E6E82", value);
        }

        function MostrarMensaje(sender, record, index) {
            Ext.getCmp('txtBitacora').setValue(record.data.mensaje);
        }
    </script>
    <style type="text/css">
        .fieldInfo 
        {
            color: #696969;
            font-weight: 700;
            font-size: 14px;
            width: 200px;
        }
    </style>
    <%--<link href="/Styles/Site.css" type="text/css" rel="Stylesheet" />--%>
</head>
<body>
    <ext:ResourceManager ID="ResourceManager1" runat="server" Theme="Gray" />
    
    <ext:Store ID="strCoop" runat="server">
        <Proxy>
            <ext:AjaxProxy runat="server" Url="http://qa.prybe.coop/WSPrybeBDa/wspbd/wsCargaCombos.asmx/CargaCoop">
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
            <ext:AjaxProxy runat="server" Url="http://qa.prybe.coop/WSPrybeBDa/wspbd/wsCargaCombos.asmx/CargaPlaza">
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
            <ext:AjaxProxy runat="server" Url="http://qa.prybe.coop/WSPrybeBDa/wspbd/wsCargaCombos.asmx/CargaSucursal">
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

    <ext:Store ID="strPaqueteria" runat="server">
        <Proxy>
            <ext:AjaxProxy runat="server" Url="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsCargaCombosBene.asmx/CargaPaqueteria">
                <ActionMethods Read="POST" />
                    <Reader>
                    <ext:XmlReader Record="Paqueterias" />
                </Reader>
            </ext:AjaxProxy>
        </Proxy>
        <Model>
            <ext:Model ID="Model8" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Type="String" Mapping="Id" />
                    <ext:ModelField Name="name" Type="String" Mapping="Name" />                        
                </Fields>
            </ext:Model>
        </Model>
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

    <ext:Store ID="strEstadosSin" runat="server">
        <Proxy>
            <ext:AjaxProxy runat="server" Url="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsCargaCombosBene.asmx/CargaEstadosSiniestros">
                <ActionMethods Read="POST" />
                    <Reader>
                    <ext:XmlReader Record="EstadoSiniestro" />
                </Reader>
            </ext:AjaxProxy>
        </Proxy>
        <Model>
            <ext:Model ID="Model9" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Type="String" Mapping="Id" />
                    <ext:ModelField Name="name" Type="String" Mapping="Name" />                        
                </Fields>
            </ext:Model>
        </Model>
    </ext:Store>
    

    <ext:FormPanel ID="frmFiltroAnalisis" runat="server" Border="true" Layout="Form" Title="Filtro Análisis Siniestros"
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
                                FieldLabel="Cooperativa" Resizable="true" LabelAlign="Right">
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
                                FieldLabel="Plaza" LabelAlign="Right">
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
                                FieldLabel="Sucursal" LabelAlign="Right">
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
            <ext:Panel ID="Panel1" runat="server" Border="true">
                <Items>
                    <ext:GridPanel ID="grdAnalisis" runat="server" Border="false" Title="Siniestros"
                        AutoWidth="true" StoreID="strReclamosGral" Icon="PageEdit" Frame="false">
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
                                <ext:Column ID="Column1" runat="server" Header="No. Siniestro" DataIndex="numsiniestro" Align="Left"></ext:Column>
                                <ext:Column ID="Column2" runat="server" ColumnID="Socio" Header="No. Socio" DataIndex="numsocio" Align="Left"></ext:Column>
                                <ext:Column ID="Column3" runat="server" Width="250" Header="Nombre" DataIndex="nombre" Align="Left" Flex="1"></ext:Column>
                                <ext:Column ID="Column4" runat="server" Header="Estado Siniestro" DataIndex="estadosiniestro" Align="Center">
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
            <ext:TabPanel ID="tabSiniestro" runat="server">
                <Items>
                    <ext:Panel ID="paneLabels" runat="server" Border="false" Title="Información" Padding="20" Margins="0 0 0 180">
                        <Items>
                            <ext:DisplayField ID="dspNumeroSiniestro" LabelAlign="Right" LabelWidth="150" runat="server" FieldLabel="Número de Siniestro" FieldCls="fieldInfo" />      
                            <ext:DisplayField ID="dspNumeroSocio" LabelAlign="Right" LabelWidth="150" runat="server" FieldLabel="Número de Socio" FieldCls="fieldInfo" />
                            <ext:DisplayField ID="dspNombreSocio" LabelAlign="Right" LabelWidth="150" runat="server" FieldLabel="Nombre" FieldCls="fieldInfo" />
                            <ext:DisplayField ID="dspOcupacionSocio" LabelAlign="Right" LabelWidth="150" runat="server" FieldLabel="Ocupacion" FieldCls="fieldInfo" />
                            <ext:DisplayField ID="dspCooperativa" LabelAlign="Right" LabelWidth="150" runat="server" FieldLabel="Cooperativa" FieldCls="fieldInfo" />
                            <ext:DisplayField ID="dspPlaza" LabelAlign="Right" LabelWidth="150" runat="server" FieldLabel="Plaza" FieldCls="fieldInfo" />
                            <ext:DisplayField ID="dspSucursal" LabelAlign="Right" LabelWidth="150" runat="server" FieldLabel="Sucursal" FieldCls="fieldInfo" />
                            <ext:ComboBox ID="cmbEstadoSin" runat="server" StoreID="strEstadosSin" Editable="false" TypeAhead="true" Mode="Local"
                                ForceSelection="true" TriggerAction="All" FieldLabel="Estado" LabelWidth="150" LabelAlign="Right"
                                DisplayField="name" ValueField="id" EmptyText="Estado del Siniestro" ValueNotFoundText="Cargando...">
                                <Listeners>
                                    <Select Handler="#{btnGuardarEstadoSin}.setDisabled(false)" />
                                </Listeners>
                            </ext:ComboBox> 
                            <ext:Button ID="btnGuardarEstadoSin" Text="Guardar Estado" runat="server" Icon="Disk" Disabled="true" StyleSpec="margin-left: 200px;" OnDirectClick="UpdateEstadoSiniestro">
                                <DirectEvents>
                                    <Click OnEvent="UpdateEstadoSiniestro">
                                        <ExtraParams>
                                            <ext:Parameter Name="EstadoSin" Value="#{cmbEstadoSin}.getValue()" Mode="Raw" />
                                        </ExtraParams>
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                        </Items>
                    </ext:Panel>
                    <ext:Panel ID="paneBitacora" runat="server" Title="Bitacora" Layout="ColumnLayout">
                        <Items>
                            <ext:GridPanel ID="grdBitacora" runat="server" ColumnWidth=".6" StoreID="strBitacora">
                                <ColumnModel>
                                    <Columns>
                                        <ext:DateColumn ID="Column5" runat="server" Header="Fecha" DataIndex="fecha" Align="Center" Format="dd/MM/yyyy" />
                                        <ext:Column ID="Column6" runat="server" Header="Estado" DataIndex="status" Align="Center" />
                                        <ext:Column ID="Column7" runat="server" Header="Usuario" DataIndex="usuario" Align="Left" Flex="1" />
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
                                    <ext:HtmlEditor ID="txtBitacora" runat="server" Height="400" Width="120" ReadOnly="true" />
                                </Items>
                                <Buttons>
                                    <ext:Button ID="btnGuardarBitacora" runat="server" Text="Guardar" Icon="Disk" Hidden="true" OnDirectClick="InsertarBitacora" FormBind="true" />
                                    <ext:Button ID="btnCancelarBitacora" runat="server" Text="Cancelar" Icon="Cancel" Hidden="true" OnDirectClick="RestaurarBitacora" />
                                </Buttons>
                            </ext:FormPanel>
                        </Items>
                    </ext:Panel>
                    <ext:Panel ID="paneLol" Title="Archivos" runat="server" >
                        <Content>
                            <SDA:FileUploadBit ID="FileUploadBit1" runat="server" />
                        </Content>
                        <Listeners>
                            <Activate Handler="#{paneArchivos}.doLayout();" />
                        </Listeners>
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
        <Listeners>
            <Show Handler="App.direct.FileUploadBit1.CargarArchivos();" />
        </Listeners>
    </ext:Window>
</body>