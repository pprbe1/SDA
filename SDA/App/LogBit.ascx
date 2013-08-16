<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LogBit.ascx.cs" Inherits="SDA.App.LogBit" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<ext:Store ID="strBitacora" runat="server">
    <Model>
        <ext:Model ID="Model4" runat="server">
            <Fields>
                <ext:ModelField Name="numbitacora" Mapping="IdBitacora" />
                <ext:ModelField Name="fecha" Mapping="Fecha" Type="Date" />
                <ext:ModelField Name="status" Mapping="Status" />
                <ext:ModelField Name="usuario" Mapping="Usuario" />
                <ext:ModelField Name="mensaje" Mapping="Mensaje" />
            </Fields>
        </ext:Model>
    </Model>
    <Reader>
        <ext:ArrayReader />
    </Reader>
</ext:Store>

<ext:Panel ID="paneBitacora" runat="server" Title="Bitacora" Layout="ColumnLayout">
    <Items>
        <ext:GridPanel ID="grdBitacora" runat="server" ColumnWidth=".6" StoreID="strBitacora">
            <ColumnModel>
                <Columns>
                    <ext:DateColumn ID="Column5" runat="server" Header="Fecha" DataIndex="fecha" Align="Center" Format="dd/MM/yyyy" />
                    <ext:Column ID="Column6" runat="server" Header="Estado" DataIndex="status" Align="Center" />
                    <ext:Column ID="Column7" runat="server" Header="Usuario" DataIndex="usuario" Align="Left" Flex="1" />
                </Columns>
            </ColumnModel>
            <DirectEvents>
                <Select OnEvent="MostrarMensaje">
                    <ExtraParams>
                        <ext:Parameter Name="Mensaje" Value="record.data.mensaje" Mode="Raw" />
                    </ExtraParams>
                </Select>
            </DirectEvents>
            <Buttons>
                <ext:Button ID="btnNuevaBitacora" runat="server" Icon="Pencil" Text="Nueva Entrada" OnDirectClick="NuevaBitacora" />
            </Buttons>
        </ext:GridPanel>
        <ext:FormPanel ID="frmBitacora" runat="server" ColumnWidth=".4" Title="Detalles/Nueva Bitacora" Border="false" Layout="FitLayout">
            <Items>
                <ext:HtmlEditor ID="txtBitacora" runat="server" Height="300" Width="120" ReadOnly="true" />
            </Items>
            <Buttons>
                <ext:Button ID="btnGuardarBitacora" runat="server" Text="Guardar" Icon="Disk" Hidden="true" OnDirectClick="InsertarBitacora" FormBind="true" />
                <ext:Button ID="btnCancelarBitacora" runat="server" Text="Cancelar" Icon="Cancel" Hidden="true" OnDirectClick="RestaurarBitacora" />
            </Buttons>
        </ext:FormPanel>
    </Items>
</ext:Panel>