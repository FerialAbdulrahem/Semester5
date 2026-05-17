<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApproveAnnual.aspx.cs" Inherits="M3_Application.ApproveAnnual" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Approve Annual Leave</title>

<style>
    body {
        background-color: #f5f5f5;
        font-family: Arial, sans-serif;
    }

    .container-card {
        width: 450px;
        margin: 120px auto;
        background-color: white;
        border-radius: 12px;
        padding: 25px 30px;
        box-shadow: 0px 4px 16px rgba(0,0,0,0.2);
        text-align: center;
    }

    .label {
        font-weight: bold;
        display: block;
        margin-top: 15px;
        text-align: left;
    }

    .tb {
        width: 95%;
        padding: 8px;
        border-radius: 6px;
        border: 1px solid #aaa;
        margin-top: 5px;
    }

    .btn-submit {
        width: 60%;
        padding: 12px;
        margin-top: 20px;
        background-color: #0275d8;
        color: white;
        border: none;
        border-radius: 7px;
        font-size: 17px;
        cursor: pointer;
        transition: 0.2s;
    }

    .btn-submit:hover {
        background-color: #025aa5;
    }

    .message {
        margin-top: 15px;
        font-weight: bold;
        display: block;
    }
</style>
</head>

<body>
<form id="form1" runat="server">

    <div class="container-card">

        <h2>Approve Annual Leave</h2>

        <label class="label">Request ID</label>
        <asp:TextBox ID="TextBox1" CssClass="tb" runat="server"></asp:TextBox>

        <label class="label">UpperBoard ID</label>
        <asp:TextBox ID="TextBox2" CssClass="tb" runat="server"></asp:TextBox>

        <label class="label">Replacement Employee ID</label>
        <asp:TextBox ID="TextBox3" CssClass="tb" runat="server"></asp:TextBox>

        <asp:Button ID="appr" runat="server" CssClass="btn-submit" Text="Submit Decision"
            OnClick="Button1_Click" />

        <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>

    </div>

</form>
</body>
</html>
