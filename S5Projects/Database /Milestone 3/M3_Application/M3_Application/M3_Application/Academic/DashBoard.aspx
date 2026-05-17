<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DashBoard.aspx.cs" Inherits="M3_Application.DashBoard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="StyleSheet1.css" rel="stylesheet" />
    <title></title>
    <style>.page-wrapper {
    margin-top: 230px; /* Push content down below fixed nav */
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 100vh;
    padding: 20px;
}</style>
</head>
<body>

    <form id="form1" runat="server">
                <div class="page-wrapper">
<div class="container">
        <div>
            <h2>Academic DashBoard</h2>
         
        </div>
        <asp:Button ID="Performace" runat="server"  OnClick="viewmyperformance" Text="Performance" />
        <p>
         <asp:Button ID="Attendance" runat="server"  OnClick="viewmyattendance" Text="Attendance"/>
        </p>
        <asp:Button ID="Payroll" runat="server" OnClick="payroll" Text="Payroll" />
        <p>
            <asp:Button ID="Deductions" runat="server" OnClick="deductions" Text="Deductions" />
        </p>
        <asp:Button ID="Annual_Leave" runat="server" OnClick="annualleave" Text="Annual Leave" />
        <p>
            <asp:Button ID="Status" runat="server" Text="Status Leaves" OnClick="Status_Click" />
        </p> 
  <asp:Button ID="Accidental_Leave" runat="server"  Text="Apply Accidental Leave" OnClick="ApplyAccidentalLeave" />  
 </p>
 <asp:Button ID="Compensation_Leave" runat="server"  Text="Apply Compensation Leave" OnClick="ApplyCompensationLeave" />
 </p>
  <asp:Button ID="Medical_Leave" runat="server" Text="Apply Medical Leave" OnClick="ApplyMedicalLeave" />
 </p>
  <asp:Button ID="Unpaid_Leave" runat="server"  Text="Apply Unpaid Leave" OnClick="ApplyUnpaidLeave" />
 </p>
  <asp:Button ID="Approve_Annual" runat="server"  Text="Approve Annual" OnClick="ApproveAnnual" />
 </p>
  <asp:Button ID="Approve_Unpaid" runat="server"  Text="Approve Unpaid" OnClick="ApproveUnpaid" />
 </p>
  <asp:Button ID="Evaluate_Employee" runat="server"  Text="Evaluate Employee" OnClick="EvaluateEmployee" />
    </div>
                    </div>
    </form>
</body>
</html>
