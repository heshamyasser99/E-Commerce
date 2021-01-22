<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="userLogin.aspx.cs" Inherits="Milestone3.userLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <h1>
        LOGIN
    </h1>
        <p>
            Username</p>
        <asp:TextBox ID="UserLog" runat="server" MaxLength="20"></asp:TextBox>
        <br />
        <br />
        Password<br />
        <br />
        <asp:TextBox ID="UserPass" runat="server" MaxLength="20"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="LOG" runat="server" OnClick="LOGIN" Text="Log In" />
    </form>
</body>
</html>
