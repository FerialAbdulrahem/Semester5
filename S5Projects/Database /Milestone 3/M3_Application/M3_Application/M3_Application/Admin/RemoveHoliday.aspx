<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RemoveHoliday.aspx.cs" Inherits="M3_Application.RemoveHoliday" %>

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
                <h2>Press Button to remove attendance in holiday</h2>
           <asp:Button ID="removeH" runat="server" OnClick="Button1_Click" 
      Text="Remove Attendance Holiday" />
  <br />
  <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
        </div>
    </div>
            </div>
    </form>
</body>
</html>
