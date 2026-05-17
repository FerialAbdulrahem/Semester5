<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EvaluateEmployee.aspx.cs" Inherits="M3_Application.EvaluateEmployee" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Evaluate Employee</title>

    <style>
        body {
            background-color: #eef2f7;
            font-family: Arial, sans-serif;
        }

        .card {
            width: 450px;
            margin: 120px auto;
            background: white;
            padding: 30px 35px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0px 5px 20px rgba(0,0,0,0.2);
        }

        h2 {
            margin-bottom: 20px;
            color: #003366;
        }

        .label {
            text-align: left;
            margin-top: 14px;
            font-weight: bold;
            display: block;
            color: #333;
        }

        .tb {
            width: 95%;
            padding: 8px;
            border-radius: 6px;
            border: 1px solid #aaa;
            margin-top: 5px;
        }

        .btn-eval {
            width: 70%;
            padding: 11px;
            margin-top: 22px;
            background-color: #0066cc;
            color: white;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            transition: .2s;
        }

        .btn-eval:hover {
            background-color: #004f99;
        }

        .msg {
            margin-top: 15px;
            font-size: 15px;
            font-weight: bold;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">

        <div class="card">
            <h2>Evaluate Employee</h2>

            <label class="label">Employee ID</label>
            <asp:TextBox ID="TextBox1" CssClass="tb" runat="server"></asp:TextBox>

            <label class="label">Rating</label>
            <asp:TextBox ID="TextBox2" CssClass="tb" runat="server"></asp:TextBox>

            <label class="label">Comment</label>
            <asp:TextBox ID="TextBox3" CssClass="tb" runat="server"></asp:TextBox>

            <label class="label">Semester (e.g. F23, S23)</label>
            <asp:TextBox ID="TextBox4" CssClass="tb" runat="server"></asp:TextBox>

            <asp:Button ID="eval" runat="server" Text="Submit Evaluation"
                CssClass="btn-eval" OnClick="Button1_Click" />

            <asp:Label ID="lblMessage" runat="server" CssClass="msg"></asp:Label>
        </div>

    </form>
</body>
</html>
