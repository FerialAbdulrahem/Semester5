<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApproveUnpaid.aspx.cs" Inherits="M3_Application.ApproveUnpaid" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Approve Unpaid Leave</title>

    <style>
        body {
            background-color: #f5f7fa;
            font-family: Arial, sans-serif;
        }

        .card {
            width: 400px;
            margin: 120px auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 3px 12px rgba(0,0,0,0.2);
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
            padding: 7px;
            margin-top: 3px;
            border-radius: 5px;
            border: 1px solid #aaa;
        }

        .btn {
            margin-top: 20px;
            padding: 10px 16px;
            width: 160px;
            border: none;
            border-radius: 5px;
            font-size: 15px;
            cursor: pointer;
        }

        .btn-approve {
            background-color: #388e3c;
            color: white;
        }

        .btn-approve:hover {
            background-color: #2e7031;
        }

        .message {
            margin-top: 15px;
            font-weight: bold;
        }

    </style>

</head>
<body>
    <form id="form1" runat="server">

        <div class="card">
            <h2>Approve Unpaid Leave</h2>

            <label class="label">Request ID</label>
            <asp:TextBox ID="TextBox2" CssClass="tb" runat="server"></asp:TextBox>

            <label class="label">UpperBoard ID</label>
            <asp:TextBox ID="TextBox3" CssClass="tb" runat="server"></asp:TextBox>

            <asp:Button ID="app" runat="server" CssClass="btn btn-approve"
                        Text="Submit Decision" OnClick="Button1_Click" />

            <asp:Label ID="lblMessage" runat="server" CssClass="message"
                       ForeColor="Red"></asp:Label>
        </div>

    </form>
</body>
</html>
