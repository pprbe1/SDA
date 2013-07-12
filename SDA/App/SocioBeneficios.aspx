<%@ Page Title="LOL" Language="C#" AutoEventWireup="true" CodeBehind="SocioBeneficios.aspx.cs" Inherits="SDA.App.SocioBeneficios" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" Theme="Gray">
        <Listeners>
            <DocumentReady Handler="#{strCoop}.load();#{cmbCoop}.setValue(1);#{strPlaza}.load();#{cmbPlaza}.setValue(1);" />
        </Listeners>    
    </ext:ResourceManager>

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
            <Load Handler="#{cmbCoop}.setValue(#{cmbCoop}.store.getAt(0).get('id'));" />
        </Listeners>            
    </ext:Store>

    <ext:Store ID="strPlaza" runat="server">
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
            <Load Handler="#{cmbPlaza}.setValue(#{cmbPlaza}.store.getAt(0).get('id'));#{cmbSucursal}.clearValue();#{strSucursal}.load();" />
        </Listeners>          
    </ext:Store>

    <ext:Store ID="strSucursal" runat="server">
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

    <ext:Store ID="strOcupacion" runat="server">
        <Proxy>
            <ext:AjaxProxy runat="server" Url="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsCargaCombosBene.asmx/CargaOcupaciones">
                <ActionMethods Read="POST" />
                    <Reader>
                    <ext:XmlReader />
                </Reader>
            </ext:AjaxProxy>
        </Proxy>
        <Model>
            <ext:Model ID="Model4" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Type="String" Mapping="Id" />
                    <ext:ModelField Name="name" Type="String" Mapping="Nombre" />                        
                </Fields>
            </ext:Model>
        </Model>
        <Listeners>
            <Load Handler="#{cmbOcupacion}.setValue(#{cmbOcupacion}.store.getAt(0).get('id'));" />
        </Listeners> 
    </ext:Store>

    <ext:Store ID="strEdoCivil" runat="server">
        <Proxy>
            <ext:AjaxProxy runat="server" Url="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsCargaCombosBene.asmx/CargaCiviles">
                <ActionMethods Read="POST" />
                    <Reader>
                    <ext:XmlReader />
                </Reader>
            </ext:AjaxProxy>
        </Proxy>
        <Model>
            <ext:Model ID="Model5" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Type="String" Mapping="Id" />
                    <ext:ModelField Name="name" Type="String" Mapping="Nombre" />                        
                </Fields>
            </ext:Model>
        </Model>
        <Listeners>
            <Load Handler="#{cmbEdoCivil}.setValue(#{cmbEdoCivil}.store.getAt(0).get('id'));" />
        </Listeners> 
    </ext:Store>

    <ext:Store ID="strDocumentos" runat="server">
        <Proxy>
            <ext:AjaxProxy runat="server" Url="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsCargaCombosBene.asmx/CargaDocumentos">
                <ActionMethods Read="POST" />
                    <Reader>
                    <ext:XmlReader />
                </Reader>
            </ext:AjaxProxy>
        </Proxy>
        <Model>
            <ext:Model ID="Model6" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Type="String" Mapping="Id" />
                    <ext:ModelField Name="name" Type="String" Mapping="Nombre" />                        
                </Fields>
            </ext:Model>
        </Model>
        <Listeners>
            <Load Handler="#{cmbDocumentos}.setValue(#{cmbDocumentos}.store.getAt(0).get('id'));" />
        </Listeners> 
    </ext:Store>

    <ext:Store ID="strDocumentosAgregados" runat="server">
        <Model>
            <ext:Model ID="Model7" runat="server">
                <Fields>
                    <ext:ModelField Name="iddocumento" Mapping="IdDocumento" />
                    <ext:ModelField Name="documento" Mapping="Documento" />
                </Fields>
            </ext:Model>
        </Model>                                      
        <Proxy>
            <ext:JsonPProxy />
        </Proxy>
    </ext:Store>

    <ext:Store ID="strEstado" runat="server">
        <Proxy>
            <ext:AjaxProxy runat="server" Url="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsCargaCombosBene.asmx/CargaEstados">
                <ActionMethods Read="POST" />
                    <Reader>
                    <ext:XmlReader />
                </Reader>
            </ext:AjaxProxy>
        </Proxy>
        <Model>
            <ext:Model ID="Model8" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Type="String" Mapping="Id" />
                    <ext:ModelField Name="name" Type="String" Mapping="Nombre" />                        
                </Fields>
            </ext:Model>
        </Model>
        <Listeners>
            <Load Handler="#{cmbEdo}.setValue(#{cmbEdo}.store.getAt(0).get('id'));" />
        </Listeners>
    </ext:Store>

    <ext:Store ID="strMunicipio" runat="server">
        <Proxy>
            <ext:AjaxProxy runat="server" Url="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsCargaCombosBene.asmx/CargaMunicipios">
                <ActionMethods Read="POST" />
                    <Reader>
                    <ext:XmlReader />
                </Reader>
                <ExtraParams>
                    <ext:Parameter Name="Estado" Value="#{cmbEdo}.getValue()" Mode="Raw"/>
                </ExtraParams>
            </ext:AjaxProxy>
        </Proxy>
        <Model>
            <ext:Model ID="Model9" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Type="String" Mapping="Id" />
                    <ext:ModelField Name="name" Type="String" Mapping="Nombre" />                        
                </Fields>
            </ext:Model>
        </Model>
        <Listeners>
            <Load Handler="#{cmbMnpo}.setValue(#{cmbMnpo}.store.getAt(0).get('id'));#{cmbCol}.clearValue();#{strColonia}.load();" />
        </Listeners> 
    </ext:Store>

    <ext:Store ID="strColonia" runat="server">
        <Proxy>
            <ext:AjaxProxy runat="server" Url="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsCargaCombosBene.asmx/CargaColonias">
                <ActionMethods Read="POST" />
                    <Reader>
                    <ext:XmlReader />
                </Reader>
                <ExtraParams>
                    <ext:Parameter Name="Municipio" Value="#{cmbMnpo}.getValue()" Mode="Raw"/>
                </ExtraParams>
            </ext:AjaxProxy>
        </Proxy>
        <Model>
            <ext:Model ID="Model10" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Type="String" Mapping="Id" />
                    <ext:ModelField Name="name" Type="String" Mapping="Nombre" />                        
                </Fields>
            </ext:Model>
        </Model>
        <Listeners>
            <Load Handler="#{cmbCol}.setValue(#{cmbCol}.store.getAt(0).get('id')); #{cmbCP}.clearValue();#{strCP}.load()" />
        </Listeners> 
    </ext:Store>

    <ext:Store ID="strCP" runat="server">
        <Proxy>
            <ext:AjaxProxy runat="server" Url="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsCargaCombosBene.asmx/CargaCP">
                <ActionMethods Read="POST" />
                    <Reader>
                    <ext:XmlReader />
                </Reader>
                <ExtraParams>
                    <ext:Parameter Name="Municipio" Value="#{cmbMnpo}.getValue()" Mode="Raw" />                    
                    <ext:Parameter Name="Colonia" Value="#{cmbCol}.getText()" Mode="Raw" />
                </ExtraParams>
            </ext:AjaxProxy>
        </Proxy>
        <Model>
            <ext:Model ID="Model11" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Type="String" Mapping="Id" />
                    <ext:ModelField Name="name" Type="String" Mapping="Nombre" />                        
                </Fields>
            </ext:Model>
        </Model>
        <Listeners>
            <Load Handler="#{cmbCP}.setValue(#{cmbCP}.store.getAt(0).get('id'));" />
        </Listeners> 
    </ext:Store>

    <ext:Store ID="strPaqueteria" runat="server">
        <Proxy>
            <ext:AjaxProxy runat="server" Url="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsCargaCombosBene.asmx/CargaPaqueteria">
                <ActionMethods Read="POST" />
                    <Reader>
                    <ext:XmlReader />
                </Reader>
            </ext:AjaxProxy>
        </Proxy>
        <Model>
            <ext:Model ID="Model12" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Type="String" Mapping="Id" />
                    <ext:ModelField Name="name" Type="String" Mapping="Nombre" />                        
                </Fields>
            </ext:Model>
        </Model>
        <Listeners>
            <Load Handler="#{cmbPaqueteria}.setValue(#{cmbPaqueteria}.store.getAt(0).get('id'));" />
        </Listeners> 
    </ext:Store>

    <ext:Panel ID="pnlSocio" runat="server"
        ButtonAlign="Right" Title="Datos Del Socio"
        Border="true" Layout="FormLayout"
        Icon="UserMagnify" Height="280"
        BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')">
        <Items>
            <ext:Panel ID="Panel1" runat="server"
                Border="false" Layout="ColumnLayout"
                Height="250">
                <Items>                    
                    <ext:Panel ID="pnlSocio1" runat="server" 
                        Border="false" 
                        Header="false" 
                        ColumnWidth=".29" 
                        Layout="FormLayout"
                        LabelAlign="Right"                               
                        BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')">
                        <Items>
                            <ext:FieldContainer ID="fcNumSocio" runat="server" FieldBodyCls="Numero de Socio" MsgTarget="Under">
                                <Items>
                                    <ext:TextField ID="txtNumSocio" runat="server" FieldLabel="Número de Socio" AllowBlank="false" StyleSpec="text-transform:uppercase" MaxLength="20" Width="90" />
                                    <ext:Button ID="btnBuscarSocio" runat="server" Icon="Magnifier">
                                        <DirectEvents>
                                            <Click OnEvent="btnBuscaSocio_Click"></Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </Items>
                            </ext:FieldContainer>

                            <ext:ComboBox 
                                ID="cmbCoop"
                                runat="server" 
                                StoreID="strCoop"
                                Editable="false"
                                TypeAhead="true" 
                                QueryMode="Local"
                                ForceSelection="true"
                                TriggerAction="All"            
                                DisplayField="name"
                                ValueField="id"
                                EmptyText="Loading..."
                                ValueNotFoundText="Loading...">

                                 <Listeners>
                                    <Select Handler="#{PlazaStore}.load();" />
                                </Listeners>
                        
                            </ext:ComboBox>
                            <ext:ComboBox 
                                ID="cmbPlaza"
                                runat="server" 
                                StoreID="strPlaza"
                                Editable="false"
                                TypeAhead="true" 
                                QueryMode="Local"
                                ForceSelection="true"
                                TriggerAction="All"            
                                DisplayField="name"
                                ValueField="id"
                                EmptyText="Loading..."
                                ValueNotFoundText="Loading...">
                                <Listeners>
                                    <Select Handler="#{cmbSucursal}.clearValue();#{strSucursal}.load();" />
                                </Listeners>
                            </ext:ComboBox>
                            <ext:ComboBox 
                                ID="cmbSucursal"
                                runat="server" 
                                StoreID="strSucursal"
                                Editable="false"
                                TypeAhead="true" 
                                QueryMode="Local"
                                ForceSelection="true"
                                TriggerAction="All"            
                                DisplayField="name"
                                ValueField="id"
                                EmptyText="Loading..."
                                ValueNotFoundText="Loading...">
                            </ext:ComboBox>
                        </Items>
                    </ext:Panel>

                    <ext:Panel ID="pnlSocio2" 
                        runat="server" 
                        Border="false" 
                        Header="false" 
                        ColumnWidth=".4" 
                        Layout="Form"                               
                        LabelAlign="Right"
                        BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')"
                        LabelWidth="115">  
                        <Items>
                            <ext:FieldContainer ID="fcNombres" runat="server" FieldLabel="Nombre(s)" MsgTarget="Under" Disabled="true">
                                <Items>
                                    <ext:TextField ID="txtNombre" runat="server" EmptyText="Primer Nombre" AllowBlank="false" DataIndex="Nombre"
                                                    MaxLength="20" MinLength="2" StyleSpec="text-transform:uppercase" Width="118" />
                                    <ext:TextField ID="txtNombre2" runat="server" EmptyText="Segundo Nombre" MaxLength="20" 
                                                    StyleSpec="text-transform:uppercase" Width="120" />
                                </Items>
                            </ext:FieldContainer>
                            <ext:FieldContainer ID="fcApellidos" runat="server" FieldLabel="Apellido(s)" MsgTarget="Under" Disabled="true">
                                <Items>
                                    <ext:TextField ID="txtApellidoPat" EmptyText="Primer Apellido" runat="server" AllowBlank="false" DataIndex="Primer Apellido"
                                                    MaxLength="20" MinLength="2" MinLengthText="Debe escribir el apellido" StyleSpec="text-transform:uppercase" Width="118"/>
                                    <ext:TextField ID="txtApellidoMat" EmptyText="Segundo Apellido" runat="server" MaxLength="20" 
                                                    StyleSpec="text-transform:uppercase" Width="120" />
                                </Items>
                            </ext:FieldContainer>
                            <ext:DateField ID="dteFechaN" runat="server" FieldLabel="Fecha Nacimiento" 
                                        EmptyText="dd/mm/aaaa" AllowBlank="false" Width="130px"  MsgTarget="Side" Disabled="true" DataIndex="Fecha Nacimiento" />
                            <ext:DateField ID="dteFechaI" runat="server" FieldLabel="Fecha Ingreso" DataIndex="Fecha Ingreso"
                                        EmptyText="dd/mm/aaaa" AllowBlank="false"  Width="130"  MsgTarget="Side" Disabled="true"/> 
                            <ext:RadioGroup ID="rdoSexo" runat="server" FieldLabel="Sexo" ColumnsNumber="2" Width="145px" Disabled="true" >
                            <Items>
                                <ext:Radio ID="rdoFemenino" runat="server" BoxLabel="Femenino" />
                                <ext:Radio ID="rdoMasculino" runat="server" BoxLabel="Masculino" Checked="true"/>
                            </Items>
                            </ext:RadioGroup>
                            <ext:ComboBox ID="cmbOcupacion" 
                                        runat="server"  
                                        Editable="true" 
                                        TypeAhead="true" 
                                        Resizable="true"
                                        Mode="Local" 
                                        ForceSelection="true" 
                                        TriggerAction="All" 
                                        DisplayField="name" 
                                        ValueField="id"
                                        StyleSpec="text-transform:uppercase"
                                        FieldLabel="Ocupación"  
                                        Width="130" 
                                        StoreID="strOcupacion"
                                        Disabled="true"/>
                            <ext:ComboBox ID="cmbEdoCivil" 
                                        runat="server"  
                                        Editable="true" 
                                        TypeAhead="true" 
                                        Mode="Local" 
                                        ForceSelection="true" 
                                        StoreID="strEdoCivil" 
                                        TriggerAction="All" 
                                        DisplayField="name" 
                                        ValueField="id"
                                        StyleSpec="text-transform:uppercase"
                                        FieldLabel="Estado Civil"  
                                        Width="130"
                                        Disabled="true"/>                                
                        </Items>                         
                    </ext:Panel>
                  
                    <ext:Panel ID="pnlSocio3"
                        runat="server"
                        Border="false"
                        Header="false"
                        ColumnWidth=".31"
                        Layout="Form"
                        LabelAlign="Right"
                        BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')">
                        <Items>
                            <ext:ComboBox 
                                ID="cmbEdo"
                                runat="server"
                                StoreID="strEstado"            
                                Editable="true"
                                TypeAhead="true" 
                                Mode="Local"
                                ForceSelection="true"
                                TriggerAction="All"
                                SelectOnFocus="true"
                                DisplayField="name"
                                ValueField="id"
                                ValueNotFoundText="Cargando..."
                                EmptyText="Selecciona tu estado..." 
                                FieldLabel="Estado"
                                Resizable="True"
                                Disabled="true">    
                                <Listeners>
                                    <Select Handler="#{cmbMunicipio}.clearValue();#{strMunicipio}.load();" />
                                </Listeners>
                            </ext:ComboBox>
                            <ext:ComboBox 
                                ID="cmbMnpo"
                                runat="server" 
                                StoreID="strMunicipio"
                                Editable="true"
                                TypeAhead="true" 
                                Mode="Local"
                                ForceSelection="true"
                                SelectOnFocus="true"
                                TriggerAction="All"            
                                DisplayField="name"
                                ValueField="id"
                                EmptyText="Cargando..."
                                ValueNotFoundText="Cargando..." 
                                FieldLabel="Municipio"
                                Resizable="True"
                                Disabled="true">
                                <Listeners>
                                    <Select Handler="#{cmbColonia}.clearValue();#{strColonia}.load();" />
                                </Listeners>
                            </ext:ComboBox>
                            <ext:ComboBox 
                                ID="cmbCol"
                                runat="server" 
                                StoreID="strColonia"
                                SelectOnFocus="true"
                                Editable="true"
                                TypeAhead="true" 
                                Mode="Local"
                                ForceSelection="true"
                                TriggerAction="All"            
                                DisplayField="name"
                                ValueField="id"
                                EmptyText="Selecciona tu Municipio..."
                                ValueNotFoundText="Cargando..." 
                                FieldLabel="Colonia"
                                Resizable="True"
                                Disabled="true">       
                                <Listeners>
                                    <Select Handler="#{cmbCP}.clearValue();#{strCP}.load();" />
                                </Listeners>
                            </ext:ComboBox>
                            <ext:ComboBox 
                                ID="cmbCP"
                                runat="server" 
                                StoreID="strCP"
                                Editable="false"
                                TypeAhead="true" 
                                Mode="Local"
                                ForceSelection="true"
                                TriggerAction="All"            
                                DisplayField="name"
                                ValueField="id"
                                EmptyText="Selecciona tu CP..."
                                ValueNotFoundText="Cargando..." 
                                FieldLabel="Código Postal"
                                Disabled="true">      
                            </ext:ComboBox>  
                            <ext:TextField ID="txtCalle" runat="server" FieldLabel="Calle" AllowBlank="false" StyleSpec="text-transform:uppercase" MsgTarget="Side" Width="130" Disabled="true"/>
                            <ext:FieldContainer ID="fcNumero" runat="server" FieldLabel="Número" MsgTarget="Under">
                                <Items>
                                    <ext:TextField ID="txtNoExt" DataIndex="Numero" runat="server" EmptyText="Ext" AllowBlank="false" MsgTarget="Side" Width="50" Disabled="true"/>
                                    <ext:TextField ID="txtNoInt" runat="server" EmptyText="Int" Disabled="true" Width="50"/>
                                </Items>
                            </ext:FieldContainer>           
                        </Items>
                    </ext:Panel>
                </Items>
                <FooterBar>
                    <ext:Toolbar ID="Toolbar1" runat="server" AutoHeight="true">
                        <Items>
                            <ext:Button ID="btnCancelarRegistroSocio" runat="server" Text="Cancelar" Icon="Cancel" Disabled="true">
                                <DirectEvents>
                                    <Click OnEvent="btnCancelarRegistroSocio_DirectClick"></Click>
                                </DirectEvents>
                            </ext:Button>
                            <ext:Button ID="btnModificarSocio" runat="server" Text="Guardar" Icon="DiskEdit" Disabled="true">
                                <DirectEvents>
                                    <Click OnEvent="btnModificarSocio_DirectClick"></Click>
                                </DirectEvents>
                            </ext:Button>
                        </Items>
                    </ext:Toolbar>
                </FooterBar>
            </ext:Panel>
        </Items>           
    </ext:Panel>
    <ext:Panel 
        ID="pnlAgregarDocumentacion" 
        Title="Documentos Recibidos"
        runat="server"
        Icon="Page"
        Border="false"
        Frame="false"
        Layout="Form"
        LabelAlign="Right"
        Disabled="true"
        Height="260"
        BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')">
        <Items>
            <ext:FormPanel ID="paneDocumentos"
                runat="server"
                Layout="FormLayout"
                AutoScroll = "true"
                Border = "false">
                <Items>
                    <ext:ComboBox ID="cmbPaqueteria" runat="server" StoreID="strPaqueteria"  FieldLabel="Paquetería" Editable="true" TypeAhead="true" 
                                    Mode="Local" ForceSelection="true" TriggerAction="All" DisplayField="name" ValueField="id" Width="200" />    
                    <ext:TextField ID="txtGuia" runat="server" FieldLabel="Guía de Paquete" AllowBlank="false" MaxLengthText="45" StyleSpec="text-transform:uppercase" Width="200" />
                </Items>
            </ext:FormPanel>
                        
            <ext:Panel ID="pnlGDocumentos" 
                runat="server" 
                Layout="Form" 
                AutoScroll="true" 
                Border="false" >
                <Items>      
                <ext:GridPanel ID="gplDocumentos" 
                    runat="server" 
                    AutoWidth="true"
                    Height="200"
                    StoreID="strDocumentosAgregados" 
                    AutoScroll="true"
                    Layout="FormLayout"
                    ButtonAlign="Center">
                    <ColumnModel>
                        <Columns>
                            <ext:Column ID="Column1" runat="server" Header="Documento Agregado" Width="200" DataIndex="documento" ></ext:Column>
                            <ext:CommandColumn ID="CommandColumn1" ColumnID="iddocumento" runat="server" DataIndex="iddocumento" >
                                <Commands>
                                    <ext:GridCommand Icon="Delete" CommandName="Eliminar" Text="Eliminar" >           
                                    </ext:GridCommand>
                                </Commands>
                            </ext:CommandColumn>
                        </Columns>
                    </ColumnModel>    
                    <SelectionModel>
                        <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" SingleSelect="true" >
                        </ext:RowSelectionModel>
                    </SelectionModel>                                     
                    <DirectEvents>
                        <CellClick OnEvent="CellEliminarDocumento_Click" >
                            <ExtraParams>
                                <ext:Parameter Name="IdDoc" Value="Ext.value(record.data.iddocumento)" Mode="Raw" >
                                </ext:Parameter>
                            </ExtraParams>
                        </CellClick>
                    </DirectEvents>    
                    <TopBar>
                        <ext:Toolbar ID="Toolbar2" runat="server" >
                            <Items>
                                <ext:ToolbarFill ID="ToolbarFill1" runat="server" />
                                <ext:ComboBox ID="cmbDocumentos" 
                                    runat="server" 
                                    FieldLabel="Documento" 
                                    Editable="true" 
                                    TypeAhead="true" 
                                    Width="300"
                                    Mode="Local" 
                                    ForceSelection="true" 
                                    StoreID="strDocumentos" 
                                    TriggerAction="All" 
                                    DisplayField="name" 
                                    ValueField="id" />
                                <ext:Button ID="btnAgregarDocumento" runat="server" Text="Agregar" Icon="PageAdd" LabelAlign="Right">
                                    <DirectEvents>
                                        <Click OnEvent="btnAgregarDocumento_Click" />
                                    </DirectEvents>
                                </ext:Button>     
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Buttons>
                        <ext:Button ID="btnGuardar" runat="server" Text="Guardar" Icon="DiskEdit">                    
                            <DirectEvents>                    
                                <Click OnEvent="btnGuardar_Click"></Click>
                            </DirectEvents>
                        </ext:Button>
                    </Buttons>
                </ext:GridPanel>
            </Items>
            </ext:Panel>
        </Items>          
    </ext:Panel>
    </form>
</body>
</html>