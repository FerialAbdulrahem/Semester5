<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Apply_for_AnnualLeave.aspx.cs" Inherits="M3_Application.Apply_for_AnnualLeave" %>

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
            <asp:Label ID="Label1" runat="server" Text="Submit Annual Leave"></asp:Label>
            <br />
        </div>
        <asp:Label ID="Label2" runat="server" Text="Please Enter Replacement ID"></asp:Label>
        <p>
            <asp:TextBox ID="ReplacementID" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="Label5" runat="server" Text="Start Date"></asp:Label>
        </p>
        <asp:TextBox ID="Start" runat="server" TextMode="Date"></asp:TextBox>
        <p>
            <asp:Label ID="Label6" runat="server" Text="End Date"></asp:Label>
        </p>
        <asp:TextBox ID="End" runat="server" TextMode="Date"></asp:TextBox>
        <p>
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" />
        </p>
        <asp:Label ID="Error" runat="server"  ForeColor="Red"    Visible="False"></asp:Label>
    </div>
            </div>
    </form>
</body>
</html>
