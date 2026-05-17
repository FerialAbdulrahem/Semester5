<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateEmploymentStatus.aspx.cs" Inherits="M3_Application.UpdateEmploymentStatus" %>

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
            <h2>Please enter your ID</h2>
            <asp:TextBox ID="ID" runat="server"></asp:TextBox>
            <br />
         <asp:Button ID="update" runat="server" OnClick="Button1_Click" 
    Text="Update Status" />
<br />
<asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        </div>
    </div>
              </div>
    </form>
</body>
</html>
