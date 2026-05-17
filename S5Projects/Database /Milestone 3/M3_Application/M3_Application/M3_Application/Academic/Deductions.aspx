<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Deductions.aspx.cs" Inherits="M3_Application.Deductions" %>

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
            <asp:Label ID="Label1" runat="server" Text="Deductions"></asp:Label>
        </div>
        <asp:DropDownList ID="Months" runat="server">
        </asp:DropDownList>
        <p>
            <asp:Button ID="Button1" runat="server" Text="View" OnClick="Button1_Click" style="height: 35px" />
        </p>
    </div>
<div class="grid-wrapper">
        <asp:GridView ID="ViewDeductions" runat="server" AutoGenerateColumns="true"></asp:GridView>
    </div>
                    </div>
    </form>
</body>
</html>
