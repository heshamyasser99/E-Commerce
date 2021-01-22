<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Edit.aspx.cs" Inherits="WebApplication3.Edit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Edit Product</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Vendor.aspx" Font-Size="25pt" ForeColor="Black">Home</asp:HyperLink>
            <br />
            <br />
            <asp:Label ID="Label6" runat="server" Text="Serial Number:"></asp:Label>
            <br />
            <asp:TextBox ID="serial" runat="server" Width="172px" MaxLength="20"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label1" runat="server" Text="Name:"></asp:Label>
            <br />
            <asp:TextBox ID="name" runat="server" Width="172px" MaxLength="20"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" Text="Category:"></asp:Label>
            <br />
            <asp:TextBox ID="category" runat="server" Width="172px" MaxLength="20"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label3" runat="server" Text="Description:"></asp:Label>
            <br />
            <asp:TextBox ID="description" runat="server" Width="172px"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label4" runat="server" Text="Price:"></asp:Label>
            <br />
            <asp:TextBox ID="price" runat="server" Width="172px" MaxLength="20"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label5" runat="server" Text="Color:"></asp:Label>
            <br />
            <asp:TextBox ID="color" runat="server" Width="172px" MaxLength="20"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" Text="EDIT" OnClick="Button1_Click" BackColor="#333333" BorderWidth="0px" Font-Size="15pt" ForeColor="White"/>
            </div>
    </form>
</body>
</html>
