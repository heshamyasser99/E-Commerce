<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OffersPage.aspx.cs" Inherits="WebApplication3.OffersPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Offer Manager</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Vendor.aspx" Font-Size="25pt" ForeColor="Black">Home</asp:HyperLink>
            <br />
            <br />
            <asp:Label Text="Create Offer" runat="server" Font-Size="16pt" />
            <br />
            <br />
            <asp:Label ID="Label1" runat="server" Text="Offer Amount:"></asp:Label>
            <br />
            <asp:TextBox ID="amount" runat="server" Width="172px" MaxLength="20"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label2" runat="server" Text="Expiry Date:"></asp:Label>
            <br />
            <asp:TextBox ID="expiryDate" runat="server" Width="172px" MaxLength="20"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="CreateOfferBtn" runat="server" Text="Create Offer" BackColor="#333333" BorderWidth="0px" ForeColor="White" OnClick="CreateOfferBtn_Click" Font-Size="12pt" />
            <hr />
            <asp:Label Text="Add offer to Product" runat="server" Font-Size="16pt" />
            <br />
            <br />
            <asp:Label ID="Label3" runat="server" Text="Offer ID:"></asp:Label>
            <br />
            <asp:TextBox ID="addOfferId" runat="server" Width="172px" MaxLength="20"></asp:TextBox>
            <br />
            <asp:Label ID="Label4" runat="server" Text="Serial Number:"></asp:Label>
            <br />
            <asp:TextBox ID="serialNo" runat="server" Width="172px" MaxLength="20"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="AddToProductBtn" runat="server" Text="Add to Product" BackColor="#333333" BorderWidth="0px" ForeColor="White" OnClick="AddToProductBtn_Click" Font-Size="12pt"/>
            <hr />
            <asp:Label Text="Remove Expired Offer" runat="server" Font-Size="16pt" ID="Label6" />
            <br />
            <br />
            <asp:Label ID="Label5" runat="server" Text="Offer ID:"></asp:Label>
            <br />
            <asp:TextBox ID="removeOfferID" runat="server" Width="172px" MaxLength="20"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="RemoveBtn" runat="server" Text="Remove" BackColor="#333333" BorderWidth="0px" ForeColor="White" OnClick="RemoveBtn_Click" Font-Size="12pt" />
            <hr />         
        </div>
    </form>
</body>
</html>
