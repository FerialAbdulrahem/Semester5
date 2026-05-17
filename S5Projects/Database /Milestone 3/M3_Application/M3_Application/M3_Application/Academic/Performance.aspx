<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Performance.aspx.cs" Inherits="M3_Application.Performance" %>

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
        <asp:Label ID="Label1" runat="server" Text="Performance"></asp:Label>
        <br />
        <div>
            <br />
            Semester</div>
        <p>
            <asp:TextBox ID="Semester" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="View" runat="server" AutoGenerateColumns="true" Height="55px" OnClick="showperf" Text="View" Width="61px" />
            </div>
            <div class="grid-wrapper">
            <asp:GridView ID="Performanceshow" runat="server">
            </asp:GridView>
                </div>
            </div>
        </p>
    </form>
</body>
</html>
