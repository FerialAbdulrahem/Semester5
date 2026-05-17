<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HR_Approve_Annual_Acc.aspx.cs" Inherits="M3_Application.HR_Approve_Annual_Acc" %>

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

    <h2>Annual / Accidental Approval</h2>

    <label>Request ID</label>
    <asp:TextBox ID="txtRequestID" runat="server"></asp:TextBox>

    <asp:Button ID="btnProcess" runat="server" Text="Process" 
                OnClick="btnProcess_Click" CssClass="btn" />

    <asp:Label ID="lblMessage" runat="server"></asp:Label>
                    </div>
<div class="grid-wrapper">
    <asp:GridView ID="gvResult" runat="server" AutoGenerateColumns="True"
                  CssClass="gridview" />
     
 </div>
</div>
    </form>
</body>
</html>
