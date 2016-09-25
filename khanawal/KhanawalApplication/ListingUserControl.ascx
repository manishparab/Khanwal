<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListingUserControl.ascx.cs"
    Inherits="KhanawalApplication.ListingUserControl" %>
<%@ Import Namespace="KhanawalApplication" %>
<style>
    .btn-large-navbar
    {
        padding: 9px 14px;
    }
    .navbar-inner h5 span
    {
        float: right;
    }
    
    .navbar-inner h5
    {
        cursor: pointer;
    }
    
    .search_result
    {
        padding-top: 10px;
        height: 110px;
        border-bottom-style: solid;
        border-bottom-width: 1px;
        border-bottom-color: #d4d4d4;
        padding-bottom: 5px;
    }
    
    
    .search_result_empty
    {
        padding-top: 10px;
        padding-left: 20px;
        height: 30px;
        border-bottom-style: solid;
        border-bottom-width: 1px;
        border-bottom-color: #d4d4d4;
        padding-bottom: 5px;
    }
    
    .search_result:hover
    {
        background-color: #F9F9F9;
    }
    
    
    .search_result .search_result_image
    {
        float: left;
        height: 50px;
    }
    
    .search_result .search_result_info
    {
        float: left;
        margin-left: 10px;
        font-size: 15pt;
        height: 100px;
        position: relative;
        min-width: 150px;
    }
    
    .search_result .search_result_pricing
    {
        float: right;
        font-size: 15pt;
        position: relative;
        height: 100px;
        width: 150px;
        text-align: right;
    }
    .search_result_pricing_manage_info
    {
        margin-top: 40px;
    }
    
    .search_result_pricing_manage_PostFaceBookButton
    {
        margin-top: 10px;
    }
    
    .search_result_info_review
    {
        position: absolute;
        bottom: 0;
        left: 0;
        margin-bottom: 5px;
    }
</style>
<asp:ListView runat="server" ID="ListingsListview">
    <ItemTemplate>
        <div class="search_result">
            <div class="search_result_image">
                <a href="ListingDetails.aspx?ID=<%#Eval("Listing.ID")%>">
                    <div style="border: 1px; border-style: solid; padding: 4px;">
                        <img alt="<%#Eval("Listing.Title")%>" style="min-height: 100px; width: 100px; height: 100px;
                            min-width: 100px;" src="<%# string.IsNullOrEmpty(Eval("ImageUrl").ToString())? "img/icons/Unknown.jpeg" : Eval("ImageUrl")  %>">
                    </div>
                </a>
            </div>
            <div class="search_result_info">
                <a href="ListingDetails.aspx?ID=<%#Eval("Listing.ID")%>">
                    <%#Eval("Listing.Title")%></a> &nbsp;
                <div class="search_result_info_review">
                    <a href="ListingDetails.aspx?ID=<%#Eval("Listing.ID")%>#divReview" style="display: <%# (int)Eval("ReviewCount") > 0 ? "block":"none"%>">
                        <%#Eval("ReviewCount")%>
                        Reviews</a>
                </div>
            </div>
            <div class="search_result_pricing">
                <div style="display: <%#  Eval("Listing.Cost") != null ? "block":"none"%>">
                    <%#Eval("Listing.Cost")%>
                    RS
                </div>
                <div class="search_result_pricing_manage_PostFaceBookButton" style="display: <%# ManageListingLink && (bool)Eval("ListingStatus.ValidstionStatus") ? "block":"none"%>">
                    <asp:Button OnClientClick="return CreatePost(this)" a-DishId='<%#Eval("Listing.ID")%>'
                        a-DishName='<%#Eval("Listing.Title")%>' a-DishCost='<%#Eval("Listing.Cost")%>'
                        a-DishImageUrl='<%#Eval("ImageUrl")%>' class="btn btn-primary" Text='<%# string.IsNullOrEmpty(Convert.ToString(Eval("Listing.FaceBookPostId")))? "Post on FB" : "Post again on FB" %>'
                        runat="server" name="FaceBookPost" ID="FaceBookPost" data-loading-text="Please Wait.."
                        data-complete-text="Post on FB" />
                </div>
                <div class="search_result_pricing_manage_info" style="display: <%# ManageListingLink ? "block":"none"%>">
                    <a href="ManageListing.aspx?ID=<%#Eval("Listing.ID")%>">[Edit Dish] </a>
                </div>
            </div>
        </div>
    </ItemTemplate>
    <EmptyDataTemplate>
        <asp:Panel runat="server" ID="div_search_result_empty">
            <div class="alert alert-error" style="margin-top: 10px">
                No Listing found in your area, please try <a href="#" id="empty_result_user_result_tab">
                    User Request Tab </a>
            </div>
        </asp:Panel>
        <asp:Panel runat="server" ID="div_search_empty">
            <div class="alert alert-error"  style="margin-top: 10px">
                Hmm..No Dish..If you love to cook , Add your own dish <a href="ListingNew.aspx" id="A1">
                    Here </a>
            </div>
        </asp:Panel>
    </EmptyDataTemplate>
</asp:ListView>
<script type="text/javascript">

    $("#empty_result_user_result_tab").click(function () {
        isUserListingTab = false;
        SeachUser();
        $("#UserRequestHyperLink").tab('show');
    });
</script>
