<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HR_Login.aspx.cs" Inherits="M3_Application.HR_Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="StyleSheet1.css" rel="stylesheet" />

    <title></title>
</head>
<body>
    <form id="form1" runat="server">
            <div class="container">

    <h2>HR Login Page</h2>

    <label>Employee ID: </label>
    <asp:TextBox ID="txtID" runat="server"></asp:TextBox>

    <label>Password: </label>
    <asp:TextBox ID="txtpassword" runat="server" TextMode="Password"></asp:TextBox>

    <asp:Button ID="btnLogin" runat="server" Text="Log In" 
                OnClick="btnLogin_Click" CssClass="btn" />

    <asp:Label ID="lblMessage" runat="server"></asp:Label>

    <asp:GridView ID="gvResult" runat="server" AutoGenerateColumns="True"
                  CssClass="gridview" />

</div>
    </form>
    
</body>
</html>
