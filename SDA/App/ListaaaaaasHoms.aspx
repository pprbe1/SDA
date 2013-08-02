<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ListaaaaaasHoms.aspx.cs" Inherits="SDA.App.ListaaaaaasHoms" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>

<html>
<head id="Head1" runat="server">
    <title>Editor with DirectMethod - Ext.NET Examples</title>
    <script type="text/javascript">
        var save = function (store) {
            var totalPercent = 0;
            var items = new Array();

            store.each(function (record) {
                totalPercent += record.data.Percentage;
                items.push(record.data);
            });

            if (totalPercent > 100)
                Ext.MessageBox.alert('Verifique su informacion', 'El total de porcentaje excede el 100% (' + totalPercent + '%)');

            else if (totalPercent < 100)
                Ext.MessageBox.alert('Verifique su informacion', 'El total de porcentaje no alcanza el 100% (' + totalPercent + '%)');
            
            else
                bitchYouMadeItToOneHundredPercent(items);
        };

        function bitchYouMadeItToOneHundredPercent(items) {
            App.Edit(items);
        }
    </script>
</head>
<body>
    <form id="Form1" runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />

        <ext:GridPanel 
            ID="GridPanel1"
            runat="server" 
            Title="Editable GridPanel"
            Width="600" 
            Height="350">
            <Store>
                <ext:Store ID="strBeneficiarios" runat="server">
                    <Model>
                        <ext:Model ID="Model1" runat="server" IDProperty="ID">
                            <Fields>
                                <ext:ModelField Name="ID" Type="Int" />
                                <ext:ModelField Name="Nombre" />
                                <ext:ModelField Name="Percentage" Type="Float" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel ID="ColumnModel1" runat="server">
                <Columns>
                    <ext:Column ID="Column1" runat="server" Text="ID" DataIndex="ID" Width="35" />
                    <ext:Column ID="Column2" runat="server" Text="Name" DataIndex="Name" Flex="1" />
                    <ext:Column ID="Column3" runat="server" Text="Price" DataIndex="Percentage">
                        <Editor>
                            <ext:NumberField ID="nmbPercentage" runat="server" MinValue="1" MaxValue="100" />
                        </Editor>
                    </ext:Column>
                </Columns>
            </ColumnModel>
            <SelectionModel>
                <ext:CellSelectionModel ID="CellSelectionModel1" runat="server" />
            </SelectionModel>
            <Plugins>
                <ext:CellEditing ID="CellEditing1" runat="server" ClicksToEdit="1" />
            </Plugins>
            <Buttons>
                <ext:Button ID="btnGuardar" runat="server" Text="Guardar" Icon="Disk">
                    <Listeners>
                        <Click Handler="save(#{strBeneficiarios});" />
                    </Listeners>
                </ext:Button>
            </Buttons>
        </ext:GridPanel>    
    </form>      
</body>
</html>