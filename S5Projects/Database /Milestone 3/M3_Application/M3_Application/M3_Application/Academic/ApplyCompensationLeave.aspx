<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplyCompensationLeave.aspx.cs" Inherits="M3_Application.ApplyCompensationLeave" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Apply Compensation Leave</title>

    <style>
        body {
            background-color: #eef2f3;
            font-family: Arial;
        }

        .container {
            width: 450px;
            margin: 60px auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 12px rgba(0,0,0,0.25);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
        }

        label {
            font-weight: bold;
            color: #444;
        }

        input[type=text] {
            width: 96%;
            padding: 8px;
            border-radius: 6px;
            border: 1px solid #aaa;
            margin-bottom: 10px;
        }

        input[type=text]:focus {
            border-color: #0073e6;
            outline: none;
        }

        .btn {
            background-color: #0c6fb6;
            width: 100%;
            border: none;
            padding: 12px;
            color: white;
            border-radius: 6px;
            font-size: 16px;
            margin-top: 10px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #094f84;
        }

        #lblMessage {
            margin-top: 15px;
            text-align: center;
            font-weight: bold;
            display: block;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">

        <div class="container">

            <h2>Apply Compensation Leave</h2>

            <label>Employee ID</label><br />
            <asp:TextBox ID="id" runat="server"></asp:TextBox>

            <label>Compensation Date</label><br />
            <asp:TextBox ID="compDate" runat="server" placeholder="yyyy-mm-dd"></asp:TextBox>

            <label>Date of Original Workday</label><br />
            <asp:TextBox ID="originalDate" runat="server" placeholder="yyyy-mm-dd"></asp:TextBox>

            <label>Reason</label><br />
            <asp:TextBox ID="reason" runat="server"></asp:TextBox>

            <label>Replacement Employee ID</label><br />
            <asp:TextBox ID="repEmpID" runat="server"></asp:TextBox>

            <asp:Button ID="Apply" runat="server" CssClass="btn" Text="Submit Compensation Request" OnClick="Apply_Click" />

            <asp:Label ID="lblMessage" runat="server"></asp:Label>

        </div>

    </form>
</body>
</html>
