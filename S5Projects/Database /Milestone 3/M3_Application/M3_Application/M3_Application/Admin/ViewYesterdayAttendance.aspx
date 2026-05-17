<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewYesterdayAttendance.aspx.cs" Inherits="M3_Application.ViewYesterdayAttendance" %>

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
            <h2>Press to view all yesterday attendance</h2><br />
    <asp:Button ID="replace" runat="server" OnClick="Button1_Click" 
    Text="View yesterday attendance" />
<br />
<asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        </div>
    </div>
            <div id="gridContainer" runat="server" class="grid-wrapper">
    <!-- GridView will be added here programmatically -->
</div>
            </div>
    </form>
</body>
</html>
