<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="MyListings.aspx.cs"
    Inherits="KhanawalApplication.MyListings" ClientIDMode="Static" %>


<%@ Register Src="ListingUserControl.ascx" TagName="ListingUserControl" TagPrefix="uc1" %>
<%@ Register Src="TopNavigationUserControl.ascx" TagName="TopNavigationUserControl"
    TagPrefix="ucTopNavigation" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script src="js/vendor/bootstrap.min.js"></script>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/Custom.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <ucTopNavigation:TopNavigationUserControl ID="TopNavigationUserControl1" runat="server" />
    <div style="height: 90%">
        <div id="mainContainerNew" class="container">
            <div style="width: 200px; margin-top: 60px" class="well pull-left">
                <ul class="nav nav-list">
                    <li><a href="DashBoard.aspx">Dashboard</a></li>
                    <li><a href="Inbox.aspx">Inbox</a></li>
                    <li class="active"><a href="#">My Dishes</a></li>
                    <li><a href="MyRequests.aspx">My Requests</a></li>
                    <li><a href="UpdateCalendar.aspx">My Calendar</a></li>
                </ul>
            </div>
            <div class="pull-left" style="margin-top: 60px">
                <div class="span9">
                    <div id="inbox" class="">
                        <div class="navbar-inner">
                            <h5>
                                <asp:Literal runat="server" ID="resultLiteral"></asp:Literal>
                            </h5>
                        </div>
                        <div>
                            <uc1:ListingUserControl ID="ListingUserControl" ManageListingLink="True" runat="server" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
   
    </form>
</body>
</html>
<script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
<script type="text/javascript">
    function CreatePost(obj) {
        var objButton = $(obj);
        objButton.button('loading');
        var params = {};
        params['message'] = "My new dish " + objButton.attr("a-DishName");
        params['name'] = objButton.attr("a-DishName");
        params['description'] = "Hello friends I have posted my new dish " + objButton.attr("a-DishName") + ", you can see the details of the dish and order it for only " + objButton.attr("a-DishCost") + " Rs at khanawal.com";
        params['link'] = "Khanawal.com/ListingDetails.aspx?ID=" + objButton.attr("a-DishId"); ;
        params['picture'] = "Khanawal.com" + objButton.attr("a-DishImageUrl");
        params['caption'] = objButton.attr("a-DishName");
        var listingId = objButton.attr("a-DishId");

        FB.api('/me/feed', 'post', params, function (response) {
            if (!response || response.error) {
            } else {
                var postData = "{faceBookPostId:'" + response.id +
                            "',listingId:'" + listingId +
                             "'}";
                $.ajax({
                    type: "POST",
                    url: "MYListings.aspx/UpdateFacePostPostIdForListing",
                    data: postData,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    beforeSend: function () {
                        //Mask page
                        //showProgress();
                    },
                    complete: function () {

                        //remove Mask
                        //hideProgress();
                    },
                    success: function (msg) {
                        objButton.val("Post again on FB");
                        //alert("success");
                    },
                    error: function (msg) {
                        //alert("fail");
                        objButton.button('complete');
                    }
                });
            }
        });
        return false;
    }
</script>
