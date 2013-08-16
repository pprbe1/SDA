<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FileUploadBit.ascx.cs" Inherits="SDA.App.FileUploadBit" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<ext:Store ID="strEnvio" runat="server">
    <Model>
        <ext:Model ID="Model6" runat="server">
            <Fields>
                <ext:ModelField Name="numdocumentacion" Mapping="IdDocumentacion" />
                <ext:ModelField Name="paqueteria" Mapping="Paqueteria" />
                <ext:ModelField Name="numguia" Mapping="NoGuia" />
                <ext:ModelField Name="fechaenvio" Mapping="FechaEnvio" />
                <ext:ModelField Name="fechareclamo" Mapping="FechaReclamo" />
            </Fields>
        </ext:Model>
    </Model>
    <Reader>
        <ext:ArrayReader />
    </Reader>
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
        <ext:Model ID="Model8" runat="server">
            <Fields>
                <ext:ModelField Name="id" Type="String" Mapping="Id" />
                <ext:ModelField Name="name" Type="String" Mapping="Name" />                        
            </Fields>
        </ext:Model>
    </Model>
</ext:Store>

<ext:Panel ID="paneArchivos" runat="server" Title="Archivos" Layout="ColumnLayout">
    <Items>
        <ext:GridPanel ID="grdArchivos" runat="server" ColumnWidth=".6" StoreID="strEnvio">
            <ColumnModel>
                <Columns>
                    <ext:Column ID="Column8" runat="server" Header="Fecha Envio" DataIndex="fechaenvio" Align="Center" />
                    <ext:Column ID="Column9" runat="server" Header="Paquteria" DataIndex="paqueteria" Align="Center" />
                    <ext:Column ID="Column10" runat="server" Header="N° Guia" DataIndex="numguia" Align="Left" Flex="1"/>
                    <ext:CommandColumn ID="CommandColumn1" runat="server" Width="70">
                        <Commands>
                            <ext:GridCommand Icon="Date" CommandName="Recibo" />
                            <ext:GridCommand Icon="Disk" CommandName="Descargar" />
                            <ext:GridCommand Icon="Magnifier" CommandName="Ver"/>
                        </Commands>
                        <DirectEvents>
                            <Command OnEvent="CommandArchivos">
                                <ExtraParams>
                                    <ext:Parameter Name="Command" Value="command" Mode="Raw" />
                                    <ext:Parameter Name="NoGuia" Value="Ext.value(record.data.numguia)" Mode="Raw" />
                                    <ext:Parameter Name="NoSiniestro" Value="Ext.value(record.data.numsiniestro)" Mode="Raw" />
                                    <ext:Parameter Name="NoDocumentacion" Value="Ext.value(record.data.numdocumentacion)" Mode="Raw" />
                                </ExtraParams>
                            </Command>
                        </DirectEvents>
                    </ext:CommandColumn>
                </Columns>
            </ColumnModel>
            <DirectEvents>
                <Select OnEvent="DocumentosEnvio" >
                    <ExtraParams>
                        <ext:Parameter Name="ID" Value="Ext.value(record.data.numdocumentacion)" Mode="Raw" />
                    </ExtraParams>
                </Select>
            </DirectEvents>
            <Buttons>
                <ext:Button ID="btnNuevoEnvio" runat="server" Icon="Box" Text="Nuevo Envio" OnDirectClick="NuevoEnvio" />
            </Buttons>
        </ext:GridPanel>
        <ext:FormPanel ID="frmArchivos" runat="server" ColumnWidth=".4" Title="Detalles/Nuevo Archivo">
            <Items>
                <ext:FormPanel ID="frmArchivosOpciones" runat="server" Border="false" Padding="5">
                    <Items>
                        <ext:CheckboxGroup ID="chkGroup" runat="server" ColumnsNumber="2" AllowBlank="false">
                            <Items>
                                <ext:Checkbox ID="chkDoc1" runat="server" ReadOnly="true" BoxLabel="Solicitud de Beneficios" IndicatorTip="Original de Formato de Solicitud de Beneficios" />
                                <ext:Checkbox ID="chkDoc2" runat="server" ReadOnly="true" BoxLabel="Solicitud de Ingreso" IndicatorTip="Original de Solicitud de ingreso" />
                                <ext:Checkbox ID="chkDoc3" runat="server" ReadOnly="true" BoxLabel="Designacion de Beneficiarios" IndicatorTip="Original de Designación de beneficiarios" />
                                <ext:Checkbox ID="chkDoc4" runat="server" ReadOnly="true" BoxLabel="Contrato de Dep. a Plazo Fijo Inicial y Subsecuentes" IndicatorTip="Original de Contrato de depósito a plazo fijo inicial y subsecuentes" />
                                <ext:Checkbox ID="chkDoc5" runat="server" ReadOnly="true" BoxLabel="Solicitud de Prestamo de cada credito reclamado" IndicatorTip="Original de Solicitud de préstamo (de cada uno de los créditos reclamados)" />
                                <ext:Checkbox ID="chkDoc6" runat="server" ReadOnly="true" BoxLabel="Pagaré o Línea de Crédito" IndicatorTip="Original de Pagaré o línea de crédito (de cada uno de los créditos reclamados)" />
                                <ext:Checkbox ID="chkDoc7" runat="server" ReadOnly="true" BoxLabel="Auxiliar de Parte Social" IndicatorTip="Original de Auxiliar de parte social" />
                                <ext:Checkbox ID="chkDoc8" runat="server" ReadOnly="true" BoxLabel="Auxiliar de Cada Cuenta de Captación" IndicatorTip="Original de Auxiliar de cada una de las cuentas de captación" />
                                <ext:Checkbox ID="chkDoc9" runat="server" ReadOnly="true" BoxLabel="Auxiliar de Cada Préstamo" IndicatorTip="Original de Auxiliar de cada préstamo reclamado" />
                                <ext:Checkbox ID="chkDoc10" runat="server" ReadOnly="true" BoxLabel="Acta de Defunción del Socio" IndicatorTip="Original Acta de defunción del socio" />
                                <ext:Checkbox ID="chkDoc11" runat="server" ReadOnly="true" BoxLabel="Acta de Nacimiento del Socio" IndicatorTip="Copia de Acta de nacimiento del socio" />
                                <ext:Checkbox ID="chkDoc12" runat="server" ReadOnly="true" BoxLabel="Acta de Nacimiento de cada Beneficiario" IndicatorTip="Copia de Acta de nacimiento de cada uno de los beneficiarios" />
                                <ext:Checkbox ID="chkDoc13" runat="server" ReadOnly="true" BoxLabel="Identificación Oficial del Socio" IndicatorTip="Copia de Identificación oficial del socio" />
                                <ext:Checkbox ID="chkDoc14" runat="server" ReadOnly="true" BoxLabel="Identificación Oficial de Cada Beneficiario" IndicatorTip="Copia de Identificación oficial de cada uno de los beneficiarios" />
                                <ext:Checkbox ID="chkDoc15" runat="server" ReadOnly="true" BoxLabel="Parte del Ministerio Público" IndicatorTip="Parte Oficial del M.P., para aquellos casos de que el fallecimiento hubiera sido de manera violenta (homicidio, suicidio, accidental)" />
                                <ext:Checkbox ID="chkDoc16" runat="server" ReadOnly="true" BoxLabel="Dictamen Médico" IndicatorTip="Dictamen médico emitido por una institución pública del sector salud (IMSS, ISSSTE, SSA) que determine la incapacidad total y permanente a causa de accidente" />
                            </Items>
                        </ext:CheckboxGroup>
                    </Items>
                </ext:FormPanel>
                <ext:FormPanel ID="frmArchivosOpciones2" runat="server" Border="false" Padding="5">
                    <Items>
                        <ext:FileUploadField ID="fileSelector" runat="server" FieldLabel="Archivo" ReadOnly="true" AllowBlank="false" Regex="(.pdf|.PDF)" LabelWidth="130" />
                    </Items>
                </ext:FormPanel>
            </Items>
            <Buttons>
                <ext:Button ID="btnGuardarArchivo" runat="server" Text="Guardar" Icon="Disk" Hidden="true" FormBind="true">
                    <DirectEvents>
                        <Click OnEvent="InsertarEnvio" After="Ext.Msg.wait('Se está enviando el documento a su destino. Esto puede tomar algunos minutos...', 'Enviando');" Complete="Ext.Msg.hide()" />
                    </DirectEvents>
                </ext:Button>
                <ext:Button ID="btnCancelarArchivo" runat="server" Text="Cancelar" Icon="Cancel" Hidden="true" OnDirectClick="RestaurarArchivos" />
            </Buttons>
        </ext:FormPanel>
    </Items>
</ext:Panel>
<ext:Window ID="wndPDF" runat="server" Title="Vista Previa del Documento" Maximized="true" Hidden="true">
    <Loader ID="ldPDF" runat="server" Url="/App/PdfReader.aspx" Mode="Frame" AutoLoad="false" />
</ext:Window>
<ext:Window ID="wndRecibo" runat="server" Title="Agregar fecha de recibo" Height="260" Layout="FitLayout" Hidden="true">
    <Items>
        <ext:DatePicker ID="dateRecibo" runat="server" />
    </Items>
    <Buttons>
        <ext:Button ID="btnGuardarRecibo" runat="server" Text="Guardar" Icon="Accept" OnDirectClick="UpdateFechaRecibo">
            <DirectEvents>
                <Click OnEvent="UpdateFechaRecibo">
                    <ExtraParams>
                        <ext:Parameter Name="FechaRecibo" Value="Ext.value(#{dateRecibo}.getValue())" Mode="Raw" />
                    </ExtraParams>
                </Click>
            </DirectEvents>
        </ext:Button>
    </Buttons>
</ext:Window>