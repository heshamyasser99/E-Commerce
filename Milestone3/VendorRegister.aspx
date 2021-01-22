<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VendorRegister.aspx.cs" Inherits="Milestone3.VendorRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <h1>
        Vendor Register
    </h1>
    <form id="form1" runat="server">
        <p>
            Username</p>
        <p>
            <asp:TextBox ID="VRUser" runat="server"></asp:TextBox>
    </p>
        <div>
            First Name</div>
        <asp:TextBox ID="VRFName" runat="server"></asp:TextBox>
        <p>
            Last Name</p>
        <p>
            <asp:TextBox ID="VRLName" runat="server"></asp:TextBox>
        </p>
        <p>
            Password</p>
        <p>
            <asp:TextBox ID="VRPass" runat="server"></asp:TextBox>
        </p>
        <p>
            Email</p>
        <p>
            <asp:TextBox ID="VREmail" runat="server"></asp:TextBox>
        </p>
        <p>
            Company Name</p>
        <p>
            <asp:TextBox ID="VRComp" runat="server"></asp:TextBox>
        </p>
        <p>
            Bank Account Number</p>
        <p>
            <asp:TextBox ID="VRBank" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="REGISTER" runat="server" OnClick="VendorReg" Text="REGISTER" />
        </p>
        <p>
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click1" Text="To Main Page" />
        </p>
    </form>
</body>
</html>
