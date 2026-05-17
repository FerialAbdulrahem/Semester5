<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplyAccidentalLeave.aspx.cs" Inherits="M3_Application.ApplyAccidentalLeave"
%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Apply Accidental Leave</title>

    <style>
        body {
            background-color: #f1f3f8;
            font-family: Arial, sans-serif;
        }

        .container {
            width: 470px;
            margin: 110px auto;
            background: white;
            padding: 35px 40px;
            border-radius: 12px;
            box-shadow: 0px 4px 20px rgba(0,0,0,0.2);
        }

        h2 {
            margin-bottom: 18px;
            color: #003366;
            text-align: center;
        }

        label {
            font-weight: bold;
            margin-top: 15px;
            display: block;
            color: #333;
        }

        .input {
            width: 95%;
            padding: 8px;
            margin-top: 6px;
            border-radius: 6px;
            border: 1px solid #aaa;
        }

        #btnApply {
            width: 70%;
            background-color: #007bff;
            border: none;
            padding: 10px;
            border-radius: 6px;
            color: white;
            font-weight: bold;
            cursor: pointer;
            margin-top: 26px;
            transition: 0.3s;
            font-size: 16px;
        }

        #btnApply:hover {
            background-color: #0056b3;
        }

        .note {
            font-size: 14px;
            text-align: center;
            margin-bottom: 14px;
            color: #444;
        }

    </style>

</head>
<body>
    <form id="form1" runat="server">

        <div class="container">
            <h2>Accidental Leave Request</h2>
            <p class="note">Kindly fill in your leave details below</p>

            <label>Employee ID</label>
            <asp:TextBox ID="id" runat="server" CssClass="input"></asp:TextBox>

            <label>Start Date</label>
            <asp:TextBox ID="StartDate" runat="server" CssClass="input" placeholder="yyyy-mm-dd"></asp:TextBox>

            <label>End Date</label>
            <asp:TextBox ID="EndDate" runat="server" CssClass="input" placeholder="yyyy-mm-dd"></asp:TextBox>

            <asp:Button ID="btnApply" runat="server" Text="Apply For Leave" OnClick="Apply_Click" />
        </div>

    </form>
</body>
</html>
