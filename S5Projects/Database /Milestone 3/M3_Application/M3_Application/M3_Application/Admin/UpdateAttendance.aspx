<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateAttendance.aspx.cs" Inherits="M3_Application.UpdateAttendance" %>
<html>
    <head runat="server">
    <link href="StyleSheet1.css" rel="stylesheet" />
    <title></title>
</head><body>
<form runat="server">
      <div class="page-wrapper">
<div class="container">
<h2>Update Attendance</h2>

Employee ID: <asp:TextBox ID="txtEmpID" runat="server" /><br /><br />
Check-in: <asp:TextBox ID="txtIn" runat="server" /><br /><br />
Check-out: <asp:TextBox ID="txtOut" runat="server" /><br /><br />

<asp:Button Text="Update" runat="server" OnClick="UpdateAttendance_Click" /><br /><br />

<asp:Label ID="EMsg" runat="server" ForeColor="Green"></asp:Label>
    </div>
          </div>
</form>
</body></html>
