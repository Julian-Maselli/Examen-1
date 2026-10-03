<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="System.IO" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Reporte ISSD</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h3>Ranking de Canciones con más cobros</h3>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConexionDB %>" 
                SelectCommand="SELECT c.nombre AS Cancion, COUNT(ci.idInterprete) AS CantidadInterpretes, SUM(ci.montoCobrado) AS MontoTotal FROM Canciones c JOIN CobrosInterpretaciones ci ON c.id = ci.idCancion GROUP BY c.id, c.nombre ORDER BY SUM(ci.montoCobrado) DESC">
            </asp:SqlDataSource>

            <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" 
                DataSourceID="SqlDataSource1" AutoGenerateColumns="False">
                <AlternatingRowStyle BackColor="White" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <RowStyle BackColor="#EFF3FB" />
                <Columns>
                    <asp:BoundField DataField="Cancion" HeaderText="Canción" />
                    <asp:BoundField DataField="CantidadInterpretes" HeaderText="Cant. Intérpretes" />
                    <asp:BoundField DataField="MontoTotal" HeaderText="Monto Total Cobrado" DataFormatString="{0:C}" />
                </Columns>
            </asp:GridView>
            
            <br />
            <asp:Button ID="Button1" runat="server" Text="Registrar Log de Consulta" OnClick="Button1_Click" />
            <br /><br />
            <asp:Label ID="Label1" runat="server"></asp:Label>
        </div>
    </form>
</body>
</html>

<script runat="server">
    protected void Button1_Click(object sender, EventArgs e)
    {
        StreamWriter arch = new StreamWriter(this.Server.MapPath(".") + "/log_operaciones.txt", true);
        arch.WriteLine(DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + " - Consulta: Ranking de canciones con mas cobros.");
        arch.Close();

        Label1.Text = "Log registrado correctamente.";
    }
</script>