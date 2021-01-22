<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerRegister.aspx.cs" Inherits="Milestone3.CustomerRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <h1>
        customer register
    </h1>
        <div>
            Username</div>
        <p>
            <asp:TextBox ID="CustUserReg" runat="server" OnTextChanged="TextBox1_TextChanged"></asp:TextBox>
        </p>
        <p>
            First Name</p>
        <p>
            <asp:TextBox ID="FNameCustReg" runat="server"></asp:TextBox>
        </p>
        <p>
            Last Name</p>
        <p>
            <asp:TextBox ID="LNameCustReg" runat="server"></asp:TextBox>
        </p>
        <p>
            Password</p>
        <asp:TextBox ID="CustPassReg" runat="server"></asp:TextBox>
        <br />
        Email<br />
        <p>
            <asp:TextBox ID="CustMailReg" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="Button1" runat="server" OnClick="CustReg" Text="REGISTER" />
        </p>
        <p>
            <asp:Button ID="back" runat="server" OnClick="back_Click" Text="To Main Page" />
        </p>
        <p>
            &nbsp;</p>
    </form>
</body>
</html>
