<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Payroll.aspx.cs" Inherits="M3_Application.Payroll" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="StyleSheet1.css" rel="stylesheet" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-wrapper">
        <div class="container">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Payroll"></asp:Label>
        </div>
</div>
        <div class="grid-wrapper">
        <asp:GridView ID="ViewPayroll" runat="server" AutoGenerateColumns="true">
        </asp:GridView>
            </div>
    </div>
    </form>
</body>
</html>
