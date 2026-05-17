<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewWinterPerformance.aspx.cs" Inherits="M3_Application.ViewWinterPerformance" %>

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
            <h2 >Press to view all winter performances:</h2>
                    <asp:Button ID="view" runat="server" OnClick="Button1_Click" 
    Text="View Winter Performance" />
<br />
<asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        
    </div>
           
                <div id="gridContainer" runat="server" class="grid-wrapper">
                    <!-- GridView will be added here programmatically -->
                </div>
            </div>
           
    </form>
</body>
</html>
