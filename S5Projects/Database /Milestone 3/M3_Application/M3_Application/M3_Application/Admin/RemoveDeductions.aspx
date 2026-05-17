<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RemoveDeductions.aspx.cs" Inherits="M3_Application.RemoveDeductions" %>
<html>
    <head runat="server">
    <link href="StyleSheet1.css" rel="stylesheet" />
    <title></title>
</head><body>
<form runat="server">

     <div class="page-wrapper">
<div class="container">
<h2>Remove All Deductions</h2>

<asp:Button Text="Remove" runat="server" OnClick="Remove_Click" /><br /><br />
<asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
    </div>
         </div>
</form>
</body></html>
