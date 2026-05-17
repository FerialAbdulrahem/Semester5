<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Academic_Login.aspx.cs" Inherits="M3_Application.Academic_Login" %>

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
            <h2>Academic Login Page</h2>
            ID:<br />
            <asp:TextBox ID="ID" runat="server"></asp:TextBox>
            <br />
            Password:<br />
        <asp:TextBox ID="Password" runat="server"></asp:TextBox>
        <br />
            <asp:Button ID="Login" runat="server" OnClick="login" Text="Log In" />
        <br />
      </div>
            </div>
        <asp:Label ID="Error" runat="server" ForeColor="Red" Visible="False"></asp:Label>
      
    </form>
</body>
</html>
