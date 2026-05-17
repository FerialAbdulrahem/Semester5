<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReplaceEmployee.aspx.cs" Inherits="M3_Application.ReplaceEmployee" %>

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
            <h2>Fill in to replace employee</h2>
          
            <br />
            your ID<br />
            <asp:TextBox ID="ID" runat="server"></asp:TextBox>
            <br />
            other employee ID<br />
            <asp:TextBox ID="otherID" runat="server"></asp:TextBox>
            <br />
            start date<br />
            <asp:TextBox ID="start" runat="server"></asp:TextBox>
            <br />
            end date
            <br />
            <asp:TextBox ID="end" runat="server"></asp:TextBox>
            <br />
            <br />
                               <asp:Button ID="replace" runat="server" OnClick="Button1_Click" 
    Text="Replace Employee" />
<br />
<asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        </div>
    </div>
             </div>
    </form>
</body>
</html>
