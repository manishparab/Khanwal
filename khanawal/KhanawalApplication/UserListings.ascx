<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserListings.ascx.cs"
    Inherits="KhanawalApplication.UserListings" %>
<style type="text/css">
    .subListingImage
    {
        height: 223px !important;
        width: 483px;
    }
    .wrapper
    {
        position: relative;
        margin-left: 50px;
    }
</style>
<asp:ListView GroupItemCount="2" ItemPlaceholderID="itemsPlaceHolder" runat="server"
    ID="UserListingsListView">
    <GroupTemplate>
        <div class="row">
            <asp:PlaceHolder runat="server" ID="itemsPlaceHolder"></asp:PlaceHolder>
        </div>
    </GroupTemplate>
    <ItemTemplate>
        <div class="span4">
            <div class="wrapper">
                <a href='ListingDetails.aspx?Id=<%# Eval("Listing.ID") %>'>
                    <img class="subListingImage" alt="" src="<%#Eval("ImageUrl")%>" />
                    <div class="caption">
                        <%#Eval("Listing.Title")%><br />
                    </div>
                    <div class="price-tag-container">
                        <b style="font-size: 25px">
                            <%#Eval("Listing.Cost")%>
                            Rs</b><br />
                    </div>
                </a>
            </div>
        </div>
    </ItemTemplate>
</asp:ListView>
