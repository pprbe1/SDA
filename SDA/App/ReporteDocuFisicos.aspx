<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReporteDocuFisicos.aspx.cs" Inherits="SDA.App.ReporteDocuFisicos" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        function tipRenderer(storeItem, item) {
            //calculate percentage.
            var total = 0;

            App.pieChart.getStore().each(function (rec) {
                total += rec.get('Total');
            });

            this.setTitle(storeItem.get('Id') + ': ' + Math.round(storeItem.get('Total') / total * 100) + '%');
        }                   
    </script>

    <script>
        var saveData = function () {
            App.Hidden1.setValue(Ext.encode(App.GridPanel1.getRowsValues({ selectedOnly: false })));
        };
    </script>

    <script>
        function saveBar(btn) {
            Ext.MessageBox.confirm('Confirm Download', 'Would you like to download the chart as an image?', function (choice) {
                if (choice == 'yes') {
                    App.Chart1.save({
                        type: 'image/png'
                    });
                }
            });
        }
    </script>

    <script>
        var onKeyUp = function () {
            var me = this,
                v = me.getValue(),
                field;

            if (me.startDateField) {
                field = Ext.getCmp(me.startDateField);
                field.setMaxValue(v);
                me.dateRangeMax = v;
            } else if (me.endDateField) {
                field = Ext.getCmp(me.endDateField);
                field.setMinValue(v);
                me.dateRangeMin = v;
            }

            field.validate();
        };
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" Theme="Gray">
            <%--<Listeners>
                <DocumentReady Handler="#{cbCoop}.setValue(1);" />
            </Listeners>--%>
        </ext:ResourceManager>
        <ext:Hidden ID="Hidden1" runat="server" />

                <ext:Window ID="wdFechas" 
                    runat="server" 
                    Width="250" Height="125"
                    Title="Selecciona la fecha..."
                    Icon="Date"
                    AutoHeight="true"
                    Closable="false"
                    BodyPadding="5"
                    Layout="Anchor"
                    DefaultAnchor="100%" Hidden="true" ButtonAlign="Center">
                <Items>
                    <ext:DateField 
                        ID="DateField1" 
                        runat="server"
                        Vtype="daterange"
                        FieldLabel="Fecha Inicio"
                        EnableKeyEvents="true">  
                        <CustomConfig>
                            <ext:ConfigItem Name="endDateField" Value="DateField2" Mode="Value" />
                        </CustomConfig>
                        <Listeners>
                            <KeyUp Fn="onKeyUp" />
                        </Listeners>
                    </ext:DateField>
                
                    
                    <ext:DateField 
                        ID="DateField2"
                        runat="server" 
                        Vtype="daterange"
                        FieldLabel="Fecha Fin"
                        EnableKeyEvents="true">    
                        <CustomConfig>
                            <ext:ConfigItem Name="startDateField" Value="DateField1" Mode="Value" />
                        </CustomConfig>
                        <Listeners>
                            <KeyUp Fn="onKeyUp" />
                        </Listeners>
                    </ext:DateField>
                
            </Items>           
                <Buttons>
                    <ext:Button ID="Button117" 
                    runat="server" 
                    Text="Aceptar" 
                    Icon="Accept" 
                    OnDirectClick="Update"
                    />     
                                    
                    <ext:Button ID="Button118" 
                    runat="server" 
                    Text="Cancelar" 
                    Icon="Decline" 
                    OnDirectClick="Close"
                    />  

                </Buttons>
        </ext:Window>
        <ext:FormPanel ID="FormPanel1" runat="server" Title="Reporte Finiquitos - Información General" Icon="Information" AutoHeight="true" Layout="ColumnLayout" Collapsible="true">
                <Items>

                    <ext:Panel ID="Panel1" runat="server"  ColumnWidth="1" Icon="Database" AutoHeight="true" AutoScroll="true">
                    <Items>

                        <ext:GridPanel ID="GridPanel1" 
                        runat="server" 
                        Border="false"
                        Flex="3"

                        AutoHeight="true">

                        <TopBar>
                            <ext:Toolbar ID="Toolbar1" runat="server">
                                <Items>
                                    <ext:ToolbarFill ID="ToolbarFill1" runat="server" />                       
                                   
                                   <ext:Button ID="Button1" 
                                    runat="server" 
                                    Text="Actualizar Información" 
                                    Icon="ArrowRefresh" 
                                    OnDirectClick="ReloadData"
                                    />                            
                                    
                                    <ext:Button ID="Button4" 
                                    runat="server" 
                                    Text="Período" 
                                    Icon="DateMagnify" 
                                    OnDirectClick="ActualizaFecha"
                                    />                                  

                                    <%--<ext:Button ID="Button6" 
                                    runat="server" 
                                    Text="Gráfica Barras" 
                                    Icon="ChartBarAdd"
                                    Handler="saveBar"
                                    />--%>
                                    
                                    <%--<ext:Button ID="Button2" runat="server" Text="Exportar a Excel" AutoPostBack="true" OnClick="ToExcel" Icon="PageExcel">
                                        <Listeners>
                                            <Click Fn="saveData" />
                                        </Listeners>
                                    </ext:Button>--%>
                        
                                    <%--<ext:Button ID="Button3" runat="server" Text="Exportar a CSV" AutoPostBack="true" OnClick="ToCsv" Icon="PageAttach">
                                        <Listeners>
                                            <Click Fn="saveData" />
                                        </Listeners>
                                    </ext:Button>--%>
                                </Items>
                            </ext:Toolbar>
                        </TopBar>

                        <Store>
                            <ext:Store ID="Store3" runat="server" >
                                <Model>
                                    <ext:Model ID="Model3" runat="server" IDProperty="Id">
                                        
                                        <Fields>
                                            <ext:ModelField Name="IdReclamo" />
                                                    <ext:ModelField Name="Plaza" />
                                                    <ext:ModelField Name="Sucursal" />
                                                    <ext:ModelField Name="NombreEjecutivo" />
                                                    <ext:ModelField Name="FechaRegistro" />
                                                    <ext:ModelField Name="NoSocio" />
                                                    <ext:ModelField Name="NombreSocio" />
                                                    <ext:ModelField Name="FechaEnvio" />
                                                    <ext:ModelField Name="Paqueteria" />
                                                    <ext:ModelField Name="NoGuia" />
                                        </Fields>
                                    </ext:Model>
                                </Model>
                            </ext:Store>
                        </Store>
                        <ColumnModel ID="ColumnModel1" runat="server">
                            <Columns>
                                <ext:Column ID="Column2" runat="server" Text="No. Reclamo" DataIndex="IdReclamo" Width="80" />
                                <ext:Column ID="Column3" runat="server" Text="Plaza" DataIndex="Plaza" Flex="1" Width="150" />
                                <ext:Column ID="Column4" runat="server" Text="Sucursal" DataIndex="Sucursal" Width="150"  />
                                <ext:Column ID="Column5" runat="server" Text="Ejecutivo" DataIndex="NombreEjecutivo" Width="250"  />
                                <ext:Column ID="Column6" runat="server" Text="Fecha Registro" DataIndex="FechaRegistro" Width="90" />
                                <ext:Column ID="Column7" runat="server" Text="No. Socio" DataIndex="NoSocio" Width="90"/>
                                <ext:Column ID="Column8" runat="server" Text="Socio" DataIndex="NombreSocio" Width="250"  />
                                <ext:Column ID="Column13" runat="server" Text="Fecha Envío" DataIndex="FechaEnvio" Width="90"/>
                                <ext:Column ID="Column14" runat="server" Text="Paqueteria" DataIndex="Paqueteria" Flex="1" />
                                <ext:Column ID="Column1" runat="server" Text="No. Guía" DataIndex="NoGuia" Flex="1" />
                            </Columns>
                        </ColumnModel>
                        <SelectionModel>
                            <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" Mode="Multi" />
                        </SelectionModel>
                        
                        <View>
                            <ext:GridView ID="GridView1" 
                                runat="server"
                                ScrollOffset="2"
                                StripeRows="true"
                                TrackOver="true"
                                />
                        </View>
                        <%--<Features>
                        <ext:Grouping ID="GroupingView4"
                            runat="server"
                            ForceFit="true"
                            MarkDirty="false"
                            ShowGroupName="false"
                            EnableNoGroups="true"
                            HideGroupedHeader="true" >
                            
                        </ext:Grouping>
                    </Features>--%>
                    </ext:GridPanel>

                    </Items>
                    </ext:Panel>

                    
                               
                </Items>                

                </ext:FormPanel>
    </form>
</body>
</html>
