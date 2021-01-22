<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="Milestone3.Admin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <h1>
        Admin Page
    </h1>
    <form id="form1" runat="server">
        <div>
            Add Telephone Number</div>
        <asp:TextBox ID="Atel" runat="server"></asp:TextBox>
        <p>
            <asp:Button ID="AddAT" runat="server" OnClick="AddAT_Click" Text="ADD NUMBER" />
        </p>
    </form>
</body>
</html>
