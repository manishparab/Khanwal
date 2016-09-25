<%@ Control Language="C#" AutoEventWireup="true" Inherits="KhanawalApplication.SubListing" Codebehind="SubListing.ascx.cs" %>
<style type="text/css">
    .subListingImage {
        height: 323px !important;
        width: 483px;
    }
</style>
<asp:ListView GroupItemCount="2" ItemPlaceholderID="itemsPlaceHolder" runat="server" ID="subListingsListView">
   
    <GroupTemplate>
        <div class="row">
            <asp:PlaceHolder runat="server" ID="itemsPlaceHolder"></asp:PlaceHolder>
        </div>
    </GroupTemplate>
     <ItemTemplate>
        <div class="span6">
                <div class="wrapper">
                    <a href='ListingDetails.aspx?Id=<%# Eval("ID") %>'>
                        <img  class="subListingImage" alt="" src="<%#Eval("ImageUrl")%>" />
                        <div class="caption">
                           <%#Eval("Title")%><br />
                        </div>
                        <div class="price-tag-container">
                            <b style="font-size: 25px"> <%#Eval("Cost")%> Rs</b><br />
                        </div>
                    </a>
                </div>
            </div>
     </ItemTemplate>
</asp:ListView>