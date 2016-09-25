<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ManageListingPhotos.ascx.cs"
    Inherits="KhanawalApplication.ManageListingPhotos" %>
<ul id="sortable">
    <asp:ListView runat="server" ID="ListingPicturesListView">
        <ItemTemplate>
            <li listingpictureid="<%# Eval("ID") %>">
                <div class="li_Div_Style">
                    <img src="<%# Eval("DisplayImageUrl") %>" style="height: 140px;" />
                </div>
            </li>
        </ItemTemplate>
    </asp:ListView>
</ul>
