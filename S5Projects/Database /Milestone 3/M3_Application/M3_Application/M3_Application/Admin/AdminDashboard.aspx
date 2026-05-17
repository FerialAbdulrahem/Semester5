<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="M3_Application.AdminDashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="StyleSheet1.css" rel="stylesheet" />
    <title>Admin Dashboard</title>
    <style>
        /* Override just for this page */
        .top-nav {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1000;
            display: flex;
            gap: 10px;
        }
        
        /* Navigation button styles */
        .nav-btn {
            padding: 8px 16px;
            background: #4a76a8;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            transition: 0.2s;
        }
        
        .nav-btn:hover {
            background: #3a5c82;
        }
        
        .logout-btn {
            background: #d9534f;
        }
        
        .logout-btn:hover {
            background: #c9302c;
        }
        
        /* Ensure page content doesn't overlap */
        .page-wrapper {
            margin-top: 150px; /* Push content down below fixed nav */
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 20px;
        }
        
        /* Admin container styles */
        .admin-container {
            width: 400px;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 12px rgba(0,0,0,0.15);
            text-align: center;
            margin-bottom: 30px;
        }
        
        .admin-container h2 {
            margin-bottom: 20px;
        }
        
        .admin-btn {
            width: 100%;
            padding: 12px;
            margin-bottom: 10px;
            background: #4a76a8;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 15px;
            cursor: pointer;
            transition: 0.2s;
            display: block;
            box-sizing: border-box;
        }
        
        .admin-btn:hover {
            background: #3a5c82;
        }
        
        /* Make sure body has no margin at top */
        body {
            margin: 0;
            padding: 0;
            background: #f2f2f2;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navigation buttons - FIXED: Added the buttons! -->
        
        
        <div class="page-wrapper">
            <div class="admin-container">
                <h2>Admin Dashboard</h2>
                
                <asp:Button runat="server" Text="View Employees" CssClass="admin-btn" OnClick="btnEmp_Click" />
                <asp:Button runat="server" Text="Employees Per Dept" CssClass="admin-btn" OnClick="btnDept_Click" />
                <asp:Button runat="server" Text="Rejected Medicals" CssClass="admin-btn" OnClick="btnRej_Click" />
                <asp:Button runat="server" Text="Update Attendance" CssClass="admin-btn" OnClick="btnAtt_Click" />
                <asp:Button runat="server" Text="Remove Deductions" CssClass="admin-btn" OnClick="btnDed_Click" />
                <asp:Button runat="server" Text="Add Holiday" CssClass="admin-btn" OnClick="btnHol_Click" />
                <asp:Button runat="server" Text="Initiate Attendance" CssClass="admin-btn" OnClick="btnInit_Click" />
                <asp:Button runat="server" Text="Remove Approved Leave" CssClass="admin-btn" OnClick="btn1_Click" />
                <asp:Button runat="server" Text="Remove Day Off" CssClass="admin-btn" OnClick="btn2_Click" />
                <asp:Button runat="server" Text="Remove Holiday" CssClass="admin-btn" OnClick="btn3_Click" />
                <asp:Button runat="server" Text="Replace Employee" CssClass="admin-btn" OnClick="btn4_Click" />
                <asp:Button runat="server" Text="Update Employment Status" CssClass="admin-btn" OnClick="btn5_Click" />
                <asp:Button runat="server" Text="View Winter performance" CssClass="admin-btn" OnClick="btn6_Click" />
                <asp:Button runat="server" Text="View Yesterday Attendance" CssClass="admin-btn" OnClick="btn7_Click" />
                
                <!-- Logout button at bottom -->
                <asp:Button runat="server" Text="Logout" CssClass="admin-btn" OnClick="btnLogout_Click" 
                    style="background:#d9534f; margin-top:10px;" />
            </div>
        </div>
    </form>
</body>
</html>