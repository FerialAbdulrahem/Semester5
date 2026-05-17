<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplyMedicalLeave.aspx.cs" Inherits="M3_Application.ApplyMedicalLeave" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Apply Medical Leave</title>

    <style>
        body {
            background-color: #f1f3f8;
            font-family: Arial, sans-serif;
        }

        .container {
            width: 500px;
            margin: 60px auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 5px 20px rgba(0,0,0,0.2);
        }

        h2 {
            text-align: center;
            color: #003366;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-top: 12px;
            font-weight: bold;
            color: #333;
        }

        .inputBox {
            width: 95%;
            padding: 8px;
            margin-top: 5px;
            border-radius: 6px;
            border: 1px solid #aaa;
        }

        .inputBox:focus {
            border-color: #0073e6;
            outline: none;
        }

        #Apply {
            width: 100%;
            margin-top: 20px;
            padding: 12px;
            background-color: #007bff;
            color: white;
            font-size: 16px;
            font-weight: bold;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            transition: 0.3s ease;
        }

        #Apply:hover {
            background-color: #0056b3;
        }

        #lblMessage {
            display: block;
            text-align: center;
            margin-top: 15px;
            font-weight: bold;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Apply Medical Leave</h2>

            <label>Employee ID</label>
            <asp:TextBox ID="id" runat="server" CssClass="inputBox"></asp:TextBox>

            <label>Start Date</label>
            <asp:TextBox ID="StartDate" runat="server" CssClass="inputBox" placeholder="yyyy-mm-dd"></asp:TextBox>

            <label>End Date</label>
            <asp:TextBox ID="EndDate" runat="server" CssClass="inputBox" placeholder="yyyy-mm-dd"></asp:TextBox>

            <label>Medical Type</label>
            <asp:TextBox ID="type" runat="server" CssClass="inputBox"></asp:TextBox>

            <label>Insurance Status</label>
            <asp:TextBox ID="status" runat="server" CssClass="inputBox"></asp:TextBox>

            <label>Disability Details</label>
            <asp:TextBox ID="details" runat="server" TextMode="MultiLine" Rows="3" CssClass="inputBox"></asp:TextBox>

            <label>Document Description</label>
            <asp:TextBox ID="desc" runat="server" CssClass="inputBox"></asp:TextBox>

            <label>File Name</label>
            <asp:TextBox ID="file" runat="server" CssClass="inputBox"></asp:TextBox>

            <asp:Button ID="Apply" runat="server" Text="Submit Leave" CssClass="btn" OnClick="Apply_Click" />

            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        </div>
    </form>
</body>
</html>
