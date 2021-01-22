<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Vendor.aspx.cs" Inherits="WebApplication3.Vendor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Vendor Home</title>
    <style type="text/css">        
        body {
            padding:0;
            margin:0;
            border: none;
        }
        div{
            background-color:teal;
            border:none;
            font-size: 30px;
            padding:15px;
            color:white;
            text-decoration:none;
        }
        h1{
            font-size:45px;
            font-family: Arial;
            font-weight:bold;
            background-color:white;
            color:coral;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1 align="center">Vendor Home</h1>
            <asp:HyperLink ID="HyperLink1" runat="server" ForeColor="White" NavigateUrl="~/PostProduct.aspx">Post a Product</asp:HyperLink>
            <br />
            <asp:HyperLink ID="HyperLink2" runat="server" ForeColor="White" NavigateUrl="~/ViewProducts.aspx">View my Products</asp:HyperLink>
            <br />
            <asp:HyperLink ID="HyperLink3" runat="server" ForeColor="White" NavigateUrl="~/Edit.aspx">Edit a Product</asp:HyperLink>
            <br />
            <asp:HyperLink ID="HyperLink4" runat="server" ForeColor="White" NavigateUrl="~/OffersPage.aspx">Offer Page</asp:HyperLink>
        </div>
        <p>
            Add telephone:</p>
        <p>
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        </p>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" />
    </form>
</body>
</html>
