<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="AnalisisEspecifico.aspx.cs"
    Inherits="SDA.App.AnalisisEspecifico" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html>
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="Form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" Theme="Gray" />
    <ext:Store ID="strCuentas" runat="server">
        <Model>
            <ext:Model ID="mdlDocPend" runat="server">
                <Fields>
                    <ext:ModelField Name="idcuenta" Mapping="IdCuenta" />
                    <ext:ModelField Name="cuenta" Mapping="Cuenta" />
                    <ext:ModelField Name="id_tipo_cta" Mapping="Id_Tipo_Cta" />
                </Fields>
            </ext:Model>
        </Model>
        <Reader>
            <ext:ArrayReader />
        </Reader>
    </ext:Store>
    <ext:Store ID="strBeneficiario" runat="server">
        <Model>
            <ext:Model ID="Model1" runat="server">
                <Fields>
                    <ext:ModelField Name="nombrebeneficiario" Mapping="NombreBeneficiario" />
                    <ext:ModelField Name="porcentaje" Mapping="Porcentaje" />
                    <ext:ModelField Name="idbeneficiario" Mapping="IdBeneficiario" />
                </Fields>
            </ext:Model>
        </Model>
        <Reader>
            <ext:ArrayReader />
        </Reader>
    </ext:Store>
    <ext:Store ID="strCausaMuerte" runat="server">
        <Proxy>
            <ext:AjaxProxy Url="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsCargaCombosBene.asmx/CargaCausante">
                <ActionMethods Read="POST" />
                <Reader>
                    <ext:XmlReader Record="Cooperativa" />
                </Reader>
            </ext:AjaxProxy>
        </Proxy>
        <Model>
            <ext:Model ID="Model2" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Type="String" Mapping="Id" />
                    <ext:ModelField Name="name" Type="String" Mapping="Causante" />
                </Fields>
            </ext:Model>
        </Model>
        <Listeners>
            <Load Handler="#{cbCausante}.setValue(#{cbCausante}.store.getAt(0).get('id'));" />
        </Listeners>
    </ext:Store>
    <ext:Store ID="strTipoFallecimiento" runat="server">
        <Proxy>
            <ext:AjaxProxy Url="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsCargaCombosBene.asmx/CargaFallecimiento">
                <ActionMethods Read="POST" />
                <Reader>
                    <ext:XmlReader Record="Cooperativa" />
                </Reader>
            </ext:AjaxProxy>
        </Proxy>
        <Model>
            <ext:Model ID="Model3" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Type="String" Mapping="Id" />
                    <ext:ModelField Name="name" Type="String" Mapping="Fallecimiento" />
                </Fields>
            </ext:Model>
        </Model>
        <Listeners>
            <Load Handler="#{cbFallecimiento}.setValue(#{cbFallecimiento}.store.getAt(0).get('id'));" />
        </Listeners>
    </ext:Store>
    <ext:Store ID="strCaptacion" runat="server">
        <Model>
            <ext:Model ID="Model4" runat="server">
                <Fields>
                    <ext:ModelField Name="cuenta" Mapping="Cuenta" />
                    <ext:ModelField Name="saldo" Mapping="Saldo" Type="String" />
                    <ext:ModelField Name="ultimomovimiento" Mapping="UltimoMovimiento" Type="Date" />
                    <ext:ModelField Name="aditamentoj" Mapping="AditamentoJ" />
                    <ext:ModelField Name="doblei" Mapping="DobleI" />
                    <ext:ModelField Name="porcentajeaditamento" Mapping="PorcentajeAditamento" />
                    <ext:ModelField Name="saldototal" Mapping="SaldoTotal" Type="String" />
                    <ext:ModelField Name="idcaptacion" Mapping="IdCaptacion" Type="String" />
                </Fields>
            </ext:Model>
        </Model>
        <Reader>
            <ext:ArrayReader />
        </Reader>
    </ext:Store>
    <ext:Store ID="strColocacion" runat="server">
        <Model>
            <ext:Model ID="Model5" runat="server">
                <Fields>
                    <ext:ModelField Name="fechaprestamo" Mapping="FechaPrestamo" Type="Date" />
                    <ext:ModelField Name="monto" Mapping="Monto" />
                    <ext:ModelField Name="tipoprestamo" Mapping="TipoPrestamo" />
                    <ext:ModelField Name="tasaint" Mapping="TasaInt" />
                    <ext:ModelField Name="plazo" Mapping="Plazo" />
                    <ext:ModelField Name="ultimomovimientocolocacion" Mapping="UltimoMovimientoColocacion"
                        Type="Date" />
                    <ext:ModelField Name="saldocolocacion" Mapping="SaldoColocacion" />
                    <ext:ModelField Name="idcolocacion" Mapping="IdColocacion" />
                    <ext:ModelField Name="saldototal" Mapping="SaldoTotal" />
                    <ext:ModelField Name="interesescubrir" Mapping="InteresesCubrir" />
                </Fields>
            </ext:Model>
        </Model>
        <Reader>
            <ext:ArrayReader />
        </Reader>
    </ext:Store>
    <ext:Store ID="strTipoPrestamo" runat="server">
        <Proxy>
            <ext:AjaxProxy Url="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsCargaCombosBene.asmx/CargaCausante">
                <ActionMethods Read="POST" />
                <Reader>
                    <ext:XmlReader Record="TipoPrestamo" />
                </Reader>
            </ext:AjaxProxy>
        </Proxy>
        <Model>
            <ext:Model ID="Model6" runat="server">
                <Fields>
                    <ext:ModelField Name="id" Type="String" Mapping="Id" />
                    <ext:ModelField Name="name" Type="String" Mapping="prestamo" />
                </Fields>
            </ext:Model>
        </Model>
        <Listeners>
            <Load Handler="#{cbTipoPrestamo}.setValue(#{cbTipoPrestamo}.store.getAt(0).get('id'));" />
        </Listeners>
    </ext:Store>
    <ext:Panel runat="server" ID="pnlAnalisis" Border="false">
        <Items>
            <ext:Panel ID="frmBeneficiario" runat="server" Title="Beneficiario" ButtonAlign="Right"
                Layout="Column" Border="true" Icon="UserAdd" AutoScroll="true" Collapsible="true"
                Height="280" BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')">
                <Items>
                    <ext:Panel ID="pnlBeneficiario" runat="server" Border="false" Hidden="false" Layout="Form"
                        AutoHeight="true" ColumnWidth=".45" Padding="20" BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')">
                        <Items>
                            <ext:FieldContainer ID="fcNombres" runat="server" FieldLabel="Nombre(s)" LabelAlign="Right"
                                MsgTarget="Under" Disabled="true" Layout="HBoxLayout">
                                <Items>
                                    <ext:TextField ID="txtNombre" EmptyText="Primer Nombre" runat="server" AllowBlank="false"
                                        StyleSpec="text-transform:uppercase" />
                                    <ext:TextField ID="txtNombre2" EmptyText="Segundo Nombre" runat="server" StyleSpec="text-transform:uppercase" />
                                </Items>
                            </ext:FieldContainer>
                            <ext:FieldContainer ID="fcApellidos" runat="server" FieldLabel="Apellido(s)" LabelAlign="Right"
                                MsgTarget="Under" Disabled="true" Layout="HBoxLayout">
                                <Items>
                                    <ext:TextField ID="txtApellidoPaterno" EmptyText="Primer Apellido" runat="server"
                                        AllowBlank="false" StyleSpec="text-transform:uppercase" />
                                    <ext:TextField ID="txtApellidoMaterno" EmptyText="Segundo Apellido" runat="server"
                                        StyleSpec="text-transform:uppercase" />
                                </Items>
                            </ext:FieldContainer>
                            <ext:NumberField ID="nmrPorcentaje" AllowDecimals="true" DecimalSeparator="." runat="server"
                                MaxValue="100" MinValue="0" AllowBlank="false" FieldLabel="Porcentaje" MsgTarget="Under"
                                Disabled="true" />
                        </Items>
                        <Buttons>
                            <ext:Button runat="server" ID="btGuardar" Text="Guardar" Icon="DiskEdit" Disabled="true">
                                <DirectEvents>
                                    <Click OnEvent="btGuardarBeneficiario_Click" />
                                </DirectEvents>
                            </ext:Button>
                            <ext:Button runat="server" ID="btnAgregarBeneficiario" Text="Agregar" Icon="Add"
                                Disabled="true">
                                <DirectEvents>
                                    <Click OnEvent="btnAgregarBeneficiarioGrid_Click" />
                                </DirectEvents>
                            </ext:Button>
                        </Buttons>
                    </ext:Panel>
                    <ext:GridPanel ID="gplBeneficiario" runat="server" StoreID="strBeneficiario" Height="250"
                        ColumnWidth=".55" AutoScroll="true" Layout="Form" Icon="UserGo" BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')"
                        Resizable="false">
                        <ColumnModel ItemID="idbeneficiario">
                            <Columns>
                                <ext:Column runat="server" DataIndex="nombrebeneficiario" Width="290" Align="Left" />
                                <ext:Column runat="server" DataIndex="porcentaje" Width="100" Align="Left" />
                                <ext:Column Hidden="true" runat="server" DataIndex="idbeneficiario" />
                                <ext:CommandColumn runat="server" DataIndex="iddocumento">
                                    <Commands>
                                        <ext:GridCommand Icon="Delete" CommandName="Eliminar" Text="Eliminar" />
                                    </Commands>
                                    <DirectEvents>
                                        <Command OnEvent="CellEliminarBeneficiario_Click" >
                                            <ExtraParams>
                                                <ext:Parameter Name="IdBeneficiario" Value="Ext.value(record.data.idbeneficiario)" Mode="Raw" />
                                            </ExtraParams>
                                        </Command>
                                    </DirectEvents>
                                </ext:CommandColumn>
                            </Columns>
                        </ColumnModel>
                        <SelectionModel>
                            <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" ItemID="idbeneficiario">
                                <DirectEvents>
                                    <Select OnEvent="CellBeneficiario_Click">
                                    </Select>
                                </DirectEvents>
                            </ext:RowSelectionModel>
                        </SelectionModel>
                        <Buttons>
                            <ext:Button runat="server" ID="btnCuentas" Text="Cuentas" Icon="Money">
                                <DirectEvents>
                                    <Click OnEvent="btnCuentas_Click" />
                                </DirectEvents>
                            </ext:Button>
                        </Buttons>
                    </ext:GridPanel>
                </Items>
            </ext:Panel>
            <ext:Panel runat="server" ID="pnlProteccionAhorros" Title="Protección a los Ahorros"
                Icon="Money" Height="300" Collapsible="true" Collapsed="true" BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')"
                Layout="Form">
                <Items>
                    <ext:Panel ID="pnlCaptacion" runat="server" Border="false" Height="80" Padding="15"
                        Header="false" Layout="Column" BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')">
                        <Items>
                            <ext:Panel ID="pnlCaptacion1" BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')"
                                Border="false" runat="server" ColumnWidth=".21" Layout="Form">
                                <Items>
                                    <ext:ComboBox ID="cbCuentas" LabelAlign="Right" runat="server" Editable="true" TypeAhead="true"
                                        StoreID="strCuentas" ForceSelection="true" Disabled="true" TriggerAction="All"
                                        ValueField="idcuenta" DisplayField="cuenta" FieldLabel="Cuenta" EmptyText="Selecciona la cuenta"
                                        Width="135" />
                                </Items>
                            </ext:Panel>
                            <ext:Panel ID="pnlCaptacion2" Border="false" runat="server" Layout="Form" BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')"
                                ColumnWidth=".15">
                                <Items>
                                    <ext:NumberField ID="nmrMonto" Disabled="true" FieldLabel="Saldo" EmptyText="$##,###.00"
                                        runat="server" AllowDecimals="true" DecimalSeparator="." AllowBlank="false" MsgTarget="Under"
                                        Width="78" />
                                </Items>
                            </ext:Panel>
                            <ext:Panel ID="pnlCaptacion3" Border="false" Layout="Form" runat="server" BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')"
                                ColumnWidth=".28">
                                <Items>
                                    <ext:DateField ID="dteFechaUltimoMovimiento" runat="server" FieldLabel="Fecha Último Movimiento"
                                        EmptyText="dd/mm/aaaa" AllowBlank="false" Disabled="true" Width="100px" MsgTarget="Under" />
                                </Items>
                            </ext:Panel>
                        </Items>
                    </ext:Panel>
                    <ext:Panel ID="pnlGCaptacion" runat="server" BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')"
                        Layout="Form">
                        <Items>
                            <ext:GridPanel runat="server" ID="gplCaptacion" Border="false" BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')"
                                Layout="Form" AutoScroll="true" Height="85" StoreID="strCaptacion">
                                <ColumnModel>
                                    <Columns>
                                        <ext:Column runat="server" DataIndex="cuenta" Width="150">
                                        </ext:Column>
                                        <ext:Column runat="server" DataIndex="saldo" Align="Right">
                                            <Renderer Format="UsMoney" />
                                        </ext:Column>
                                        <ext:DateColumn runat="server" Format="dd/MM/yyyy" DataIndex="ultimomovimiento" Width="200"
                                            Align="Right" />
                                        <ext:CheckColumn runat="server" DataIndex="aditamentoj" />
                                        <ext:Column runat="server" DataIndex="porcentajeaditamento" />
                                        <ext:CheckColumn runat="server" DataIndex="doblei" />
                                        <ext:Column runat="server" DataIndex="saldototal" Width="150" Align="Right">
                                            <Renderer Format="UsMoney" />
                                        </ext:Column>
                                        <ext:CommandColumn runat="server" DataIndex="idcaptacion">
                                            <Commands>
                                                <ext:GridCommand Icon="Delete" CommandName="Eliminar" Text="Eliminar" />
                                            </Commands>
                                            <DirectEvents>
                                                <Command OnEvent="CellEliminarCaptacion_Click" >
                                                    <ExtraParams>
                                                        <ext:Parameter Name="IdCaptacion" Value="Ext.value(record.data.idcaptacion)" Mode="Raw" >
                                                        </ext:Parameter>
                                                    </ExtraParams>
                                                </Command>
                                            </DirectEvents>
                                        </ext:CommandColumn>
                                    </Columns>
                                </ColumnModel>
                                <SelectionModel>
                                    <ext:RowSelectionModel ID="RowSelectionModel2" runat="server" ItemID="idcaptacion">
                                        <DirectEvents>
                                            <Select OnEvent="CellCuentaCaptacion_Click">
                                            </Select>
                                        </DirectEvents>
                                    </ext:RowSelectionModel>
                                </SelectionModel>
                            </ext:GridPanel>
                            <ext:DisplayField runat="server" ID="lblSaldoTotal" FieldLabel="Saldo Total" />
                        </Items>
                        <TopBar>
                            <ext:Toolbar ID="Toolbar1" runat="server">
                                <Items>
                                    <ext:ToolbarFill ID="ToolbarFill1" runat="server" />
                                    <ext:Button runat="server" ID="btnCancelarCuentaCaptacion" Icon="Cancel" Disabled="true"
                                        Text="Cancelar">
                                        <DirectEvents>
                                            <Click OnEvent="btnCancelarCuentaCaptacion_Click" />
                                        </DirectEvents>
                                    </ext:Button>
                                    <ext:Button runat="server" ID="btnModificarCaptacion" Text="Modificar" Disabled="true"
                                        Icon="DiskEdit">
                                        <DirectEvents>
                                            <Click OnEvent="btnModificarCaptacion_Click">
                                            </Click>
                                        </DirectEvents>
                                    </ext:Button>
                                    <ext:Button runat="server" ID="btnAgregarCuentaCaptacion" Icon="MoneyAdd" Text="Agregar Cuenta Ahorro"
                                        Disabled="true">
                                        <DirectEvents>
                                            <Click OnEvent="btnAgregarCuentaCaptacion_Click" />
                                        </DirectEvents>
                                    </ext:Button>
                                </Items>
                            </ext:Toolbar>
                        </TopBar>
                        <Buttons>
                            <ext:Button runat="server" ID="btnGuardarCapatacion" Text="Guardar" Icon="Disk" Disabled="true">
                                <DirectEvents>
                                    <Click OnEvent="btnGuardarCaptacion_Click">
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                        </Buttons>
                    </ext:Panel>
                </Items>
            </ext:Panel>
            <ext:Panel runat="server" ID="pnlProteccionPrestamos" Layout="Form" Title="Protección a los Préstamos"
                Icon="Money" Height="300" BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')"
                Collapsible="true" Collapsed="true">
                <Items>
                    <ext:Panel runat="server" Height="80" BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')"
                        ID="pnlColocacion" Padding="15" Layout="Column">
                        <Items>
                            <ext:Panel ID="pnlFechaOtorgado" runat="server" Border="false" Layout="Form" BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')"
                                ColumnWidth=".17">
                                <Items>
                                    <ext:DateField ID="dteFechaOtorgado" Disabled="true" FieldLabel="Fecha Otorgamiento"
                                        EmptyText="dd/mm/aaaa" Width="120" runat="server" AllowBlank="false">
                                    </ext:DateField>
                                </Items>
                            </ext:Panel>
                            <ext:Panel ID="pnlMonto" runat="server" Border="false" Layout="Form" BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')"
                                ColumnWidth=".12">
                                <Items>
                                    <ext:NumberField runat="server" Disabled="true" AllowDecimals="true" DecimalSeparator="."
                                        EmptyText="$##,###.00" FieldLabel="Monto" Width="80" ID="nmrMontoColocacion"
                                        AllowBlank="false" />
                                </Items>
                            </ext:Panel>
                            <ext:Panel ID="pnlTipoPrestamo" runat="server" Border="false" Layout="Form" BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')"
                                ColumnWidth=".16">
                                <Items>
                                    <ext:ComboBox runat="server" ID="cbTipoPrestamo" Width="120" Disabled="true" StoreID="strTipoPrestamo"
                                        FieldLabel="Tipo Préstamo" DisplayField="prestamo" ValueField="id" EmptyText="Seleccione Préstamo.."
                                        ForceSelection="true" Resizable="true" />
                                </Items>
                            </ext:Panel>
                            <ext:Panel ID="pnlTasaInteres" runat="server" Border="false" Layout="Form" BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')"
                                ColumnWidth=".11">
                                <Items>
                                    <ext:NumberField runat="server" Disabled="true" AllowDecimals="true" DecimalSeparator="."
                                        EmptyText="0.0%" ID="nmrTasaInteres" Width="50" FieldLabel="Tasa Interés" AllowBlank="false" />
                                </Items>
                            </ext:Panel>
                            <ext:Panel ID="pnlPlazo" runat="server" Layout="Form" Border="false" BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')"
                                ColumnWidth=".12">
                                <Items>
                                    <ext:SpinnerField ID="sfPlazo" runat="server" FieldLabel="Plazo" Disabled="true"
                                        EmptyText="Meses" Width="60" />
                                </Items>
                            </ext:Panel>
                            <ext:Panel ID="pnlFechaUltimoMovimiento" runat="server" Border="false" Layout="Form"
                                BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')" ColumnWidth=".2">
                                <Items>
                                    <ext:DateField runat="server" Disabled="true" ID="dteFechaUltimoMovimientoCol" Width="120"
                                        EmptyText="dd/mm/aaaa" FieldLabel="Fecha Último Movimiento" AllowBlank="false" />
                                </Items>
                            </ext:Panel>
                            <ext:Panel ID="pnlSaldoPrincipal" runat="server" Border="false" Layout="Form" BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')"
                                ColumnWidth=".12">
                                <Items>
                                    <ext:NumberField runat="server" Disabled="true" AllowDecimals="true" DecimalSeparator="."
                                        EmptyText="$##,###.00" ID="nmrSaldoPrincipal" Width="85" FieldLabel="Saldo Principal"
                                        AllowBlank="false" />
                                </Items>
                            </ext:Panel>
                        </Items>
                    </ext:Panel>
                    <ext:Panel ID="pnlGColocacion" runat="server" Layout="Form" BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')">
                        <Items>
                            <ext:GridPanel runat="server" ID="gplColocacion" BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')"
                                Layout="Fit" Height="100" AutoScroll="true" Region="Center" StoreID="strColocacion">
                                <ColumnModel>
                                    <Columns>
                                        <ext:DateColumn runat="server" DataIndex="fechaprestamo" Align="Right" Width="130"
                                            Format="dd/MM/yyyy">
                                        </ext:DateColumn>
                                        <ext:Column runat="server" DataIndex="monto" Align="Right">
                                            <Renderer Format="UsMoney" />
                                        </ext:Column>
                                        <ext:Column runat="server" DataIndex="tipoprestamo" Width="130">
                                        </ext:Column>
                                        <ext:Column runat="server" DataIndex="tasaint" Width="130">
                                        </ext:Column>
                                        <ext:Column runat="server" DataIndex="plazo" Width="130">
                                        </ext:Column>
                                        <ext:DateColumn runat="server" DataIndex="ultimomovimientocolocacion" Align="Right"
                                            Width="130" Format="dd/MM/yyyy">
                                        </ext:DateColumn>
                                        <ext:Column runat="server" DataIndex="saldocolocacion" Width="100" Align="Right">
                                            <Renderer Format="UsMoney" />
                                        </ext:Column>
                                        <ext:Column runat="server" DataIndex="interesescubrir" Width="100" Align="Right">
                                            <Renderer Format="UsMoney" />
                                        </ext:Column>
                                        <ext:Column runat="server" DataIndex="saldototal" Width="100" Align="Right">
                                            <Renderer Format="UsMoney" />
                                        </ext:Column>
                                        <ext:CommandColumn runat="server" DataIndex="idcolocacion">
                                            <Commands>
                                                <ext:GridCommand Icon="Delete" CommandName="Eliminar" Text="Eliminar" />
                                            </Commands>
                                            <DirectEvents>
                                                <Command OnEvent="CellEliminarColocacion_Click" >
                                                    <ExtraParams>
                                                        <ext:Parameter Name="IdColocacion" Value="Ext.value(record.data.idcolocacion)" Mode="Raw" >
                                                        </ext:Parameter>
                                                    </ExtraParams>
                                                </Command>
                                            </DirectEvents>
                                        </ext:CommandColumn>
                                    </Columns>
                                </ColumnModel>
                                <TopBar>
                                    <ext:Toolbar ID="Toolbar2" runat="server">
                                        <Items>
                                            <ext:ToolbarFill ID="ToolbarFill2" runat="server" />
                                            <ext:Button runat="server" ID="btnCancelarCuentaColocacion" Text="Cancelar" Disabled="true"
                                                Icon="Cancel">
                                                <DirectEvents>
                                                    <Click OnEvent="btnCancelarCuentaColocacion_Click" />
                                                </DirectEvents>
                                            </ext:Button>
                                            <ext:Button runat="server" ID="btnModificarColocacion" Text="Modificar" Disabled="true"
                                                Icon="DiskEdit">
                                                <DirectEvents>
                                                    <Click OnEvent="btnModificarColocacion_Click">
                                                    </Click>
                                                </DirectEvents>
                                            </ext:Button>
                                            <ext:Button runat="server" ID="btnAgregarCuentaColocacion" Text="Agregar Préstamo"
                                                Icon="MoneyAdd">
                                                <DirectEvents>
                                                    <Click OnEvent="btnAgregarCuentaColocacion_Click">
                                                    </Click>
                                                </DirectEvents>
                                            </ext:Button>
                                        </Items>
                                    </ext:Toolbar>
                                </TopBar>
                                <SelectionModel>
                                    <ext:RowSelectionModel ID="RowSelectionModel3" runat="server" ItemID="idcaptacion">
                                        <DirectEvents>
                                            <Select OnEvent="CellCuentaColocacion_Click">
                                            </Select>
                                        </DirectEvents>
                                    </ext:RowSelectionModel>
                                </SelectionModel>
                            </ext:GridPanel>
                            <ext:DisplayField runat="server" ID="lblSaldoTotalColocacion" FieldLabel="Saldo Total" />
                        </Items>
                    </ext:Panel>
                </Items>
            </ext:Panel>
        </Items>
        <Buttons>
            <ext:Button ID="btnCerrarCuentas" runat="server" Text="Aceptar">
                <DirectEvents>
                    <Click OnEvent="btnCerrarCuentas_Click">
                    </Click>
                </DirectEvents>
            </ext:Button>
            <ext:Button ID="btnAnalisisAprobado" Hidden="true" runat="server" Icon="Accept" Text="Aprobado">
                <DirectEvents>
                    <Click OnEvent="btnAnalisisAprobado_Click">
                    </Click>
                </DirectEvents>
            </ext:Button>
        </Buttons>
    </ext:Panel>
    </form>
</body>
</html>
