<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DocPendientes.aspx.cs" Inherits="SDA.App.DocPendientes" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>

<html>
<head id="Head1" runat="server">
    <title>Documentos Pendientes de Enviar</title>
    
    <script>
        function CheckSelections(selection) {
            if (selection.selected.length > 0) {
                Ext.getCmp('btnAgregarAEnvio').enable();
            }
            else {
                Ext.getCmp('btnAgregarAEnvio').disable();
            }
        }
    </script>
</head>
<body>
    <form id="Form1" runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" Theme="Gray"/>        
        
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

        <ext:Store ID="strDocPend" runat="server" GroupField="idsiniestro">
            <Sorters>
                <%--<ext:DataSorter Property="Due" Direction="ASC" />--%>
            </Sorters>
            <Model>
                <ext:Model ID="mdlDocPend" runat="server">
                    <Fields>
                        <ext:ModelField Name="id" Mapping="IdDocumentacion" />
                        <ext:ModelField Name="numsocio" Mapping="NoSocio" />
                        <ext:ModelField Name="idsiniestro" Mapping="IdSiniestro" />
                        <ext:ModelField Name="nombre" Mapping="Nombre" />
                        <ext:ModelField Name="cooperativa" Mapping="Cooperativa" />
                        <ext:ModelField Name="plaza" Mapping="Plaza" />
                        <ext:ModelField Name="sucursal" Mapping="Sucursal" />
                        <ext:ModelField Name="fechaalta" Mapping="FechaAlta" />
                    </Fields>
                </ext:Model>
            </Model>
            <Reader>
                <ext:ArrayReader />
            </Reader>
        </ext:Store>

        <ext:FormPanel ID="frmFiltroAnalisis" runat="server" Border="true" Layout="Form" Title="Filtro Análisis Siniestros"
            Icon="FolderFind" Collapsible="true" AnchorHorizontal="100%" AnchorVertical="100%">
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
                <ext:GridPanel 
                    ID="GridPanel1" 
                    runat="server" 
                    Frame="true"            
                    Title="Documentos Pendientes"                         
                    Icon="ApplicationViewColumns"
                    AutoWidth="true"
                    AutoHeight="true"
                    Layout="FitLayout"
                    StoreID="strDocPend">
                    <ColumnModel ID="ColumnModel1" runat="server">
                        <Columns>
                            <ext:SummaryColumn ID="clSumSiniestro"                        
                                runat="server"
                                Text="Siniestro"                       
                                Sortable="true"
                                DataIndex="idsiniestro"
                                Hideable="false"
                                SummaryType="Count">
                                <SummaryRenderer Handler="return ((value === 0 || value > 1) ? '(' + value +' Siniestros)' : '(1 Siniestro)');" />                            
                            </ext:SummaryColumn>

                            <ext:Column ID="clmSocio" runat="server" Text="Socio" DataIndex="nombre" Flex="1" />
                            <ext:Column ID="clmCooperativa" runat="server" Text="Cooperativa" DataIndex="cooperativa" />
                            <ext:Column ID="clmPlaza" runat="server" Text="Plaza" DataIndex="plaza" />
                            <ext:Column ID="clmSucursal" runat="server" Text="Sucursal" DataIndex="sucursal" />
                            <ext:Column ID="clmSubida" runat="server" Text="Fecha de Subida" DataIndex="fechaalta" />
                        </Columns>
                    </ColumnModel>           
                    <Features>
                        <ext:GroupingSummary ID="Group1" runat="server" GroupHeaderTplString="Siniestro: {name}" HideGroupedHeader="true" EnableGroupingMenu="true">
                        </ext:GroupingSummary>
                    </Features>
                    <SelectionModel>
                        <ext:CheckboxSelectionModel ID="smDocumentos" runat="server" Mode="Multi">
                            <Listeners>
                                <Select Fn="CheckSelections" />
                                <Deselect Fn="CheckSelections" />
                            </Listeners>
                        </ext:CheckboxSelectionModel>
                    </SelectionModel>
                    <Buttons>
                        <ext:Button ID="btnAgregarAEnvio" runat="server" Text="Enviar" Icon="Box" OnDirectClick="PrepararEnvio" Disabled="true" />
                    </Buttons>
                </ext:GridPanel>
            </Items>
        </ext:FormPanel>
        <ext:Window ID="wndDatosEnvio" runat="server" Title="Datos del Envio" Icon="Box" Hidden="true" Width="300" Height="160" Modal="true">
            <Items>
                <ext:FormPanel ID="frmEnvio" runat="server" Frame="false" Padding="5" BodyPadding="2">
                    <Items>
                        <ext:TextField ID="txtGuia" runat="server" EmptyText="N° de Guia" FieldLabel="N° de Guia" AnchorHorizontal="100%" AllowBlank="false" />
                        <ext:DateField ID="dateEnvio" runat="server" EmptyText="Fecha de Envio" FieldLabel="Fecha de Envio" AnchorHorizontal="100%" AllowBlank="false" />
                        <ext:ComboBox ID="cmbPaqueteria" runat="server" StoreID="strPaqueteria" Editable="false"
                            TypeAhead="true" Mode="Local" ForceSelection="true" TriggerAction="All"
                            DisplayField="name" ValueField="id" EmptyText="Paquetería" ValueNotFoundText="Cargando..."
                            FieldLabel="Paquetería" AllowBlank="false">
                        </ext:ComboBox> 
                    </Items>
                    <Buttons>
                        <ext:Button ID="btnEnviar" runat="server" Text="Enviar" Icon="Accept" FormBind="true" OnDirectClick="RealizarEnvio" />
                        <ext:Button ID="btnCancelar" runat="server" Text="Cancelar" Icon="Cancel">
                            <Listeners>
                                <Click Handler="#{wndDatosEnvio}.hide()" />
                            </Listeners>
                        </ext:Button>
                    </Buttons>
                </ext:FormPanel>
            </Items>
        </ext:Window>
    </form>
  </body>
</html>