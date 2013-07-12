<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="AnalisisReclamo.aspx.cs" Inherits="SDA.App.AnalisisReclamo" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<html>
<head>
<script type="text/javascript">
    var template = '<span style="color:{0};font-weight:800;">{1}</span>';
    var Estado = function (value) {
        return String.format(template, (value == 'PRE Analisis') ? "#985C4C" : (value == 'Enviado') ? "#7DB1D5" : (value == 'Valoracion') ? "#297ACC" : (value == 'Aprobado') ? "#3EB13E" : (value == 'Cotizacion rechazada') ? "#FF4D4D" : "#5E6E82", value);
    }
    </script>
</head>
<body>
<ext:ResourceManager ID="ResourceManager1" runat="server" Theme="Gray">
            <Listeners>
                <DocumentReady Handler="#{strCoop}.load();#{cbCooperativa}.setValue(1);#{strPlaza}.load();#{cbPlaza}.setValue(1);#{strSucursal}.load();#{cbSucursal}.setValue(1);" />
            </Listeners>
        </ext:ResourceManager>
                

        <ext:Store runat="server" ID="strCoop" >           
            <Proxy>
                <ext:HttpProxy Method="POST" Url="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsCargaCombosBene.asmx/CargaCoop" Timeout="800000" />
            </Proxy>
            <Reader>
                <ext:XmlReader Record="Coop">
                    <Fields>
                        <ext:RecordField Name="id" Type="String" Mapping="Id" />
                        <ext:RecordField Name="name" Type="String" Mapping="Name" />
                    </Fields>
                </ext:XmlReader> 
            </Reader>            
            <Listeners>
                <Load Handler="#{cbCooperativa}.setValue(#{cbCooperativa}.store.getAt(0).get('id'));" />
            </Listeners>
        </ext:Store>


        <ext:Store runat="server" ID="strPlaza" >           
            <Proxy>
                <ext:HttpProxy Method="POST" Url="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsCargaCombosBene.asmx/CargaPlaza" Timeout="800000" />
            </Proxy>
            <Reader>
                <ext:XmlReader Record="Plazas">
                    <Fields>
                        <ext:RecordField Name="id" Type="String" Mapping="Id" />
                        <ext:RecordField Name="name" Type="String" Mapping="Name" />
                    </Fields>
                </ext:XmlReader> 
            </Reader>
            <BaseParams>
                <ext:Parameter Name="Coops" Value="#{cbCooperativa}.getValue()" Mode="Raw"/> 
            </BaseParams>
            <Listeners>
                <Load Handler="#{cbPlaza}.setValue(#{cbPlaza}.store.getAt(0).get('id'));#{cbSucursal}.clearValue();#{strSucursal}.load();" />
            </Listeners>
        </ext:Store>


        <ext:Store runat="server" ID="strSucursal" >           
            <Proxy>
                <ext:HttpProxy Method="POST" Url="http://qa.prybe.coop/WSPrybeBeneficios/wspbene/wsCargaCombosBene.asmx/CargaSucursal" Timeout="800000" />
            </Proxy>
            <Reader>
                <ext:XmlReader Record="Sucursales">
                    <Fields>
                        <ext:RecordField Name="id" Type="String" Mapping="Id" />
                        <ext:RecordField Name="name" Type="String" Mapping="Name" />
                    </Fields>
                </ext:XmlReader> 
            </Reader>
            <BaseParams>
                <ext:Parameter Name="Plaza" Value="#{cbPlaza}.getValue()" Mode="Raw"/>
            </BaseParams>
            <Listeners>
                <Load Handler="#{cbSucursal}.setValue(#{cbSucursal}.store.getAt(0).get('id'));" />
            </Listeners>
        </ext:Store>
        
                
        <ext:Store runat="server" ID="strReclamo">           
            <Reader>
                <ext:JsonReader IDProperty="IdReclamo">
                    <Fields>
                        <ext:RecordField Name="numreclamo" Mapping="NumReclamo" />
                        <ext:RecordField Name="numsocio" Mapping="NumSocio" />
                        <ext:RecordField Name="nombre" Mapping="Nombre" />
                        <ext:RecordField Name="ocupacion" Mapping="Ocupacion" />
                        <ext:RecordField Name="sucursal" Mapping="Sucursal" />
                        <ext:RecordField Name="fecharec" Mapping="FechaRec" Type="Date" />
                        <ext:RecordField Name="anoreclamo" Mapping="AnoReclamo" />
                    </Fields>
                </ext:JsonReader>
            </Reader>
        </ext:Store>

        <ext:Store runat="server" ID="strReclamosGral">
            <Reader>
                <ext:JsonReader IDProperty="IdReclamo">
                    <Fields>
                        <ext:RecordField Name="numreclamo" Mapping="NumReclamo" />
                        <ext:RecordField Name="numsocio" Mapping="NumSocio" />
                        <ext:RecordField Name="nombre" Mapping="Nombre" />
                        <ext:RecordField Name="ocupacion" Mapping="Ocupacion" />
                        <ext:RecordField Name="sucursal" Mapping="Sucursal" />
                        <ext:RecordField Name="fecharec" Mapping="FechaRec" Type="Date" />
                        <ext:RecordField Name="anoreclamo" Mapping="AnoReclamo" />
                        <ext:RecordField Name="estadob" Mapping="EstadoB" />
                    </Fields>
                </ext:JsonReader>
            </Reader>
        </ext:Store>


                        <ext:FormPanel
                            ID="frmAnalisisNuevo" 
                            runat="server"
                            Border="true"
                            Layout="Form" 
                            Title="Filtro Análisis Siniestros" 
                            AutoWidth="true"
                            AutoHeight="true"
                            Icon="FolderFind">
                            <Items>
                 
                                     <ext:Panel ID="pnlFiltro" 
                                                  runat="server"
                                                  Border="false" 
                                                  Header="false" 
                                                  Height="50"
                                                  Layout="Column"
                                                  Padding="10"
                                                  BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')">
                                       <Items> 
                                       <ext:Panel runat="server" 
                                                  ID="plnCooperativa" 
                                                  Layout="Form"
                                                  LabelAlign="Right"
                                                  LabelWidth="90"
                                                  ColumnWidth=".26" 
                                                  BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')"
                                                  Border="false">
                                       <Items>
                                        <ext:ComboBox 
                                                ID="cbCooperativa"
                                                runat="server"
                                                StoreID="strCoop"            
                                                Editable="true"                                                
                                                Width="130"
                                                TypeAhead="true" 
                                                Mode="Local"
                                                ForceSelection="true"
                                                TriggerAction="All"
                                                SelectOnFocus="true"
                                                DisplayField="name"
                                                ValueField="id"
                                                ValueNotFoundText="Cargando..."
                                                EmptyText="Selecciona tu cooperativa..."
                                                FieldLabel="Cooperativa" 
                                                Resizable="true"> 
                                                    <Listeners>
                                                        <Select Handler="#{cbPlaza}.clearValue();#{strPlaza}.load();" />
                                                    </Listeners>                           
                                                </ext:ComboBox>
                                                
                                       </Items>
                                       </ext:Panel>
                    
                                        <ext:Panel runat="server" 
                                                   ID="plnPlaza" 
                                                   Layout="Form" 
                                                   LabelAlign="Right"
                                                   LabelWidth="65"
                                                   ColumnWidth=".24" 
                                                   Border="false" 
                                                   BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')" >
                                        <Items>
                                            <ext:ComboBox 
                                                ID="cbPlaza"
                                                runat="server"
                                                StoreID="strPlaza"            
                                                Editable="true"                                                
                                                Width="130"
                                                TypeAhead="true" 
                                                Mode="Local"
                                                ForceSelection="true"
                                                TriggerAction="All"
                                                SelectOnFocus="true"
                                                DisplayField="name"
                                                ValueField="id"
                                                ValueNotFoundText="Cargando..."
                                                EmptyText="Selecciona tu Plaza..." 
                                                FieldLabel="Plaza"> 
                                                <Listeners>
                                                    <Select Handler="#{cbSucursal}.clearValue();#{strSucursal}.load();" />
                                                </Listeners>                          
                                            </ext:ComboBox>
                                        </Items>
                                        </ext:Panel>

                                         <ext:Panel runat="server" 
                                                    ID="plnSucursal" 
                                                    Layout="Form" 
                                                    LabelAlign="Right"
                                                    LabelWidth="75"
                                                    ColumnWidth=".25" 
                                                    Border="false"
                                                    BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')" >
                                         <Items>
                                            <ext:ComboBox 
                                                ID="cbSucursal"
                                                runat="server" 
                                                StoreID="strSucursal"
                                                Editable="false"                                                
                                                Width="130"
                                                TypeAhead="true" 
                                                Mode="Local"
                                                ForceSelection="true"
                                                TriggerAction="All"           
                                                DisplayField="name"
                                                ValueField="id"
                                                EmptyText="Selecciona tu Sucursal..."
                                                ValueNotFoundText="Cargando..." 
                                                FieldLabel="Sucursal">
                                                
                                            </ext:ComboBox>
                     
                                         
                                         </Items>
                                         </ext:Panel>

                                         <ext:Panel runat="server" 
                                                    ID="pnlBusquedaSiniestro" 
                                                    Layout="Form" 
                                                    LabelAlign="Right"
                                                    LabelWidth="20"
                                                    ColumnWidth=".25" 
                                                    Border="false"
                                                    BodyStyle="background-image: url('/Styles/Image/bgPRYBE.png')" >
                                            <Items>
                                                <ext:CompositeField ID="cfBusquedaSiniestro"  runat="server"  >
                                                    <Items>
                                                        <ext:TextField ID="txtNumSocio" runat="server" EmptyText="No. Socio (Opcional)" LabelWidth="0" />
                                                        <ext:Button ID="btnBuscar" runat="server" Text="Buscar" Icon="Find">
                                                            <DirectEvents>
                                                                <Click OnEvent="btnBuscarSiniestros_Click"></Click>
                                                            </DirectEvents>
                                                        </ext:Button>
                                                    </Items>
                                                </ext:CompositeField>
                                            </Items>
                                         </ext:Panel>
                                         
                                       </Items>
                                       
                                     </ext:Panel>

                                   <ext:Panel ID="Panel1" runat="server" Layout="Form" Border="true" >
                                      <Items>

                                         <ext:GridPanel ID="gplAnalisis" 
                                                        runat="server" 
                                                        Height="460" 
                                                        Border="false"
                                                        Title="Siniestros"
                                                        AutoWidth="true" 
                                                        StoreID="strReclamosGral" 
                                                        Region="Center" 
                                                        Icon="PageEdit" 
                                                        Frame="false">
                                            <Plugins>                                               

                                                <ext:GridFilters>
                                                    <Filters>
                                                        <ext:StringFilter DataIndex="numsocio" />
                                                        <ext:NumericFilter DataIndex="numreclamo"/>
                                                        <ext:StringFilter DataIndex="nombre" />
                                                        <ext:StringFilter DataIndex="ocupacion" />
                                                        <ext:StringFilter DataIndex="sucursal" />
                                                        <ext:DateFilter DataIndex="fecharec" />                                                                               
                                                        <ext:ListFilter DataIndex="estadob"  
                                                            Options="Verificado,Falta Documento,PRE Analisis, Enviado, Valoracion,
                                                            Aprobado,Liberado" />
                                                    </Filters>
                                                </ext:GridFilters>
                                            </Plugins>
                    
                                            <ColumnModel>
                                                <Columns>
                                                    <ext:Column runat="server" Header="No. Siniestro" DataIndex="numreclamo" Align="Left"></ext:Column>
                                                    <ext:Column runat="server" ColumnID="Socio" Header="No. Socio" DataIndex="numsocio" Align="Left"></ext:Column>
                                                    <ext:Column runat="server" Width="250" Header="Nombre" DataIndex="nombre" Align="Left"></ext:Column>
                                                    <ext:Column runat="server" Width="100" Header="Ocupación" DataIndex="ocupacion" Align="Center"></ext:Column>
                                                    <ext:Column runat="server" Width="150" Header="Sucursal" DataIndex="sucursal" Align="Right"></ext:Column>
                                                    <ext:DateColumn runat="server" Header="Fecha de Reclamo" DataIndex="fecharec" Align="Center" Format="dd/MM/yyyy" >
                                                    </ext:DateColumn>
                                                    <ext:Column runat="server" Header="Estado Siniestro" DataIndex="estadob" Align="Center">
                                                        <Renderer Fn="Estado" />
                                                    </ext:Column>
                                                </Columns>
                                            </ColumnModel>
                    
                                            <SelectionModel>
                                                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server"   >
                                                    <DirectEvents>
                                                        <RowSelect OnEvent="CellAnalisisSiniestro_Click" >
                                                            <ExtraParams>
                                                                <ext:Parameter Name="NombreSoc" Value="Ext.value(record.data.nombre)" Mode="Raw" ></ext:Parameter>
                                                            </ExtraParams>                                                                                                                      
                                                        </RowSelect>
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
    ID="wdwInformacionSiniestro" 
    runat="server" 
    Icon="Group" 
    Title="¿Es el Siniestro a analizar?"
    Width="400" 
    Height="350" 
    AutoShow="false" 
    Modal="true"
    Closable="false" 
    Hidden="true"
    ButtonAlign="Center"
    Layout="Fit">
    <Items>        
        <ext:Panel 
            ID="pnlInformacionSiniestro" 
            runat="server" 
            Title="Información del Siniestro" 
            Icon="User" 
            Padding="5"
            LabelAlign="Right"
            Layout="Form"
            LabelWidth="150">
            <Items>
                <ext:Label ID="lblNumeroSiniestro" runat="server" FieldLabel="Número Siniestro" Width="300" 
                    StyleSpec="color: #246BB2;font-weight:bold;font-size:24px;"
                    LabelStyle="margin-top: 10px;"/>
                <ext:Label ID="lblNumeroSocio" runat="server" FieldLabel="Número de Socio" Width="250" 
                    StyleSpec="font-weight:bold;font-size:16px;"
                    LabelStyle="margin-top:3px;"/>
                <ext:Label ID="lblNombreSocio" runat="server" FieldLabel="Nombre" Width="250" />
                <ext:Label ID="lblOcupacionSocio" runat="server" FieldLabel="Ocupación" Width="250" />
                <ext:Label ID="lblCooperativa" runat="server" FieldLabel="Cooperativa" Width="300" />
                <ext:Label ID="lblPlaza" runat="server" FieldLabel="Plaza" Width="300" />
                <ext:Label ID="lblSucursalSocio" runat="server" FieldLabel="Sucursal" Width="250" />
                
                <ext:Label ID="lblEstadoBeneficio" runat="server" FieldLabel="Estado Siniestro" Width="300" 
                     StyleSpec="color: #246BB2;font-weight:bold;font-size:14px;"
                     LabelStyle="margin-top:1px;"/>                        
            </Items>
        </ext:Panel>            
    </Items>
    <Buttons>
        <ext:Button ID="btnAceptarAnalisis" runat="server" Text="Aceptar" Icon="Accept">
            <DirectEvents>
                <Click OnEvent="btnAceptarAnalisis_Click" Failure="Ext.MessageBox.alert('Saving failed', 'Error during ajax event');">
                    <%--<EventMask ShowMask="true" Target="CustomTarget" CustomTarget="={#{EmployeeDetailsWindow}.body}" />
                    <ExtraParams>
                        <ext:Parameter Name="id" Value="#{EmployeeID1}.getValue()" Mode="Raw" />
                    </ExtraParams>--%>
                </Click>
            </DirectEvents>
        </ext:Button>
        <ext:Button ID="CancelButton" runat="server" Text="Cancel" Icon="Cancel">
            <Listeners>
                <Click Handler="#{wdwInformacionSiniestro}.hide(null);" />
            </Listeners>
        </ext:Button>
    </Buttons>
</ext:Window>
</body>