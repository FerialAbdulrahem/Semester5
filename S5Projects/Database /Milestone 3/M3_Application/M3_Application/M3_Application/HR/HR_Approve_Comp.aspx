<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HR_Approve_Comp.aspx.cs" Inherits="M3_Application.HR_Approve_Comp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="StyleSheet1.css" rel="stylesheet" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
         <div class="page-wrapper">
                     <div class="nav-buttons">
    <asp:Button ID="btnHome" runat="server" Text="Dashboard" 
                OnClick="btnHome_Click" CssClass="nav-btn" />
    <asp:Button ID="btnLogout" runat="server" Text="Logout" 
                OnClick="btnLogout_Click" CssClass="nav-btn logout-btn" />
</div>
        <div class="container">

    <h2>Compensation Approval</h2>
        Request ID:<br />
<asp:TextBox ID="txtRequestID" runat="server"></asp:TextBox><br /><br />

<asp:Button ID="btnProcess" runat="server" Text="Process Request" OnClick="btnProcess_Click" /><br /><br />

<asp:Label ID="lblMessage" runat="server"></asp:Label><br /><br />
            </div>
<div class="grid-wrapper">
<asp:GridView ID="gvResult" runat="server" AutoGenerateColumns="True" />
</div>
             </div>
    </form>
</body>
</html>
