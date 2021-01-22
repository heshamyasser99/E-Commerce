<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MakeOrder.aspx.cs" Inherits="WebApplicationProj.MakeOrder" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Make Order</title>
    <style type="text/css">
        #form1 {
            direction: ltr;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="Button1" runat="server" Text="Make Order" OnClick="Button1_Click1" Height="39px" Width="259px" />
        <br />
        <br />
        Please choose an option of payment :<br />
        <asp:CheckBox ID="Cash" runat="server" OnCheckedChanged="CheckBox1_CheckedChanged1" />
        Cash<br />
        <asp:CheckBox ID="Credit_Card" runat="server" OnCheckedChanged="CheckBox1_CheckedChanged1" Checked="True" />
        Credit Card<br />
        <br />
        Please choose a credit card :<br />
        &nbsp;<asp:TextBox ID="TextBox4" runat="server" OnTextChanged="TextBox4_TextChanged"></asp:TextBox>
        &nbsp;
        <asp:Button ID="Button4" runat="server" Height="26px" OnClick="Button4_Click" Text="Confirm" Width="78px" />
        <br />
        Amount of money to be paid in cash/credit :<br />
&nbsp;<asp:TextBox ID="TextBox3" runat="server" Height="16px" OnTextChanged="TextBox3_TextChanged1"></asp:TextBox>
        &nbsp;
        <asp:Button ID="Button3" runat="server" Height="26px" OnClick="Button3_Click" Text="Confirm" Width="78px" />
        <br />
        &nbsp;<br />
        <br />
        Total amount :<asp:Label ID="Label1" runat="server"></asp:Label>
        <br />
        Order id :<asp:Label ID="Label2" runat="server"></asp:Label>
        <br />
        <br />
        Want to cancel an order? Please enter the ORDER ID before clicking the button.<br />
        &nbsp;<asp:TextBox ID="TextBox2" runat="server" OnTextChanged="TextBox2_TextChanged1"></asp:TextBox>
        &nbsp;
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Cancel Order" Width="105px" />
        <br />
        <br />
        <asp:Button ID="Button5" runat="server" OnClick="Button5_Click" Text="Customer1" />
        <br />
        <br />
    </form>
</body>
</html>
