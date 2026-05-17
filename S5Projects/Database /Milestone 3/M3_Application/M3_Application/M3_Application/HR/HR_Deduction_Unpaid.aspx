<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HR_Deduction_Unpaid.aspx.cs" Inherits="M3_Application.HR_Deduction_Unpaid" %>

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

<h2>Deduction Due To Unpaid Leave</h2>
        Employee ID:<br />
<asp:TextBox ID="txtEmployeeID" runat="server"></asp:TextBox><br /><br />

<asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" /><br /><br />
<asp:Label ID="lblMessage" runat="server"></asp:Label>
                                </div>
<div class="grid-wrapper">
<asp:GridView ID="gvResult" runat="server" AutoGenerateColumns="True" />
                </div>
             </div>
    </form>
</body>
</html>
