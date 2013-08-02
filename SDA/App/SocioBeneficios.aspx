<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="SocioBeneficios.aspx.cs" Inherits="SDA.App.SocioBeneficios" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register TagPrefix="SDA" TagName="FileUploadBit" Src="/App/FileUploadBit.ascx" %>

<!DOCTYPE html>
<html>
<head>
    <title>Registro de Siniestro</title>
    <style type="text/css">
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
    <script type="text/javascript">
        var agregarBeneficiario = function (store) {
            var nombre = Ext.getCmp('txtNombreBeneficiario').getValue();
            var nombre2 = Ext.getCmp('txtNombre2Beneficiario').getValue();
            var apellidop = Ext.getCmp('txtApellidoPBeneficiario').getValue();
            var apellidom = Ext.getCmp('txtApellidoMBeneficiario').getValue();
            var porcentaje = Ext.getCmp('nmrPorcentaje').getValue();
            var parentesco = Ext.getCmp('cmbParentesco').getRawValue();

            store.add({
                id: 2,
                nombre: nombre,
                nombre2: nombre2,
                apellidop: apellidop,
                apellidom: apellidom,
                porcentaje: porcentaje,
                parentesco: parentesco
            });
        };

        var guardarBeneficiarios = function (store) {
            var totalPercent = 0;
            var items = new Array();

            store.each(function (record) {
                totalPercent += record.data.porcentaje;
                items.push(record.data);
            });

            if (totalPercent > 100)
                Ext.MessageBox.alert('Verifique su informacion', 'El total de porcentaje excede el 100% (' + totalPercent + '%)');

            else if (totalPercent < 100)
                Ext.MessageBox.alert('Verifique su informacion', 'El total de porcentaje no alcanza el 100% (' + totalPercent + '%)');

            else
                bitchYouMadeItToOneHundredPercent(items);
        };

        var bitchYouMadeItToOneHundredPercent = function (items) {
            App.Edit(items);
        };
    </script>
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
  
    <ext:Store ID="strTipoPrestamo" runat="server" AutoLoad="false">
        <Proxy>
            <ext:AjaxProxy runat="server" Url="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx/CargaPrestamo">
                <ActionMethods Read="POST" />
                    <Reader>
                    <ext:XmlReader Record="TipoPrestamo" />
                </Reader>
            </ext:AjaxProxy>
        </Proxy>
        <Model>
            <ext:Model ID="Model11" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Mapping="IdTipoPrestamo" />
                    <ext:ModelField Name="name" Type="String" Mapping="Prestamo" />                      
                </Fields>
            </ext:Model>
        </Model>
        <Listeners>
            <Load Handler="#{cmbTipoPrestamo}.setValue(#{cmbTipoPrestamo}.store.getAt(0).get('id'));" />
        </Listeners> 
    </ext:Store>
    <ext:Store ID="strCuentas" runat="server" AutoLoad="false">
        <Proxy>
            <ext:AjaxProxy runat="server" Url="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsConsultaReportesDA.asmx/ConsultaCuentasDA">
                <ActionMethods Read="POST" />
                    <Reader>
                    <ext:XmlReader Record="CuentasDA" />
                </Reader>
            </ext:AjaxProxy>
        </Proxy>
        <Model>
            <ext:Model ID="Model10" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Mapping="IdCuenta" />
                    <ext:ModelField Name="name" Type="String" Mapping="Cuenta" />
                    <ext:ModelField Name="coop" Type="String" Mapping="IdCoop" />  
                    <ext:ModelField Name="idtipocta" Mapping="IdTipoCta" />                          
                </Fields>
            </ext:Model>
        </Model>
        <Parameters>
            <ext:StoreParameter Name="IdCoop" Value="1" Mode="Value" />              
        </Parameters>
        <Listeners>
            <Load Handler="#{cmbCuentas}.setValue(#{cmbCuentas}.store.getAt(0).get('id'));" />
        </Listeners> 
    </ext:Store>
    <ext:Store ID="strBeneficiarios" runat="server">
        <Model>
            <ext:Model ID="Model8" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Type="Int" />
                    <ext:ModelField Name="nombre" />
                    <ext:ModelField Name="nombre2" />
                    <ext:ModelField Name="apellidop" />
                    <ext:ModelField Name="apellidom" />
                    <ext:ModelField Name="parentesco" />
                    <ext:ModelField Name="porcentaje" Type="Float" />
                </Fields>
            </ext:Model>
        </Model>
        <Reader>
            <ext:ArrayReader />
        </Reader>
    </ext:Store>
    <ext:Store ID="strCaptacion" runat="server">
        <Model>
            <ext:Model ID="Model6" runat="server">
                <Fields>
                    <ext:ModelField Name="cuenta" Mapping="Cuenta" Type="String" />
                    <ext:ModelField Name="saldo" Mapping="Saldo" />
                    <ext:ModelField Name="idsaldo" Mapping="IdSaldo"/>
                    <ext:ModelField Name="tipoprestamo" Mapping="TipoPrestamo" />

                </Fields>
            </ext:Model>
        </Model>
        <Reader>
            <ext:ArrayReader />
        </Reader>
    </ext:Store>
    <ext:Store ID="strColocacion" runat="server">
        <Model>
            <ext:Model ID="Model7" runat="server">
                <Fields>
                    <ext:ModelField Name="cuenta" Mapping="Cuenta" Type="String" />
                    <ext:ModelField Name="saldo" Mapping="Saldo" />
                    <ext:ModelField Name="idsaldo" Mapping="IdSaldo"/>
                    <ext:ModelField Name="tipoprestamo" Mapping="TipoPrestamo" />
                </Fields>
            </ext:Model>
        </Model>
        <Reader>
            <ext:ArrayReader />
        </Reader>
    </ext:Store>
    <ext:Store runat="server" ID="strParentescos">
        <Proxy>
            <ext:AjaxProxy runat="server" Url="http://qa.prybe.coop/WSPrybeMS/wsmsp/wsConsultas.asmx/ConsultaParentesco">
                <ActionMethods Read="POST" />
                    <Reader>
                    <ext:XmlReader Record="Parentesco" />
                </Reader>
            </ext:AjaxProxy>
        </Proxy>
        <Model>
            <ext:Model ID="Model9" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Type="String" Mapping="Id" />
                    <ext:ModelField Name="name" Type="String" Mapping="Descripcion" />                        
                </Fields>
            </ext:Model>
        </Model>
        <Listeners>
            <Load Handler="#{cmbParentesco}.setValue(#{cmbParentesco}.getStore().getAt(0).get('id'));" />
        </Listeners>          
    </ext:Store> 
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
    <ext:Panel runat="server" ID="pnlProteccionAhorros" Title="Protección a los Ahorros"
        Icon="Money" Height="300" Collapsible="true" Collapsed="true" Layout="Form">
        <Items>
            <ext:FormPanel ID="pnlCaptacion" runat="server" Border="false" Height="80" Padding="10"
                Header="false" Layout="Column" >
                <Items>
                    <ext:ComboBox ID="cmbCuentas" LabelAlign="Right" runat="server" Editable="true" TypeAhead="true"
                        StoreID="strCuentas" ForceSelection="true"  TriggerAction="All" AllowBlank="false"
                        ValueField="id" DisplayField="name" FieldLabel="Cuenta" EmptyText="Selecciona la cuenta"
                        ColumnWidth=".21" />
                    <ext:NumberField ID="nmrMonto"  FieldLabel="Saldo" EmptyText="$##,###.00"
                        runat="server" AllowDecimals="true" DecimalSeparator="." AllowBlank="false"
                        ColumnWidth=".15" LabelAlign="Right" />
                    <ext:DateField ID="dteFechaUltimoMovimiento" runat="server" FieldLabel="Fecha Último Movimiento"
                        EmptyText="dd/mm/aaaa" AllowBlank="false" LabelAlign="Right" ColumnWidth=".28" />
                </Items>
                <Buttons>
                    <ext:Button runat="server" ID="btnAgregarCuentaCaptacion" Icon="MoneyAdd" Text="Agregar Cuenta Ahorro" FormBind="true" OnDirectClick="AgregarCuentaCaptacion" />
                </Buttons>
            </ext:FormPanel>
            <ext:GridPanel runat="server" ID="gplCaptacion" AutoHeight="true"
                Layout="Form" AutoScroll="true" StoreID="strCaptacion">
                <ColumnModel>
                    <Columns>
                        <ext:Column ID="Column4" runat="server" Text="Cuenta" DataIndex="cuenta" Width="150" />
                        <ext:Column ID="Column5" runat="server" Text="Saldo" DataIndex="saldo" Align="Right">
                            <Renderer Format="UsMoney" />
                        </ext:Column>
                        <ext:Column ID="Column6" Text="Tipo Prestamo" runat="server" DataIndex="tipoprestamo" Width="200" Align="Right" />
                    </Columns>
                </ColumnModel>
                <SelectionModel>
                    <ext:RowSelectionModel ID="RowSelectionModel2" runat="server" ItemID="idcaptacion">
                        <DirectEvents>
                            <Select OnEvent="CellCuentaCaptacion">
                            </Select>
                        </DirectEvents>
                    </ext:RowSelectionModel>
                </SelectionModel>
            </ext:GridPanel>
        </Items>
    </ext:Panel>
    <ext:Panel runat="server" ID="pnlProteccionPrestamos" Layout="Form" Title="Protección a los Préstamos"
        Icon="Money" Height="300" Collapsible="true" Collapsed="true">
        <Items>
            <ext:FormPanel runat="server" Height="80" Border="false"
                ID="pnlColocacion" Padding="10" Layout="Column">
                <Items>
                    <ext:ComboBox runat="server" ID="cmbTipoPrestamo" StoreID="strTipoPrestamo" AllowBlank="false"
                        FieldLabel="Tipo Préstamo" LabelAlign="Right" DisplayField="name" ValueField="id" EmptyText="Seleccione Préstamo.."
                        ForceSelection="true" ColumnWidth=".2" />
                    <ext:NumberField runat="server" AllowDecimals="true" LabelAlign="Right" DecimalSeparator="."
                        EmptyText="0.0%" ID="nmrTasaInteres" FieldLabel="Tasa Interés" AllowBlank="false" ColumnWidth=".2" />
                    <ext:DateField runat="server" ID="dteFechaUltimoMovimientoCol" LabelAlign="Right"
                        EmptyText="dd/mm/aaaa" FieldLabel="Fecha Último Movimiento" AllowBlank="false" ColumnWidth=".2" />
                    <ext:NumberField runat="server" AllowDecimals="true" DecimalSeparator="." LabelAlign="Right"
                        EmptyText="$##,###.00" ID="nmrSaldoPrincipal" FieldLabel="Saldo Principal"
                        AllowBlank="false" ColumnWidth=".2" />
                    <ext:DateField ID="datePrestamo" runat="server" AllowBlank="false" FieldLabel="Fecha de Prestamo" ColumnWidth=".2" LabelAlign="Right" />
                </Items>
                <Buttons>
                    <ext:Button runat="server" ID="btnAgregarCuentaColocacion" Text="Agregar Préstamo" Icon="MoneyAdd" OnDirectClick="AgregarCuentaColocacion" FormBind="true" />
                </Buttons>
            </ext:FormPanel>
            <ext:GridPanel runat="server" ID="gplColocacion" AutoHeight="true"
                Layout="Fit" AutoScroll="true" Region="Center" StoreID="strColocacion">
                <ColumnModel>
                    <Columns>
                        <ext:Column ID="Column7" runat="server" Text="Cuenta" DataIndex="cuenta" Width="150" />
                        <ext:Column ID="Column8" runat="server" Text="Saldo" DataIndex="saldo" Align="Right">
                            <Renderer Format="UsMoney" />
                        </ext:Column>
                        <ext:Column ID="Column9" Text="Tipo Prestamo" runat="server" DataIndex="tipoprestamo" Width="200" Align="Right" />
                    </Columns>
                </ColumnModel>
                <SelectionModel>
                    <ext:RowSelectionModel ID="RowSelectionModel3" runat="server" ItemID="idcaptacion">
                        <DirectEvents>
                            <Select OnEvent="CellCuentaColocacion" />
                        </DirectEvents>
                    </ext:RowSelectionModel>
                </SelectionModel>
            </ext:GridPanel>
        </Items>
    </ext:Panel>
    <ext:Panel ID="paneLol" Title="Archivos" runat="server" Disabled="true" Height="600" AnchorHorizontal="100%" Border="false">
        <Content>
            <SDA:FileUploadBit ID="FileUploadBit1" runat="server" CanEdit="false" />
        </Content>
    </ext:Panel>
    <ext:Window 
        ID="wndSiniestroAsignado" 
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
    <ext:Window ID="wndBeneficiario" runat="server" Title="Beneficiario" Modal="true" Hidden="true"
        Layout="ColumnLayout" Icon="GroupAdd" Resizable="false" Height="300" Width="1100" >
        <Items>
            <ext:FormPanel ID="pnlBeneficiario" Title="Beneficiario" Border="true" runat="server" Hidden="false" Layout="Form"
                Height="250" ColumnWidth=".4" Icon="UserAdd" >
                <Items>
                    <ext:FieldContainer ID="FieldContainer1" runat="server" FieldLabel="Nombre(s)" LabelAlign="Right" Layout="HBoxLayout">
                        <Items>
                            <ext:TextField ID="txtNombreBeneficiario" EmptyText="Primer Nombre" runat="server" AllowBlank="false"
                                StyleSpec="text-transform:uppercase" />
                            <ext:TextField ID="txtNombre2Beneficiario" EmptyText="Segundo Nombre" runat="server" StyleSpec="text-transform:uppercase" />
                        </Items>
                    </ext:FieldContainer>
                    <ext:FieldContainer ID="FieldContainer2" runat="server" FieldLabel="Apellido(s)" LabelAlign="Right" Layout="HBoxLayout">
                        <Items>
                            <ext:TextField ID="txtApellidoPBeneficiario" EmptyText="Primer Apellido" runat="server"
                                AllowBlank="false" StyleSpec="text-transform:uppercase" />
                            <ext:TextField ID="txtApellidoMBeneficiario" EmptyText="Segundo Apellido" runat="server"
                                StyleSpec="text-transform:uppercase" />
                        </Items>
                    </ext:FieldContainer>
                    <ext:ComboBox 
                        ID="cmbParentesco" runat="server" LabelAlign="Right"
                        StoreID="strParentescos" Editable="false"
                        TypeAhead="true" QueryMode="Local" FieldLabel="Parentesco"
                        ForceSelection="true" TriggerAction="All"            
                        DisplayField="name" ValueField="id"
                        EmptyText="Loading..." ValueNotFoundText="Loading..." />
                    <ext:NumberField ID="nmrPorcentaje" LabelAlign="Right" AllowDecimals="true" DecimalSeparator="." runat="server"
                        MaxValue="100" MinValue="1" AllowBlank="false" FieldLabel="Porcentaje" />
                </Items>
                <Buttons>
                    <ext:Button runat="server" ID="btnAgregarBeneficiario" Text="Agregar" Icon="Add" FormBind="true">
                        <Listeners>
                            <Click Handler="agregarBeneficiario(#{strBeneficiarios});" />
                        </Listeners>
                    </ext:Button>
                </Buttons>
            </ext:FormPanel>
            <ext:GridPanel ID="gplBeneficiario" runat="server" StoreID="strBeneficiarios" Height="250"
                ColumnWidth=".6" AutoScroll="true" Layout="Form" Icon="Group" Title="Beneficiarios Añadidos"
                Resizable="false">
                <ColumnModel>
                    <Columns>
                        <ext:Column ID="Column1" runat="server" Text="Nombre" DataIndex="nombre" Align="Left" />
                        <ext:Column ID="Column10" runat="server" Text="Segundo Nombre" DataIndex="nombre2" Align="Left" />
                        <ext:Column ID="Column11" runat="server" Text="Apellido Materno" DataIndex="apellidop" Align="Left" />
                        <ext:Column ID="Column12" runat="server" Text="Apellido Paterno" DataIndex="apellidom" Align="Left" />
                        <ext:Column ID="Column13" runat="server" Text="Paretensco" DataIndex="parentesco" Align="Left" />
                        <ext:Column ID="Column2" runat="server" Text="Porcentaje" DataIndex="porcentaje" Align="Left" />
                        <ext:CommandColumn runat="server">
                            <Commands>
                                <ext:GridCommand Icon="Delete" />
                            </Commands>
                        </ext:CommandColumn>
                        <ext:Column ID="Column3" Hidden="true" runat="server" DataIndex="idbeneficiario" />
                        <ext:Column ID="Column14" Hidden="true" runat="server" DataIndex="idparentesco" />
                    </Columns>
                </ColumnModel>
                <SelectionModel>
                    <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" ItemID="idbeneficiario">
                        <DirectEvents>
                            <Select OnEvent="SelectBeneficiario" />
                        </DirectEvents>
                    </ext:RowSelectionModel>
                </SelectionModel>
                <Buttons>
                    <ext:Button runat="server" ID="btnGuardarBeneficiarios" Text="Guardar Beneficiarios" Icon="Disk">
                        <Listeners>
                            <Click Handler="guardarBeneficiarios(#{strBeneficiarios});" />
                        </Listeners>
                    </ext:Button>
                </Buttons>
            </ext:GridPanel>
        </Items>
    </ext:Window>
    </form>
</body>
</html>