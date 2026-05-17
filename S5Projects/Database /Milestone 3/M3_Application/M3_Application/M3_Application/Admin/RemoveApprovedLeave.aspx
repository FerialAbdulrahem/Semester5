<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RemoveApprovedLeave.aspx.cs" Inherits="M3_Application.RemoveApprovedLeave" %>

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
            Please enter ID:<br />
            <asp:TextBox ID="employee_id" runat="server"></asp:TextBox>
            <br />
           <asp:Button ID="remove" runat="server" OnClick="Button1_Click" 
                Text="Remove Approved Leaves" />
            <br />
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        </div>
    </div>
            </div>
    </form>
</body>
</html>
