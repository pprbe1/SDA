<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="SDA.App.Menu" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head id="Head1" runat="server">
    <title>Deudor Ahorrador | Menú Principal</title>

    <style>
        body {
            font-size : 12px;
            background-color : #284051;
            font-family : "Trebuchet MS",sans-serif;
        }
    
        #settingsWrapper {
            border-bottom    : 1px solid #111;
            background-color : #323232;
            padding-left     : 4px;
        }
    
        #settings {
            padding : 2px;
            border-bottom : 1px solid #3B3B3B;
        }
    
        #settings ul li {
            display      : inline;
            color        : #fff;
            margin-right : 8px;
            line-height  : 24px;
            padding      : 2px;
            padding-left : 19px;
        }
    
        #settings ul li a, #settings ul li a:link {
            color : #fff;
            text-decoration : none;
        }
    
        #settings ul li a:hover {
            text-decoration : underline;
        }
    
        #pageTitle {
            font-family : "Trebuchet MS",sans-serif;
            font-size   : 17px;
            text-align  : center;
            color       : #323232;
            margin-top  : 5px;
        }
    
        #itemBack {
            background : url(<%= this.ResourceManager1.GetIconUrl(Icon.House) %>) no-repeat 0 2px;
        }
    
        #itemHelp {
            background : url(<%= this.ResourceManager1.GetIconUrl(Icon.Help) %>) no-repeat 0 2px;
        }
    
        #itemConfig {
            background : url(<%= this.ResourceManager1.GetIconUrl(Icon.Cog) %>) no-repeat 0 2px;
        }
    
        #itemClose {
            background : url(<%= this.ResourceManager1.GetIconUrl(Icon.Decline) %>) no-repeat 0 2px;
        }
        
        .x-accordion-hd .x-panel-header-text {
        color: black;
        font-weight: bold;
        font-size: 12px;
        }
                        
        .x-menu-item-text {
        font-size: 12px;
        color: #222;
        }
        
        .x-panel-header-text-default {
        color: #333;
        font-size: 14px;
        font-weight: bold;
        font-family: tahoma,arial,verdana,sans-serif;
        line-height: 17px;
        }   
         
    </style>
    
    <ext:XScript ID="XScript1" runat="server">
        <script>
            var addTab = function (tabPanel, id, url, menuItem, titulo) {
                var tab = tabPanel.getComponent(id);

                if (!tab) {
                    tab = tabPanel.add({ 
                        id       : id, 
                        title    : titulo, 
                        closable : true,
                        menuItem : menuItem,
                        loader   : {
                            url      : url,
                            renderer : "frame",
                            loadMask : {
                                showMask : true,
                                msg      : "Cargando " + titulo + "..."
                            }
                        }
                    });

                    tab.on("activate", function (tab) {
                        #{mpRegistro}.setSelection(tab.menuItem);
                    });

                    tab.on("activate", function (tab) {
                        #{mpSeguimiento}.setSelection(tab.menuItem);
                    });

                    tab.on("activate", function (tab) {
                        #{mpReportes}.setSelection(tab.menuItem);
                    });

                    tab.on("activate", function (tab) {
                        #{mpEstadisticas}.setSelection(tab.menuItem);
                    });
                }
            
                tabPanel.setActiveTab(tab);
            }
        </script>
    </ext:XScript>
</head>

