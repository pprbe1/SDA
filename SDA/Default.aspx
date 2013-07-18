<%@ Page Title="SDA" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="SDA._Default" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style>
        .x-fieldset-header .x-fieldset-header-text 
        {
            float: left;
            padding: 1px 0;
            font-size: 15px;
            font-weight: bold;
            font-family: tahoma,arial,verdana,sans-serif;
        }
        
        .x-fieldset-header {
        font: 11px/14px bold tahoma,arial,verdana,sans-serif;
        color: #333;
        text-align: center;
        }
        
        .x-btn {
            display: inline-block;
            zoom: 1;
            position: relative;
            cursor: pointer;
            cursor: hand;
            white-space: nowrap;
            vertical-align: middle;
            background-repeat: no-repeat;
            padding-left: 75px;
            }
    
        .x-panel-header-text-default 
        {
            color: #333;
            font-size: 14px;
            font-weight: bold;
            font-family: tahoma,arial,verdana,sans-serif;
            line-height: 17px;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <ext:ResourceManager ID="DefaultResource" runat="server" Theme="Gray"   />
    
    <ext:FormPanel 
        ID="FormPanel1" 
        runat="server" 
        Title="Menú Principal" 
        Icon="ApplicationHome"
        Height="320"
        Layout="ColumnLayout" ButtonAlign="Center">
    <Items>

        <ext:Panel ID="Panel1" runat="server" Height="60" Layout="ColumnLayout" Width="917" Border="false"/>                          

        <ext:Panel ID="FormPanel3" runat="server" Height="165" Layout="ColumnLayout" Width="917" Border="false">
                <Items>

                <ext:FieldSet ID="FieldSet1" runat="server" Title="Registro de Siniestros" Disabled="false" ColumnWidth=".33" Border="false" >

                    <Defaults>
                        <ext:Parameter Name="LabelWidth" Value="90"/>
                    </Defaults>              

                    <Items>
                        <ext:ImageButton ID="btnRegistro"
                            runat="server" 
                            ImageUrl="/Media/Image/Buttons/registro.png" StyleSpec="padding:0px 0px 0px 60px;">
                            <DirectEvents>
                                <Click OnEvent="Button_Click" />
                            </DirectEvents>
                        </ext:ImageButton>
                    </Items>
                    </ext:FieldSet>                   

                    <ext:FieldSet ID="FieldSet2" runat="server" Title="Seguimiento de Siniestros" Disabled="false" ColumnWidth=".33" Border="false">

                    <Defaults>
                        <ext:Parameter Name="LabelWidth" Value="90" />
                    </Defaults>                    

                    <Items>           
                        <ext:ImageButton ID="btnSeguimiento" 
                            runat="server" 
                            ImageUrl="/Media/Image/Buttons/seguimiento.png">
                            <DirectEvents>
                                <Click OnEvent="Button_Click" />
                            </DirectEvents>
                        </ext:ImageButton>
                    </Items>
                    </ext:FieldSet>      
                    
                    <ext:FieldSet ID="FieldSet3" runat="server" Title="Reportes y Estadísticas" Disabled="false" ColumnWidth=".33" Border="false">

                    <Defaults>
                        <ext:Parameter Name="LabelWidth" Value="90" />
                    </Defaults>                    

                    <Items>                    
                        <ext:ImageButton ID="btnEstadisticas" 
                            runat="server" 
                            ImageUrl="/Media/Image/Buttons/estadisticas.png">
                            <DirectEvents>
                                <Click OnEvent="Button_Click" />
                            </DirectEvents>
                        </ext:ImageButton>          
                    </Items>
                    </ext:FieldSet>                            
                </Items>                
                </ext:Panel>

        <ext:Panel ID="Panel2" runat="server" Height="40" Layout="ColumnLayout" Width="917" Border="false" />
    </Items>                

    </ext:FormPanel>    
</asp:Content>
