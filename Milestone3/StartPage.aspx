﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StartPage.aspx.cs" Inherits="Milestone3.StartPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:Button ID="Button1" runat="server" OnClick="vendorreg" Text="Vendor Register" />
        <p>
            <asp:Button ID="Button2" runat="server" OnClick="customerreg" Text=" Customer Register" />
        </p>
        <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="LOGIN" />
    </form>
</body>
</html>

