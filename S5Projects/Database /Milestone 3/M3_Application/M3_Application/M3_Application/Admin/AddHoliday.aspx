<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddHoliday.aspx.cs" Inherits="M3_Application.AddHoliday" %>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
    <link href="StyleSheet1.css" rel="stylesheet" />
    <title></title>
</head>
    <body>
<form runat="server">
    <div class="page-wrapper">
<div class="container">
<h2>Add Holiday</h2>

Name: <asp:TextBox ID="txtName" runat="server" /><br /><br />
From (yyyy-mm-dd): <asp:TextBox ID="txtFrom" runat="server" /><br /><br />
To (yyyy-mm-dd): <asp:TextBox ID="txtTo" runat="server" /><br /><br />

<asp:Button Text="Add Holiday" runat="server" OnClick="Add_Click" /><br /><br />
<asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
    </div>
        </div>
</form>
</body></html>