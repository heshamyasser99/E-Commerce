<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Customer.aspx.cs" Inherits="Milestone3.Customer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    </head>
<body onkeydown="return (event.keyCode!=13)" onunload="">
    <h1>
        Customer Page
    </h1>
    <h3>
        Products:
    </h3>
    <form id="form2" runat="server">
        <asp:GridView ShowHeaderWhenEmpty="True" ID="GridView1" runat="server" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AutoGenerateColumns="False" DataKeyNames="serial_no" DataSourceID="SqlDataSource3">
            <Columns>
                <asp:BoundField DataField="serial_no" HeaderText="serial_no" InsertVisible="False" ReadOnly="True" SortExpression="serial_no" />
                <asp:BoundField DataField="product_name" HeaderText="product_name" SortExpression="product_name" />
                <asp:BoundField DataField="category" HeaderText="category" SortExpression="category" />
                <asp:BoundField DataField="product_description" HeaderText="product_description" SortExpression="product_description" />
                <asp:BoundField DataField="final_price" HeaderText="final_price" SortExpression="final_price" />
                <asp:BoundField DataField="price" HeaderText="price" SortExpression="price" />
                <asp:BoundField DataField="color" HeaderText="color" SortExpression="color" />
                <asp:CheckBoxField DataField="available" HeaderText="available" SortExpression="available" />
                <asp:BoundField DataField="rate" HeaderText="rate" SortExpression="rate" />
                <asp:BoundField DataField="vendor_username" HeaderText="vendor_username" SortExpression="vendor_username" />
                <asp:BoundField DataField="customer_username" HeaderText="customer_username" SortExpression="customer_username" />
                <asp:BoundField DataField="customer_order_id" HeaderText="customer_order_id" SortExpression="customer_order_id" />
            </Columns>
            <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
            <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
            <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#FFF1D4" />
            <SortedAscendingHeaderStyle BackColor="#B95C30" />
            <SortedDescendingCellStyle BackColor="#F1E5CE" />
            <SortedDescendingHeaderStyle BackColor="#93451F" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ProjectConnectionString %>" SelectCommand="ShowProductsbyPrice" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        <div>
            <br />
            <h3>My Wishlists:</h3>
            <asp:GridView ID="Wishlists" runat="server" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AutoGenerateColumns="False" DataSourceID="SqlDataSource4">
                <Columns>
                    <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
                </Columns>
                <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#FFF1D4" />
                <SortedAscendingHeaderStyle BackColor="#B95C30" />
                <SortedDescendingCellStyle BackColor="#F1E5CE" />
                <SortedDescendingHeaderStyle BackColor="#93451F" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ProjectConnectionString %>" SelectCommand="showWishlistsForCustomer" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter Name="customername" SessionField="username" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            Select Wishlist to Display Products:<br />
            <br />
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="Button8" runat="server" OnClick="Button8_Click" Text="view products" />
            <br />
            <br />
            Products In Selected Wishlist:<br />
            <br />
            <asp:GridView ID="GridView2" runat="server" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" AutoGenerateColumns="False" DataKeyNames="serial_no" DataSourceID="SqlDataSource6">
                <Columns>
                    <asp:BoundField DataField="serial_no" HeaderText="serial_no" InsertVisible="False" ReadOnly="True" SortExpression="serial_no" />
                    <asp:BoundField DataField="product_name" HeaderText="product_name" SortExpression="product_name" />
                    <asp:BoundField DataField="category" HeaderText="category" SortExpression="category" />
                    <asp:BoundField DataField="product_description" HeaderText="product_description" SortExpression="product_description" />
                    <asp:BoundField DataField="final_price" HeaderText="final_price" SortExpression="final_price" />
                    <asp:BoundField DataField="price" HeaderText="price" SortExpression="price" />
                    <asp:BoundField DataField="color" HeaderText="color" SortExpression="color" />
                    <asp:CheckBoxField DataField="available" HeaderText="available" SortExpression="available" />
                    <asp:BoundField DataField="rate" HeaderText="rate" SortExpression="rate" />
                    <asp:BoundField DataField="vendor_username" HeaderText="vendor_username" SortExpression="vendor_username" />
                    <asp:BoundField DataField="customer_username" HeaderText="customer_username" SortExpression="customer_username" />
                    <asp:BoundField DataField="customer_order_id" HeaderText="customer_order_id" SortExpression="customer_order_id" />
                </Columns>
                <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#FFF1D4" />
                <SortedAscendingHeaderStyle BackColor="#B95C30" />
                <SortedDescendingCellStyle BackColor="#F1E5CE" />
                <SortedDescendingHeaderStyle BackColor="#93451F" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:ProjectConnectionString %>" SelectCommand="showWishlistProduct" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter Name="customername" SessionField="username" Type="String" />
                    <asp:SessionParameter Name="name" SessionField="wishlist" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <br />
            <hr />
            <br />
            <br />
            Add Telephone Number:<br />
            <br />
        </div>
        <asp:TextBox ID="Ctel" runat="server" MaxLength="20"></asp:TextBox>
        <p>
            <asp:Button ID="AddCT" runat="server" OnClick="AddCT_Click" Text="ADD NUMBER" />
        </p>
        <hr />
        <p>
            Create New Wishlist:</p>
        <p>
            <asp:TextBox ID="newWish" runat="server" MaxLength="20"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="createWish" runat="server" OnClick="createWish_Click" Text="Create Wishlist" />
        </p>
        <p>
            Add/Remove Product To Wishlist:</p>
        <p>
            Wishlist:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Product:</p>
        <p>
            <asp:TextBox ID="WishName" runat="server" MaxLength="20"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="ProdName" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="Button1" runat="server" OnClick="AddProdToWish_Click" Text="Add Product To Wishlist" Width="193px" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button2" runat="server" OnClick="RemProdFromWish_Click" Text="Remove Product From Wishlist" Width="248px" />