<body>
<form id="Form1" runat="server">    

    <ext:ResourceManager ID="ResourceManager1" runat="server" Theme="Gray" />
        
    <ext:Viewport ID="Viewport1" runat="server" StyleSpec="background-color: #fff;" Layout="BorderLayout">
        <Items>
            <ext:Panel 
                ID="pnlMnenu" 
                runat="server"
                Region="North"
                Height="110" 
                Border="false" 
                Header="false" 
                BodyStyle="background-color: transparent;">
                <Content>
                    <div id="settingsWrapper">
                        <div id="settings">
                            <ul>
                                <li id="itemBack"><a href="../Default.aspx">Regresar</a></li>
                                <li id="itemHelp"><a href="#">Ayuda</a></li>
                                <li id="itemConfig"><a href="#">Configuración</a></li>
                                <li id="itemClose"><a href="#">Salir</a></li>
                            </ul>
                        </div>
                    </div>

                    <div id="pageTitle">                        
                        <img src="/Media/Image/Buttons/header.png"/>                        
                    </div>
                </Content>
            </ext:Panel>

            <ext:Panel 
                runat="server"
                Region="West" 
                Title="Menú Principal" 
                Width="200" 
                ID="pnlSettings"
                Collapsible="true"
                MinWidth="175" 
                MaxWidth="400" 
                Layout="AccordionLayout"
                Split="true" 
                Collapsed="false">                

                <Items>
                <ext:MenuPanel 
                    ID="mpRegistro" Collapsed="true" 
                    Title="Registro de Siniestro" 
                    Icon="User"
                    runat="server" 
                    Width="200" 
                    Region="West"
                    >
                    <Menu ID="mRegistro" runat="server">
                        <Items>
                            <ext:MenuItem ID="miAS" runat="server" Text="Alta de Siniestro" Icon="UserAdd">
                                <Listeners>
                                    <Click Handler="addTab(#{tabMain}, 'idAS', 'SocioBeneficios.aspx', this, 'Siniestro - Nuevo Siniestro');" />
                                </Listeners>
                            </ext:MenuItem>                            
                            
                           <%-- <ext:MenuItem ID="miOrder" runat="server" Text="Pedido" Icon="TableAdd">
                                <Listeners>
                                    <Click Handler="addTab(#{tabMain}, 'idOrder', 'http://www.w3schools.com/', this, 'Pedido');" />
                                </Listeners>
                            </ext:MenuItem>                            
                            
                            <ext:MenuItem ID="miFactura" runat="server" Text="Facturas" Icon="PageAttach">
                                <Listeners>
                                    <Click Handler="addTab(#{tabMain}, 'idInvoice', 'http://www.w3schools.com/', this, 'Facturas');" />
                                </Listeners>
                            </ext:MenuItem>

                            <ext:MenuItem ID="miNota" runat="server" Text="Nota de Crédito" Icon="PageWhitePut">
                                <Listeners>
                                    <Click Handler="addTab(#{tabMain}, 'idNota', 'http://www.w3schools.com/', this, 'Nota de Crédito');" />
                                </Listeners>
                            </ext:MenuItem>--%>
                        </Items>
                    </Menu>
                </ext:MenuPanel>

                <ext:MenuPanel 
                    ID="mpSeguimiento" Collapsed="true"  
                    Title="Seguimiento de Siniestros" 
                    Icon="Briefcase"
                    runat="server" 
                    Width="200" 
                    Region="West" Collapsible="true"
                    >
                    <Menu ID="mContratos" runat="server">
                        <Items>
                            <ext:MenuItem ID="miSS" runat="server" Text="Consulta de Siniestro" Icon="MagnifierZoomIn">
                                <Listeners>
                                    <Click Handler="addTab(#{tabMain}, 'idCS', 'AnalisisReclamo.aspx', this, 'Seguimiento - Consulta de Siniestro');" />
                                </Listeners>
                            </ext:MenuItem>                            
                            
                            <%--<ext:MenuItem ID="miOC" runat="server" Text="Pedidos de Clientes" Icon="TableAdd">
                                <Listeners>
                                    <Click Handler="addTab(#{tabMain}, 'idOC', 'http://www.w3schools.com/', this, 'Pedido de Clientes');" />
                                </Listeners>
                            </ext:MenuItem>                            
                            
                            <ext:MenuItem ID="miIC" runat="server" Text="Facturas de Clientes" Icon="PageAttach">
                                <Listeners>
                                    <Click Handler="addTab(#{tabMain}, 'idIC', 'http://www.w3schools.com/', this, 'Facturas de Clientes');" />
                                </Listeners>
                            </ext:MenuItem>

                            <ext:MenuItem ID="miNC" runat="server" Text="Nota de Crédito de Clientes" Icon="PageWhitePut">
                                <Listeners>
                                    <Click Handler="addTab(#{tabMain}, 'idNC', 'http://www.w3schools.com/', this, 'Nota de Crédito de Clientes');" />
                                </Listeners>
                            </ext:MenuItem>--%>
                        </Items>
                    </Menu>
                </ext:MenuPanel>

                <ext:MenuPanel 
                    ID="mpReportes" Collapsed="true"  
                    Title="Reportes" 
                    Icon="Report"
                    runat="server" 
                    Width="200" 
                    Region="West" Collapsible="true"
                    >
                    <Menu ID="mReporte1" runat="server">
                        <Items>
                            <ext:MenuItem ID="miR1" runat="server" Text="Reporte #1" Icon="Report">
                                <Listeners>
                                    <Click Handler="addTab(#{tabMain}, 'idNB', 'http://www.w3schools.com/', this, 'Reportes -  Reportes #1');" />
                                </Listeners>
                            </ext:MenuItem>                            
                            
                            <%--<ext:MenuItem ID="miOP" runat="server" Text="Orden de Producción" Icon="PackageGo">
                                <Listeners>
                                    <Click Handler="addTab(#{tabMain}, 'idOP', 'http://www.w3schools.com/', this, 'Orden de Producción');" />
                                </Listeners>
                            </ext:MenuItem>  --%>                           
                        </Items>
                    </Menu>
                </ext:MenuPanel>

                <ext:MenuPanel 
                    ID="mpEstadisticas" Collapsed="true"  
                    Title="Estadísticas" 
                    Icon="ChartCurve"
                    runat="server" 
                    Width="200" 
                    Region="West" Collapsible="true"
                    >
                    <Menu ID="mEstadistica1" runat="server">
                        <Items>
                            <ext:MenuItem ID="miE1" runat="server" Text="Estadística #1" Icon="Group">
                                <Listeners>
                                    <Click Handler="addTab(#{tabMain}, 'idCC', 'http://www.w3schools.com/', this, 'Estadísticas - Estadística #1');" />
                                </Listeners>
                            </ext:MenuItem>                            
                            
                            <%--<ext:MenuItem ID="miReception" runat="server" Text="Recepciones" Icon="PackageIn">
                                <Listeners>
                                    <Click Handler="addTab(#{tabMain}, 'idRecep', 'http://www.w3schools.com/', this, 'Recepciones');" />
                                </Listeners>
                            </ext:MenuItem>                            
                            
                            <ext:MenuItem ID="miTransfer" runat="server" Text="Transferencias" Icon="PackageLink">
                                <Listeners>
                                    <Click Handler="addTab(#{tabMain}, 'idTrans', 'http://www.w3schools.com/', this, 'Transferencias');" />
                                </Listeners>
                            </ext:MenuItem>   --%>                         
                        </Items>
                    </Menu>
                </ext:MenuPanel>   

                </Items>                                    
            </ext:Panel>

            <ext:TabPanel 
                ID="tabMain"
                Region="Center"
                runat="server" 
                Border="true" >                
            </ext:TabPanel> 
        </Items>
    </ext:Viewport>
</form>
</body>
</html>