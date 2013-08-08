<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReporteGralDA.aspx.cs" Inherits="SDA.App.ReporteGralDA" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="ResourceManager1" runat="server" Theme="Gray">
            <%--<Listeners>
                <DocumentReady Handler="#{cbCoop}.setValue(1);" />
            </Listeners>--%>
        </ext:ResourceManager>
        <ext:FormPanel ID="FormPanel1" runat="server" Title="Reporte General de Siniestro SDA - Información General" Icon="Information" AutoHeight="true" Layout="ColumnLayout" Collapsible="true">
                <Items>

                    <ext:Panel ID="Panel1" runat="server"  ColumnWidth="1" Icon="Database" AutoScroll="true">
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
                                   
                                   <%--<ext:Button ID="Button1" 
                                    runat="server" 
                                    Text="Actualizar Información" 
                                    Icon="ArrowRefresh" 
                                    OnDirectClick="ReloadData"
                                    />--%>                            
                                    
                                    <%--<ext:Button ID="Button4" 
                                    runat="server" 
                                    Text="Período" 
                                    Icon="DateMagnify" 
                                    OnDirectClick="ActualizaFecha"
                                    />--%>                                  

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
                            <ext:Store ID="Store3" runat="server" GroupField="IdReclamo">
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
                                                    <ext:ModelField Name="SaldoPrestamo" />
                                                    <ext:ModelField Name="SaldoAhorro" />
                                                    <ext:ModelField Name="AyudaFuneraria" />
                                                    <ext:ModelField Name="SeguroMutual" />
                                                    <ext:ModelField Name="Cuenta" />
                                                    <ext:ModelField Name="NombreBeneficiario" />
                                                    <ext:ModelField Name="SaldoBene" />
                                        </Fields>
                                    </ext:Model>
                                </Model>
                            </ext:Store>
                        </Store>
                        <ColumnModel ID="ColumnModel1" runat="server">
                            <Columns>
                                <ext:Column ID="Column2" runat="server" Text="No. Reclamo" DataIndex="IdReclamo" Flex="1" />
                                <ext:Column ID="Column3" runat="server" Text="Plaza" DataIndex="Plaza" Flex="1" Width="100" />
                                <ext:Column ID="Column4" runat="server" Text="Sucursal" DataIndex="Sucursal"  />
                                <ext:Column ID="Column5" runat="server" Text="Ejecutivo" DataIndex="NombreEjecutivo" Width="300"  />
                                <ext:Column ID="Column6" runat="server" Text="Fecha Registro" DataIndex="FechaRegistro" Flex="1" />
                                <ext:Column ID="Column7" runat="server" Text="No. Socio" DataIndex="NoSocio"  />
                                <ext:Column ID="Column8" runat="server" Text="Socio" DataIndex="NombreSocio"  />
                                <ext:Column ID="Column9" Align="Right" runat="server" Text="Saldo Prestamo" DataIndex="SaldoPrestamo" Flex="1" >
                                    <Renderer Format="UsMoney"></Renderer>
                                </ext:Column>
                                <ext:Column ID="Column10" Align="Right" runat="server" Text="Saldo Ahorro" DataIndex="SaldoAhorro" Flex="1" >
                                    <Renderer Format="UsMoney"></Renderer>
                                </ext:Column>
                                <ext:Column ID="Column11" Align="Right" runat="server" Text="Ayuda Funeraria" DataIndex="AyudaFuneraria" Flex="1" >
                                    <Renderer Format="UsMoney"></Renderer>
                                </ext:Column>
                                <ext:Column ID="Column12" Align="Right" runat="server" Text="Seguro Mutual" DataIndex="SeguroMutual" Flex="1" >
                                    <Renderer Format="UsMoney"></Renderer>
                                </ext:Column>
                                <ext:Column ID="Column13" runat="server" Text="Cuenta" DataIndex="Cuenta" Flex="1" />
                                <ext:Column ID="Column14" runat="server" Text="Beneficiario" DataIndex="NombreBeneficiario" Flex="1" />
                                <ext:Column ID="Column15" Align="Right" runat="server" Text="Saldo Beneficiario" DataIndex="SaldoBene" Flex="1" >
                                    <Renderer Format="UsMoney"></Renderer>
                                </ext:Column>
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
                        <Features>
                        <ext:Grouping ID="GroupingView4"
                            runat="server"
                            ForceFit="true"
                            MarkDirty="false"
                            ShowGroupName="false"
                            EnableNoGroups="true"
                            HideGroupedHeader="true" >
                            
                        </ext:Grouping>
                    </Features>
                    </ext:GridPanel>

                    </Items>
                    </ext:Panel>

                    
                               
                </Items>                

                </ext:FormPanel>  
    </form>
</body>
</html>