&nbsp;&nbsp;&nbsp;
        </p>
        <hr />
    <h4>
            Add/Remove Product To Cart:</h4>
        <p>
            Product Serial_no:</p>
        <p>
            <asp:TextBox ID="ProdCart" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Add Product To Cart" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button4" runat="server" OnClick="Button4_Click" Text="Remove Product From Cart" Width="243px" />
        </p>
        
            <h2>
                Products In Cart:
            </h2>
           
        <p>
            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DataKeyNames="serial_no" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:BoundField DataField="serial_no" HeaderText="serial_no" InsertVisible="False" ReadOnly="True" SortExpression="serial_no" />
                    <asp:BoundField DataField="product_name" HeaderText="product_name" SortExpression="product_name" />
                    <asp:BoundField DataField="category" HeaderText="category" SortExpression="category" />
                    <asp:BoundField DataField="product_description" HeaderText="product_description" SortExpression="product_description" />
                    <asp:BoundField DataField="final_price" HeaderText="final_price" SortExpression="final_price" />
                    <asp:BoundField DataField="price" HeaderText="price" SortExpression="price" />
                    <asp:BoundField DataField="color" HeaderText="color" SortExpression="color" />
                    <asp:CheckBoxField DataField="available" HeaderText="available" SortExpression="available" />
                    <asp:BoundField DataField="rate" HeaderText="rate" SortExpression="rate" />
                    <asp:BoundField DataField="vendor_username" HeaderText="vendor_username" SortExpression="vendor_username" />
                    <asp:BoundField DataField="customer_username" HeaderText="customer_username" SortExpression="customer_username" />
                    <asp:BoundField DataField="customer_order_id" HeaderText="customer_order_id" SortExpression="customer_order_id" />
                </Columns>
                <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#FFF1D4" />
                <SortedAscendingHeaderStyle BackColor="#B95C30" />
                <SortedDescendingCellStyle BackColor="#F1E5CE" />
                <SortedDescendingHeaderStyle BackColor="#93451F" />
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ProjectConnectionString %>" SelectCommand="viewMyCart" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="" Name="customer" SessionField="username" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </p>
        <hr />
        <h3>
            Add CreditCard
            :</h3>
   

        <p>
            Number:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CVV Code:</p>
        <asp:TextBox ID="cardNumber" runat="server" MaxLength="20"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="cardCode" runat="server" MaxLength="4"></asp:TextBox>
&nbsp;&nbsp;&nbsp;
        <br />
        <br />
        Expiry Date: FORMAT IS MM/DD/YYYY<br />
        <br />
        <asp:TextBox ID="Date" runat="server"></asp:TextBox>
        <br />
&nbsp;<br />
&nbsp;
        <asp:Button ID="Button5" runat="server" OnClick="Button5_Click" Text="ADD CREDITCARD" />
   

        <br />
        <br />
        My CreditCards:<br />
   

        <br />
        <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DataKeyNames="number" DataSourceID="SqlDataSource2">
            <Columns>
                <asp:BoundField DataField="number" HeaderText="number" ReadOnly="True" SortExpression="number" />
                <asp:BoundField DataField="expiry_date" HeaderText="expiry_date" SortExpression="expiry_date" />
                <asp:BoundField DataField="cvv_code" HeaderText="cvv_code" SortExpression="cvv_code" />
            </Columns>
            <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
            <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
            <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#FFF1D4" />
            <SortedAscendingHeaderStyle BackColor="#B95C30" />
            <SortedDescendingCellStyle BackColor="#F1E5CE" />
            <SortedDescendingHeaderStyle BackColor="#93451F" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ProjectConnectionString %>" SelectCommand="showCreditcardsForCustomer" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter Name="customername" SessionField="username" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
   

        <br />
        <br />
        <asp:Button ID="Button6" runat="server" OnClick="Button6_Click" Text="Customer2" />
   

    </form>
   
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
   
</body>
</html>
