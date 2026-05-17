<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HR_Home.aspx.cs" Inherits="M3_Application.HR_Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="StyleSheet1.css" rel="stylesheet" />
    <title>HR Dashboard</title>
</head>

<body>

<div class="container">

    <h2>HR Dashboard</h2>

    <form id="form1" runat="server">

        <asp:Button ID="btnA" runat="server" Text="Approve Annual & Accidental"
            CssClass="btn" PostBackUrl="HR_Approve_Annual_Acc.aspx" />

        <asp:Button ID="btnU" runat="server" Text="Approve Unpaid"
            CssClass="btn" PostBackUrl="HR_Approve_Unpaid.aspx" />

        <asp:Button ID="btnC" runat="server" Text="Approve Compensation"
            CssClass="btn" PostBackUrl="HR_Approve_Comp.aspx" />

        <asp:Button ID="btnH" runat="server" Text="Deduction: Missing Hours"
            CssClass="btn" PostBackUrl="HR_Deduction_Hours.aspx" />

        <asp:Button ID="btnD" runat="server" Text="Deduction: Missing Days"
            CssClass="btn" PostBackUrl="HR_Deduction_Days.aspx" />

        <asp:Button ID="btnUU" runat="server" Text="Deduction: Unpaid Leave"
            CssClass="btn" PostBackUrl="HR_Deduction_Unpaid.aspx" />

        <asp:Button ID="btnP" runat="server" Text="Generate Payroll"
            CssClass="btn" PostBackUrl="HR_Generate_Payroll.aspx" />

    </form>

</div>

</body>
</html>
