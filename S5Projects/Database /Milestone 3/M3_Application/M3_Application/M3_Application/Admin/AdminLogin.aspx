<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="M3_Application.AdminLogin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="StyleSheet1.css" rel="stylesheet" />
    <title>Admin Login</title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-wrapper">
<div class="container">
       
            <h2>Admin Login Page</h2>
            <asp:Label ID="EMsg" runat="server" ForeColor="Red"></asp:Label><br /><br />

            <asp:Label Text="Admin ID:" runat="server" />
            <br />
            <asp:TextBox ID="txtID" runat="server"></asp:TextBox><br />

            <asp:Label Text="Password:" runat="server" />
            <br />
            <asp:TextBox ID="txtPass" runat="server" TextMode="Password"></asp:TextBox><br />

            <br />

            <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />
        </div>
    </div>
          
    </form>
</body>
</html>
