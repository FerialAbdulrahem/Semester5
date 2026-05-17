<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmployeesPerDept.aspx.cs" Inherits="M3_Application.EmployeesPerDept" %>
<html>
    <head runat="server">
    <link href="StyleSheet1.css" rel="stylesheet" />
    <title>Admin Login</title>
</head><body>
<form runat="server">

<h2>Employees Per Department</h2>

    <div class="grid-wrapper">
<asp:GridView ID="gvDept" runat="server"></asp:GridView>
        </div>
 
</form>
</body></html>
