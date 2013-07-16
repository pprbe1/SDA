<%@ Page Title="LOL" Language="C#" AutoEventWireup="true" CodeBehind="SocioBeneficios.aspx.cs" Inherits="SDA.App.SocioBeneficios" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>
<html>
<body>
    <form id="form1" runat="server">
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

    <ext:Store ID="strOcupacion" runat="server">
        <Proxy>
            <ext:AjaxProxy runat="server" Url="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsCargaCombosBene.asmx/CargaOcupaciones">
                <ActionMethods Read="POST" />
                    <Reader>
                    <ext:XmlReader Record="Ocupaciones"/>
                </Reader>
            </ext:AjaxProxy>
        </Proxy>
        <Model>
            <ext:Model ID="Model4" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Type="String" Mapping="Id" />
                    <ext:ModelField Name="name" Type="String" Mapping="Name" />                        
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
                    <ext:XmlReader Record="Civiles" />
                </Reader>
            </ext:AjaxProxy>
        </Proxy>
        <Model>
            <ext:Model ID="Model5" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Type="String" Mapping="Id" />
                    <ext:ModelField Name="name" Type="String" Mapping="Name" />                        
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
                    <ext:XmlReader Record="Documentos"/>
                </Reader>
            </ext:AjaxProxy>
        </Proxy>
        <Model>
            <ext:Model ID="Model6" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Type="String" Mapping="Id" />
                    <ext:ModelField Name="name" Type="String" Mapping="Name" />                        
                </Fields>
            </ext:Model>
        </Model>
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
    <%--STORE ID PARA EL ESTADO--%>        
        <ext:Store runat="server" ID="stEstado">
            <Proxy>
            <ext:AjaxProxy runat="server" Url="http://qa.prybe.coop/WSPrybeBDa/wspbd/wsCargaCombos.asmx/CargaEstados_SPM">
                <ActionMethods Read="POST" />
                    <Reader>
                    <ext:XmlReader Record="Estados" />
                </Reader>
            </ext:AjaxProxy>
        </Proxy>
        <Parameters>
            <ext:StoreParameter Name="Estado" Value="#{cbMunicipio}.getValue()" Mode="Raw" />              
        </Parameters>
        <Model>
            <ext:Model ID="Model13" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Type="String" Mapping="Id" />
                    <ext:ModelField Name="name" Type="String" Mapping="Name" />                        
                </Fields>
            </ext:Model>
        </Model>             
            <Listeners>
                <Load Handler="#{cbEstado}.setValue(#{cbEstado}.store.getAt(0).get('id'));" />
            </Listeners>          
        </ext:Store>
        
        <%--STORE ID PARA EL MUNICIPIO--%>
        <ext:Store runat="server" ID="stMunicipio">
            <Proxy>
            <ext:AjaxProxy runat="server" Url="http://qa.prybe.coop/WSPrybeBDa/wspbd/wsCargaCombos.asmx/CargaMunicipios_SPM">
                <ActionMethods Read="POST" />
                    <Reader>
                    <ext:XmlReader Record="Municipios" />
                </Reader>
            </ext:AjaxProxy>
        </Proxy>
        <Parameters>
            <ext:StoreParameter Name="Municipio" Value="#{cbColonia}.getValue()" Mode="Raw" />              
        </Parameters>
        <Model>
            <ext:Model ID="Model14" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Type="String" Mapping="Id" />
                    <ext:ModelField Name="name" Type="String" Mapping="Name" />                        
                </Fields>
            </ext:Model>
        </Model>        
            <Listeners>
                <Load Handler="#{cbMunicipio}.setValue(#{cbMunicipio}.store.getAt(0).get('id'));#{cbEstado}.clearValue();#{stEstado}.load();" />
            </Listeners>            
        </ext:Store>

         <%--STORE ID PARA LA COLONIA--%>
        <ext:Store runat="server" ID="stColonia">
            <Proxy>
            <ext:AjaxProxy runat="server" Url="http://qa.prybe.coop/WSPrybeBDa/wspbd/wsCargaCombos.asmx/CargaColonias_SPM">
                <ActionMethods Read="POST" />
                    <Reader>
                    <ext:XmlReader Record="Colonias" />
                </Reader>
            </ext:AjaxProxy>
        </Proxy>
        <Parameters>
            <ext:StoreParameter Name="CP" Value="#{txtCP}.getValue()" Mode="Raw" />              
        </Parameters>
        <Model>
            <ext:Model ID="Model15" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Type="String" Mapping="Id" />
                    <ext:ModelField Name="name" Type="String" Mapping="Name" />                        
                </Fields>
            </ext:Model>
        </Model>
            <Listeners>
                <Load Handler="#{cbColonia}.setValue(#{cbColonia}.store.getAt(0).get('id')); #{cbMunicipio}.clearValue();#{stMunicipio}.load()" />
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
            <ext:Model ID="Model12" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Type="String" Mapping="Id" />
                    <ext:ModelField Name="name" Type="String" Mapping="Name" />                        
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
        Icon="UserMagnify" Height="290">
        <Items>
            <ext:Panel ID="Panel1" runat="server"
                Border="false" Layout="ColumnLayout"
                Height="250">
                <Items>                    
                    <ext:Panel ID="pnlSocio1" runat="server" 
                        Border="false" Header="false" BodyPadding="6"
                        ColumnWidth=".29" Layout="FormLayout"
                        Resizable="false" LabelAlign="Right">
                        <Items>
                            <ext:FieldContainer ID="fcNumSocio" runat="server" FieldBodyCls="Numero de Socio" MsgTarget="Under" Layout="ColumnLayout">
                                <Items>
                                    <ext:TextField ID="txtNumSocio" runat="server" FieldLabel="Número de Socio" AllowBlank="false" Margins="0 5 0 0"
                                        MaxLength="10" ColumnWidth=".9" />
                                    <ext:Button ID="btnBuscarSocio" runat="server" Icon="Magnifier">
                                        <DirectEvents>
                                            <Click OnEvent="btnBuscaSocio_Click"></Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </Items>
                            </ext:FieldContainer>
                            <ext:ComboBox 
                                ID="cmbCoop" runat="server"
                                StoreID="strCoop" Editable="false"
                                TypeAhead="true" QueryMode="Local"
                                ForceSelection="true" TriggerAction="All"            
                                DisplayField="name" ValueField="id"
                                EmptyText="Loading..." ValueNotFoundText="Loading...">
                                <Listeners>
                                    <Select Handler="#{strPlaza}.load();" />
                                </Listeners>
                            </ext:ComboBox>
                            <ext:ComboBox 
                                ID="cmbPlaza" runat="server"
                                StoreID="strPlaza" Editable="false"
                                TypeAhead="true" QueryMode="Local"
                                ForceSelection="true" TriggerAction="All"            
                                DisplayField="name" ValueField="id"
                                EmptyText="Loading..." ValueNotFoundText="Loading...">
                                <Listeners>
                                    <Select Handler="#{cmbSucursal}.clearValue(); #{strSucursal}.load();" />
                                </Listeners>
                            </ext:ComboBox>
                            <ext:ComboBox 
                                ID="cmbSucursal" runat="server"
                                StoreID="strSucursal" Editable="false"
                                TypeAhead="true" QueryMode="Local"
                                ForceSelection="true" TriggerAction="All"            
                                DisplayField="name" ValueField="id"
                                EmptyText="Loading..." ValueNotFoundText="Loading...">
                            </ext:ComboBox>
                        </Items>
                    </ext:Panel>

                    <ext:Panel ID="pnlSocio2" 
                        runat="server" Border="false" 
                        Header="false" ColumnWidth=".4" 
                        Layout="Form" LabelAlign="Right"
                        Resizable="false" LabelWidth="115">  
                        <Items>
                            <ext:FieldContainer ID="fcNombres" runat="server" FieldLabel="Nombre(s)" MsgTarget="Under" Disabled="true" Layout="ColumnLayout">
                                <Items>
                                    <ext:TextField ID="txtNombre" runat="server" EmptyText="Primer Nombre" AllowBlank="false" DataIndex="Nombre"
                                                    MaxLength="20" MinLength="2" StyleSpec="text-transform:uppercase" ColumnWidth=".5" />
                                    <ext:TextField ID="txtNombre2" runat="server" EmptyText="Segundo Nombre" MaxLength="20" 
                                                    StyleSpec="text-transform:uppercase" Width="120" ColumnWidth=".5" />
                                </Items>
                            </ext:FieldContainer>
                            <ext:FieldContainer ID="fcApellidos" runat="server" FieldLabel="Apellido(s)" MsgTarget="Under" Disabled="true" Layout="ColumnLayout">
                                <Items>
                                    <ext:TextField ID="txtApellidoPat" EmptyText="Primer Apellido" runat="server" AllowBlank="false" DataIndex="Primer Apellido"
                                                    MaxLength="20" MinLength="2" MinLengthText="Debe escribir el apellido" StyleSpec="text-transform:uppercase" ColumnWidth=".5"/>
                                    <ext:TextField ID="txtApellidoMat" EmptyText="Segundo Apellido" runat="server" MaxLength="20" 
                                                    StyleSpec="text-transform:uppercase" ColumnWidth=".5" />
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
                            <ext:ComboBox
                                ID="cmbOcupacion" runat="server"  
                                Editable="true" TypeAhead="true" 
                                Resizable="true" Mode="Local" 
                                ForceSelection="true" TriggerAction="All" 
                                DisplayField="name" ValueField="id" FieldLabel="Ocupación"
                                StoreID="strOcupacion" Width="130" 
                                Disabled="true"/>
                            <ext:ComboBox
                                ID="cmbEdoCivil" runat="server"  
                                Editable="true" TypeAhead="true"
                                StoreID="strEdoCivil" Mode="Local" 
                                ForceSelection="true" TriggerAction="All" 
                                DisplayField="name" ValueField="id" FieldLabel="Estado Civil"  
                                Width="130" Disabled="true"/>                                
                        </Items>                         
                    </ext:Panel>
                  
                    <ext:Panel
                        ID="pnlSocio3" runat="server"
                        Border="false" Header="false"
                        ColumnWidth=".31" Layout="Form"
                        LabelAlign="Right">
                        <Items>                             
                            <ext:FieldContainer runat="server" ID="cfCP" FieldLabel="Código Postal" MsgTarget="Under" Disabled="true" Layout="HBoxLayout" >
                            <Items>
                                <ext:TextField 
                                    runat="server" 
                                    ID="txtCP" 
                                    Width="120" 
                                    StyleSpec="text-transform:uppercase; background-image:url('/Microseguro/Styles/text_in.gif');"
                                    AllowBlank="false"
                                    MaxLength="5"
                                    Margins="0 3 0 0"
                                    MinLength="5"
                                    EmptyText="#####"
                                    Regex="^[0-9]*$" 
                                    RegexText="Este campo solo acepta numeros por favor rectifica"
                                    Hidden="false" >
                                </ext:TextField>
                                <ext:Button runat="server" ID="btnBuscaCP" Icon="Magnifier" AutoPostBack="false" ToolTip="Busca el Código Postal especificado dando click aquí...">
                                    <Listeners>
                                        <Click Handler="#{cbColonia}.clearValue();#{stColonia}.load();" />
                                    </Listeners>
                                    <DirectEvents>
                                        <Click OnEvent="btnBuscaCP_DirectClick" />
                                    </DirectEvents>
                                </ext:Button>
                            </Items>
                        </ext:FieldContainer>
                       
                        <%--COMBO BOX COLONIA--%>
                        <ext:ComboBox 
                            ID="cbColonia" StoreID="stColonia"
                            runat="server" 
                            Editable="true"
                            TypeAhead="true" 
                            Mode="Local"      
                            DisplayField="name"
                            ValueField="id"
                            EmptyText="Selecciona tu Colonia..."
                            ValueNotFoundText="Cargando..." 
                            FieldLabel="Colonia"
                            Width="145"
                            Disabled="true"
                            Resizable="True"
                            StyleSpec="background-image:url('/Microseguro/Styles/text_in.gif');">      
                            <Listeners>
                                <Select Handler="#{cbMunicipio}.clearValue();#{stMunicipio}.load();" />
                            </Listeners>
                        </ext:ComboBox>

                        <%--COMBO BOX MUNICIPIO--%>
                        <ext:ComboBox 
                            ID="cbMunicipio"
                            runat="server" 
                            StoreID="stMunicipio"
                            Editable="true"
                            TypeAhead="true" 
                            Mode="Local"
                            ForceSelection="true"
                            SelectOnFocus="true"
                            TriggerAction="All"            
                            DisplayField="name"
                            ValueField="id"
                            EmptyText="Selecciona tu Municipio..."
                            ValueNotFoundText="Cargando..." 
                            FieldLabel="Municipio"
                            Width="145"
                            Disabled="true"
                            Resizable="True"
                            StyleSpec="background-image:url('/Microseguro/Styles/text_in.gif');">
                            <Listeners>
                                <Select Handler="#{cbEstado}.clearValue();#{stEstado}.load();" />
                            </Listeners>
                         </ext:ComboBox>

                        <%--COMBO BOX ESTADO--%>
                        <ext:ComboBox 
                            ID="cbEstado"
                            runat="server"
                            StoreID="stEstado"            
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
                            Disabled="true"
                            Resizable="True"
                            StyleSpec="background-image:url('/Microseguro/Styles/text_in.gif');"                            
                            Width="145">    
                            <Listeners>
                                <Select Handler="#{cbMunicipio}.clearValue();#{stMunicipio}.load();" />
                            </Listeners>
                        </ext:ComboBox>
                            <ext:TextField ID="txtCalle" runat="server" FieldLabel="Calle" AllowBlank="false" MsgTarget="Side" Width="130" Disabled="true"/>
                            <ext:FieldContainer ID="fcNumero" runat="server" FieldLabel="Número" MsgTarget="Under" Layout="ColumnLayout" Disabled="true">
                                <Items>
                                    <ext:TextField ID="txtNoExt" DataIndex="Numero" runat="server" EmptyText="Ext" AllowBlank="false" MsgTarget="Side" Width="50" Disabled="true" ColumnWidth=".5" Margins="0 5 0 0"/>
                                    <ext:TextField ID="txtNoInt" runat="server" EmptyText="Int" Disabled="true" Width="50" ColumnWidth=".5"/>
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
        Height="260">
        <Items>
            <ext:FormPanel ID="paneDocumentos"
                runat="server"
                Layout="FormLayout"
                AutoScroll = "true"
                Border = "false">
                <Items>
                    <ext:ComboBox ID="cmbPaqueteria" runat="server" FieldLabel="Paquetería" Editable="true" TypeAhead="true" 
                                    Mode="Local" ForceSelection="true" TriggerAction="All" DisplayField="name" ValueField="id" Width="200" StoreID="strPaqueteria" />    
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