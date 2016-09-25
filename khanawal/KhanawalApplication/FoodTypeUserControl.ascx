<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FoodTypeUserControl.ascx.cs"
    Inherits="KhanawalApplication.FoodTypeUserControl" %>
<asp:CheckBoxList CssClass="nav nav-list" ClientIDMode="Static" runat="server" ID="FoodTypeCheckBoxList"
    RepeatLayout="UnorderedList">
    <asp:ListItem Value="1">Veg</asp:ListItem>
    <asp:ListItem Value="0">Non-Veg</asp:ListItem>
</asp:CheckBoxList>
