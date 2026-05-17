<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InitiateAttendance.aspx.cs" Inherits="M3_Application.InitiateAttendance" %>
<html>
    <head runat="server">
    <link href="StyleSheet1.css" rel="stylesheet" />
    <title></title>
</head><body>
<form runat="server">


<div class="page-wrapper">
    
<div class="container">
    <h2>Initiate Attendance</h2>
<asp:Button Text="Initiate" runat="server" OnClick="Init_Click" /><br /><br />
<asp:Label ID="lblMsg" runat="server" ForeColor="Green"></asp:Label>
    </div>
    </div>
</form>
</body></html>
