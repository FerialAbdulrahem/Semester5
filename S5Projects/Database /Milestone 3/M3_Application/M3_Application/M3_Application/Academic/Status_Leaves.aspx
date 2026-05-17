<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Status_Leaves.aspx.cs" Inherits="M3_Application.Status_Leaves" %>

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
            <asp:Label ID="Label1" runat="server" Text="My Leave Status"></asp:Label>
        </div>
    </div>
        <div class="grid-wrapper">
        <asp:GridView ID="Statusleaves" runat="server" AutoGenerateColumns="true">
        </asp:GridView>
            </div>
            </div>
    </form>
</body>
</html>
