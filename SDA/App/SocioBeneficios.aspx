<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="SocioBeneficios.aspx.cs" Inherits="SDA.App.SocioBeneficios" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register TagPrefix="SDA" TagName="FileUploadBit" Src="~/App/FileUploadBit.ascx" %>

<!DOCTYPE html>
<html>
<head>
    <style>
        #dfNumeroSiniestro-inputEl
        {
            width: 100%;
            font-size: 14px;
            text-align: center;
        }
        #pnlSocio1
        {
            width: 397px;
            height: 115px;
            padding-right: 95px;
        }
        #pnlSocio2
        {
            width: 548px;
            height: 207px;
            padding-right: 185px;
        }
        #pnlSocio3
        {
            width: 425px;
            height: 179px;
            padding-right: 145px;
        }
        #Toolbar1-innerCt
        {
            width: 1385px;
            height: 22px;
            padding-right: 140px;
        }
    </style>
    <style>      
          div.botright {
            display:block;      
            position:absolute;
            top:0px;
            left:0px;
            width:100%;  
            background-image: url("/Styles/BTrans_grayS.png");      
            height:100%;
            padding:18% 30% 20% 30%;  
            border:1px solid #ddd;
            z-index:10000;
            text-align:center;
            font-size: 20px;
            font-weight: 900;
            color: #626262;
          }
    </style> 
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" Theme="Gray"/>
    
    <div id="maskDiv" class="botright x-hide-display">    
        <%--GIF ANIMADO--%> 
        <img src="Styles/msj.gif" alt="Cargando..." /> 
        
        <%--MENSAJE INFORMATIVO--%> 
        <br />Espere un momento, por favor...
    </div>
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

    <ext:Panel ID="pnlSocio" runat="server"
        ButtonAlign="Right" Title="Datos Del Socio"
        Border="true" Layout="FormLayout" 
        Icon="UserMagnify" Height="290">
        <Items>
            <ext:Panel ID="Panel1" runat="server"
                Border="false" Layout="ColumnLayout" BodyPadding="10" 
                Height="250">
                <Items>                    
                    <ext:Panel ID="pnlSocio1" runat="server" 
                        Border="false" Header="false" 
                        ColumnWidth=".29" Layout="Form"
                        Resizable="false">
                        <Items>
                            <ext:FieldContainer ID="fcNumSocio" runat="server" FieldBodyCls="Numero de Socio" MsgTarget="Under" Layout="HBoxLayout">
                                <Items>
                                    <ext:TextField ID="txtNumSocio" runat="server" LabelAlign="Right" FieldLabel="Número de Socio" AllowBlank="false" Margins="0 3 0 0"
                                        MaxLength="10" Width="220"/>
                                    <ext:Button ID="btnBuscarSocio" runat="server" Icon="Magnifier" ToolTip="Da click en este botón para realizar...<br>busqueda de datos generales del Socio.">
                                        <Listeners>
                                            <Click Handler="#{maskDiv}.removeCls('x-hide-display');"></Click>
                                        </Listeners>
                                        <DirectEvents>
                                            <Click OnEvent="btnBuscaSocio_Click"></Click>
                                        </DirectEvents>
                                    </ext:Button>
                                </Items>
                            </ext:FieldContainer>
                            <ext:ComboBox 
                                ID="cmbCoop" runat="server"
                                StoreID="strCoop" Editable="false"
                                TypeAhead="true" QueryMode="Local" LabelWidth="50"
                                ForceSelection="true" TriggerAction="All"            
                                DisplayField="name" ValueField="id" Width="250"
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
                        Layout="Form">  
                        <Items>
                            <ext:FieldContainer ID="fcNombres" runat="server" LabelAlign="Right" FieldLabel="Nombre(s)" MsgTarget="Under" Disabled="true" Layout="HBoxLayout">
                                <Items>
                                    <ext:TextField ID="txtNombre" runat="server" EmptyText="Primer Nombre" AllowBlank="false" DataIndex="Nombre"
                                                    MaxLength="20" MinLength="2" StyleSpec="text-transform:uppercase" Width="120" Margins="0 3 0 0" />
                                    <ext:TextField ID="txtNombre2" runat="server" EmptyText="Segundo Nombre" MaxLength="20" 
                                                    StyleSpec="text-transform:uppercase" Width="120" />
                                </Items>
                            </ext:FieldContainer>
                            <ext:FieldContainer ID="fcApellidos" runat="server" LabelAlign="Right" FieldLabel="Apellido(s)" MsgTarget="Under" Disabled="true" Layout="HBoxLayout">
                                <Items>
                                    <ext:TextField ID="txtApellidoPat" EmptyText="Primer Apellido" runat="server" AllowBlank="false" DataIndex="Primer Apellido" Margins="0 3 0 0"
                                                    MaxLength="20" MinLength="2" MinLengthText="Debe escribir el apellido" StyleSpec="text-transform:uppercase" Width="120"/>
                                    <ext:TextField ID="txtApellidoMat" EmptyText="Segundo Apellido" runat="server" MaxLength="20" 
                                                    StyleSpec="text-transform:uppercase" Width="120" />
                                </Items>
                            </ext:FieldContainer>
                            <ext:DateField ID="dteFechaN" runat="server" FieldLabel="Fecha Nacimiento" LabelAlign="Right" LabelWidth="100"
                                        EmptyText="dd/mm/aaaa" AllowBlank="false" Width="130"  MsgTarget="Side" Disabled="true" DataIndex="Fecha Nacimiento" />
                            <ext:DateField ID="dteFechaI" runat="server" FieldLabel="Fecha Ingreso" DataIndex="Fecha Ingreso" LabelAlign="Right"
                                        EmptyText="dd/mm/aaaa" AllowBlank="false"  Width="130"  MsgTarget="Side" Disabled="true"/> 
                            <ext:RadioGroup ID="rdoSexo" runat="server" FieldLabel="Sexo" ColumnsNumber="2" Width="120" Disabled="true" LabelAlign="Right" >
                            <Items>
                                <ext:Radio ID="rdoFemenino" runat="server" BoxLabel="Femenino" />
                                <ext:Radio ID="rdoMasculino" runat="server" BoxLabel="Masculino" Checked="true"/>
                            </Items>
                            </ext:RadioGroup>
                            <ext:ComboBox
                                ID="cmbOcupacion" runat="server"  
                                Editable="true" TypeAhead="true" 
                                Resizable="true" Mode="Local" LabelAlign="Right"
                                ForceSelection="true" TriggerAction="All" 
                                DisplayField="name" ValueField="id" FieldLabel="Ocupación"
                                StoreID="strOcupacion" Width="130" 
                                Disabled="true"/>
                            <ext:ComboBox
                                ID="cmbEdoCivil" runat="server"  
                                Editable="true" TypeAhead="true"
                                StoreID="strEdoCivil" Mode="Local" LabelAlign="Right"
                                ForceSelection="true" TriggerAction="All" 
                                DisplayField="name" ValueField="id" FieldLabel="Estado Civil"  
                                Width="130" Disabled="true"/>                                
                        </Items>                         
                    </ext:Panel>
                  
                    <ext:Panel
                        ID="pnlSocio3" runat="server"
                        Border="false" Header="false" 
                        ColumnWidth=".31" Layout="Form">
                        <Items>                             
                            <ext:FieldContainer runat="server" ID="cfCP" FieldLabel="Código Postal" LabelAlign="Right" MsgTarget="Under" Disabled="true" Layout="HBoxLayout" >
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
                            LabelAlign="Right"
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
                            LabelAlign="Right"
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
                            LabelAlign="Right"
                            Disabled="true"
                            Resizable="True"
                            StyleSpec="background-image:url('/Microseguro/Styles/text_in.gif');"                            
                            Width="145">    
                            <Listeners>
                                <Select Handler="#{cbMunicipio}.clearValue();#{stMunicipio}.load();" />
                            </Listeners>
                        </ext:ComboBox>
                            <ext:TextField ID="txtCalle" runat="server" FieldLabel="Calle" LabelAlign="Right" AllowBlank="false" MsgTarget="Side" Width="130" Disabled="true"/>
                            <ext:FieldContainer ID="fcNumero" runat="server" FieldLabel="Número" LabelAlign="Right" MsgTarget="Under" Layout="HBoxLayout" Disabled="true">
                                <Items>
                                    <ext:TextField ID="txtNoExt" DataIndex="Numero" runat="server" EmptyText="Ext" AllowBlank="false" MsgTarget="Side" Width="50" Disabled="true" Margins="0 3 0 0"/>
                                    <ext:TextField ID="txtNoInt" runat="server" EmptyText="Int" Disabled="true" Width="50"/>
                                </Items>
                            </ext:FieldContainer>           
                        </Items>
                    </ext:Panel>
                </Items>
                <FooterBar>
                    <ext:Toolbar ID="Toolbar1" runat="server" AutoHeight="true">
                        <Items>
                            <ext:Button ID="btnCancelarRegistroSocio" runat="server" Text="Cancelar" Icon="Cancel" Disabled="true" ToolTip="Cancela la operación de registro de siniestro...<br>y realiza una nueva busqueda de Socio">
                                <DirectEvents>
                                    <Click OnEvent="btnCancelarRegistroSocio_DirectClick"></Click>
                                </DirectEvents>
                            </ext:Button>
                            <ext:Button ID="btnModificarSocio" runat="server" Text="Guardar" Icon="DiskEdit" Disabled="true" ToolTip="Guarda los datos generales del Socio">
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
    <ext:Panel ID="paneLol" Title="Archivos" runat="server" Disabled="true" Height="600" AnchorHorizontal="100%" Border="false">
        <Content>
            <SDA:FileUploadBit ID="FileUploadBit1" runat="server" />
        </Content>
    </ext:Panel>
    </form>
      <ext:Window 
        ID="wd_SiniestroAsignado" 
        runat="server" 
        Icon="TagPurple" 
        Title="Numero de siniestro asignado" 
        ButtonAlign="Center"
        Width="250"
        Height="150"
        Hidden="true">
        <Items>
            <ext:Panel ID="Panel2" runat="server" Height ="150">
                <Items>
                    <ext:DisplayField ID="dfNumeroSiniestro" LabelAlign="Top" runat="server" Text="El numero de siniestro asignado es:"></ext:DisplayField>
                    <ext:DisplayField ID="dfNumeroSiniestro2" LabelAlign="Top" runat="server" Text="12"></ext:DisplayField>
                </Items>
            </ext:Panel>
        </Items>
        <Buttons>
            <ext:Button ID="btnAceptarNumSin" runat="server" Icon="Accept" Text="Aceptar">
                <DirectEvents>
                    <Click OnEvent="btnAceptarNumSin_Click" />
                </DirectEvents>
            </ext:Button>
        </Buttons>
    </ext:Window>
</body>
</html>