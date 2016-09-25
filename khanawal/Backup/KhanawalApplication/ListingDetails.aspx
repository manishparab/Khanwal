<%@ Page Language="C#" AutoEventWireup="true" Inherits="KhanawalApplication.ListingDetails"
    CodeBehind="ListingDetails.aspx.cs" %>
    
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
    <script src="js/jquery.raty.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
    <script src="js/bootstrap-datepicker.js" type="text/javascript"></script>
    <link href="css/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="js/bootstrap-tagmanager.js" type="text/javascript"></script>
    <link href="css/bootstrap-tagmanager.css" rel="stylesheet" type="text/css" />

    <style>
        .userBriefContent
        {
            padding: 0 0 0 35px;
            position: relative;
            font-size: 2em;
            font-weight: bold;
            line-height: 100%;
        }
        
        .userBriefContent img
        {
            left: 0;
            position: absolute;
        }
        .Message_header_Comments
        {
            position: relative;
            background-image: linear-gradient(top, #FEFEFE, #E8E8E8);
        }
        body
        {
            padding-bottom: 40px;
        }
        
        #map_canvas
        {
            width: auto;
            height: 300px;
        }
        
        .UserBusy
        {
            background-color: #E07272;
        }
        .UserAvailable
        {
            background-color: #ACDBA8;
        }
        .PastDate
        {
            background-color: #F9F9F9;
        }
        #tblCalender td
        {
            height: 50px;
            width: 50px;
            padding: 0;
            margin: 0;
            text-align: left;
            font-size: 15px;
        }
        
        .containerCalendar
        {
            position: relative;
            height: 100%;
        }
        
        .bg
        {
            position: absolute;
            top: 0;
            bottom: 50%;
            width: 100%;
        }
        
        
        
        .bgBottom
        {
            position: absolute;
            top: 50%;
            bottom: 0;
            width: 100%;
        }
        
        .contentCalendar
        {
            position: relative;
            z-index: 1;
            text-align: right;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <ucTopNavigation:TopNavigationUserControl ID="TopNavigationUserControl1" runat="server"
         />
    <div class="container" style="margin-top: 60px">
        <asp:HiddenField runat="server" ID="ListingVisibiltyHiddenField" />
        <asp:HiddenField runat="server" ID="UserLoggedInHiddenField" />
        <asp:HiddenField runat="server" ID="ListingIdHiddenField" />
        <asp:HiddenField runat="server" ID="OtherListingHiddenField" Value="false" />
        <asp:HiddenField runat="server" ID="SimilarlistingHiddenField" Value="false" />
        <asp:HiddenField runat="server" ID="SideListingTabHiddenField" Value="false" />
        <asp:HiddenField runat="server" ID="ReviewTabHiddenField" Value="false" />
        <div class="alert alert-danger" style="display: none" id="ManageListingDiv">
            This listing is not visible to other users , to make it visible please complete
            the steps at
            <asp:HyperLink runat="server" ID="ManageListingHyperlink" Text="Manage Listing" NavigateUrl="#"></asp:HyperLink>
        </div>
        <div>
            <div style="float: left; width: 70%">
                <div class="navbar" id="topDivTabs">
                    <div class="navbar-inner">
                        <ul class="nav nav-tabs" id="divTop">
                            <li class="active"><a href="#listingPhoto">Photo</a> </li>
                            <li><a href="#listingCalender">Calender</a></li>
                            <li><a id="listingMapHyperlink" style="display: none" href="#listingMap">Pickup location</a></li>
                        </ul>
                    </div>
                    <div style="border-style: solid; border-width: 1px; border-color: #D4D4D4">
                        <div class="tab-content" style="margin: 10px">
                            <div class="tab-pane active" id="listingPhoto">
                                <div id="myCarousel" class="carousel slide">
                                    <!-- Carousel items -->
                                    <div class="carousel-inner">
                                        <%--<div class="item">
                                            <img alt="" src="img/540/misal.jpg" />
                                        </div>
                                        <div class="item">
                                            <img alt="" src="img/540/tawa fry.jpg" />
                                        </div>
                                        <div class="item">
                                            <img alt="" src="img/540/DSC00814.JPG" />
                                        </div>--%>
                                        <asp:ListView runat="server" ID="ListingPicturesSliders">
                                            <ItemTemplate>
                                                <div class="item">
                                                    <img alt="" style="width: 675px; height: 430px;" src="<%# Eval("DisplayImageUrl") %>" />
                                                </div>
                                            </ItemTemplate>
                                            <EmptyItemTemplate>
                                                <img alt="unknown" style="width: 675px" src="img/icons/Unknown.jpeg" />
                                            </EmptyItemTemplate>
                                            <EmptyDataTemplate>
                                                <img alt="unknown" style="width: 675px" src="img/icons/Unknown.jpeg" />
                                            </EmptyDataTemplate>
                                        </asp:ListView>
                                    </div>
                                    <!-- Carousel nav -->
                                    <a class="carousel-control left" href="#myCarousel" data-slide="prev">&lsaquo;</a>
                                    <a class="carousel-control right" href="#myCarousel" data-slide="next">&rsaquo;</a>
                                </div>
                            </div>
                            <div class="tab-pane" id="listingCalender">
                                <asp:ListView runat="server" ItemPlaceholderID="itemPlaceHolder" GroupItemCount="7"
                                    GroupPlaceholderID="groupplaceHolder" ID="userCalenderListview" OnItemDataBound="userCalenderListview_ItemDataBound">
                                    <LayoutTemplate>
                                        <table id="tblCalender" class="table table-bordered CalenderTable">
                                            <tbody>
                                                <tr>
                                                    <th>
                                                        Mon
                                                    </th>
                                                    <th>
                                                        Tue
                                                    </th>
                                                    <th>
                                                        Wed
                                                    </th>
                                                    <th>
                                                        Thu
                                                    </th>
                                                    <th>
                                                        Fri
                                                    </th>
                                                    <th>
                                                        Sat
                                                    </th>
                                                    <th>
                                                        Sun
                                                    </th>
                                                </tr>
                                                <asp:PlaceHolder runat="server" ID="groupplaceHolder"></asp:PlaceHolder>
                                            </tbody>
                                        </table>
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <td>
                                            <asp:Label runat="server" ID="StatusLabelUpperHalf" Visible="False" Text='<%# Eval("StatusfirstHalf") %>'></asp:Label>
                                            <asp:Label runat="server" ID="StatusLabelLowerHalf" Visible="False" Text='<%# Eval("StatusLowerHalf") %>'></asp:Label>
                                            <div class="containerCalendar">
                                                <div class='<%# Eval("StatusfirstHalf") %> bg' half="upper" useravailbility='check'
                                                    date='<%# Eval("CalendarDate") %>'>
                                                    <asp:Literal runat="server" ID="CalendarDatelitral" Text='<%# Eval("CalendarDate") %>'></asp:Literal></div>
                                                <div class='<%# Eval("StatusLowerHalf") %> bgBottom' half="second" useravailbility='check'
                                                    date='<%# Eval("CalendarDate") %>'>
                                                </div>
                                            </div>
                                        </td>
                                    </ItemTemplate>
                                    <GroupTemplate>
                                        <tr>
                                            <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
                                        </tr>
                                    </GroupTemplate>
                                </asp:ListView>
                            </div>
                            <div class="tab-pane" id="listingMap">
                                <div id="map_canvas">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="navbar" id="Div1">
                    <div class="navbar-inner">
                        <ul class="nav nav-tabs" id="divMiddle">
                            <li class="active">
                                <asp:HyperLink NavigateUrl="#Description" runat="server" ID="HyperlinkRecipe"></asp:HyperLink>
                            </li>
                            <li><a id="OtherIngredientsHyperlink" href="#DivIngredients">Ingredients used</a></li>
                            <li><a id="RecommendedSideDishHyperlink" href="#Recommended">Recommended Side Dish</a></li>
                        </ul>
                    </div>
                    <div style="border-style: solid; border-width: 1px; border-color: #D4D4D4">
                        <div class="tab-content">
                            <div id="Description" class="tab-pane active">
                                <div style="overflow: hidden">
                                    <div style="float: left; width: 70%; margin-left: 10px; margin-top: 10px;">
                                        <asp:Literal runat="server" ID="ListingDescriptionLitral"></asp:Literal>
                                    </div>
                                    <div style="float: right; background-color: white; width: 28%;">
                                        <table class="table table-striped">
                                            <tr>
                                                <td>
                                                    Recipe Type
                                                </td>
                                                <td>
                                                    <b>
                                                        <asp:Literal runat="server" ID="ListingRecipeTypeLiteral"></asp:Literal></b>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Main Ingredient
                                                </td>
                                                <td>
                                                    <b>
                                                        <asp:Literal runat="server" ID="ListingMainIngredientLiteral"></asp:Literal></b>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Taste
                                                </td>
                                                <td>
                                                    <b>
                                                        <asp:Literal runat="server" ID="ListingTasteLiteral"></asp:Literal></b>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Servings
                                                </td>
                                                <td>
                                                    <b>
                                                        <asp:Literal runat="server" ID="ListingServingsLiteral"></asp:Literal>
                                                        Adults</b>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Price
                                                </td>
                                                <td>
                                                    <b>
                                                        <asp:Literal runat="server" ID="ListingPriceLiteral"></asp:Literal>
                                                        rs</b>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Home Delivery
                                                </td>
                                                <td>
                                                    <b>
                                                        <asp:Literal runat="server" ID="ListingHomeDeliveryLiteral"></asp:Literal></b>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Cancellation
                                                </td>
                                                <td>
                                                    <b>
                                                        <asp:Literal runat="server" ID="ListingCancellationPolicyLiteral"></asp:Literal></b>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div id="DivIngredients" class="tab-pane" style="margin: 10px;">
                                <div class="panel panel-success">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">
                                            Main Ingredient used in dish
                                        </h3>
                                    </div>
                                    <div class="panel-body">
                                        <span id="MainIngredient" name="MainIngredient" class="tm-MainIngredient tm-input tm-input-disabled"></span>
                                        <asp:HiddenField runat="server" ID="HiddenFieldMainIngredients" />
                                    </div>
                                </div>
                                <div class="panel panel-success">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">
                                            Other Ingredient's used in dish
                                        </h3>
                                    </div>
                                    <div class="panel-body">
                                        <span id="SubIngredient" name="SubIngredient" class="tm-SubIngredient tm-input tm-input-disabled"></span>
                                        <asp:HiddenField runat="server" ID="HiddenFieldSubIngredients" />
                                    </div>
                                </div>
                            </div>
                            <div id="Recommended" class="tab-pane" style="margin: 10px;">
                                <dl>
                                    <asp:ListView runat="server" ID="SideDishListView">
                                        <ItemTemplate>
                                            <dt>
                                                <%#Eval("SideListing.Name")%>
                                            </dt>
                                            <dd>
                                                <%#Eval("SideListing.Description")%>
                                            </dd>
                                        </ItemTemplate>
                                        <EmptyDataTemplate>
                                            <dd>
                                                There are no side dishes</dd>
                                        </EmptyDataTemplate>
                                    </asp:ListView>
                                </dl>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="navbar" id="divReview">
                    <div class="navbar-inner">
                        <ul class="nav nav-tabs" id="divBottoom">
                            <li id="listingReviewHyperlink" class="active"><a href="#Review">Review(s)</a> </li>
                            <li><a id="WriteReviewHyperlink" href="#WriteReview">Write a Review</a></li>
                        </ul>
                    </div>
                    <div style="border-style: solid; border-width: 1px; border-color: #D4D4D4">
                        <div class="tab-content" style="margin: 10px">
                            <div class="tab-pane active" id="Review">
                                <ul class="unstyled" style="margin-top: 5px;">
                                    <li>
                                        <table style="width: 50%">
                                            <tr>
                                                <td>
                                                    <b>Over All </b>
                                                </td>
                                                <td>
                                                    <div id="starOverAll">
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <b>Taste</b>
                                                </td>
                                                <td>
                                                    <div id="starTaste">
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <b>Qunatity</b>
                                                </td>
                                                <td>
                                                    <div id="starQuantity">
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <b>Value For Money</b>
                                                </td>
                                                <td>
                                                    <div id="starValueFormoney">
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <b>Behavior</b>
                                                </td>
                                                <td>
                                                    <div id="starBehavior">
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </li>
                                </ul>
                                <ul class="unstyled">
                                    <asp:ListView runat="server" ID="ListingCommentListView">
                                        <ItemTemplate>
                                            <li>
                                                <div style="clear: both">
                                                    <div class="thumbnailPic_Comments">
                                                        <img alt="<%#Eval("User.first_name")%>" src="<%#Eval("User.ImageUrl")%>/picture?type=large">
                                                    </div>
                                                    <div class="Comments_Message">
                                                        <div class="Message_header_Comments" style="text-align: left">
                                                            <div class="arrow_left">
                                                            </div>
                                                            <div class="comments_Message_body">
                                                                <%#Eval("Review")%>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </li>
                                        </ItemTemplate>
                                    </asp:ListView>
                                </ul>
                            </div>
                            <div class="tab-pane" id="WriteReview">
                                <ul class="unstyled" style="margin-top: 5px;">
                                    <li>
                                        <table style="width: 50%;">
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                    <h5>
                                                        Rating factors</h5>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <b>Taste</b>
                                                </td>
                                                <td>
                                                    <div id="StarTasteReview">
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <b>Qunatity</b>
                                                </td>
                                                <td>
                                                    <div id="StarQuantityReview">
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <b>Value For Money</b>
                                                </td>
                                                <td>
                                                    <div id="StarValueFormoneyReview">
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <b>Service Behavior</b>
                                                </td>
                                                <td>
                                                    <div id="StarBehaviorReview">
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </li>
                                    <li>&nbsp; </li>
                                    <li>
                                        <h4>
                                            Review box
                                        </h4>
                                    </li>
                                    <li>
                                        <asp:TextBox runat="server" TextMode="MultiLine" Height="300px" Rows="10" Columns="50"
                                            ID="reviewBoxTextBox" ClientIDMode="Static"></asp:TextBox>
                                    </li>
                                    <li>
                                        <input type="button" data-loading-text="Please Wait.." data-complete-text="Submit Review and Rating"
                                            onclick="SaveUserRatingAndReview()" style="width: 250px" class="btn btn-large btn-block btn-primary"
                                            name="SubmitRating" id="SubmitRatingButton" value="Submit Review and Rating" />
                                        <br />
                                        <div id="ReviewSaveStatus">
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div style="float: right; width: 29%;">
                <div style="border-style: solid; border-width: 1px; border-color: #D4D4D4; margin-bottom: 5px;">
                    <div style="margin: 10px">
                        <h3>
                            <asp:Literal runat="server" ID="ListingTitleLiteral"></asp:Literal>
                            <br />
                            <asp:Literal runat="server" ID="ListingCostLiteral"></asp:Literal>
                            RS
                        </h3>
                        <hr />
                        <h5>
                            Persons</h5>
                        <div class="input-prepend input-append">
                            <select id="selectServings" class="span2">
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                            </select>
                            <span class="add-on"><i class="icon-user"></i></span>
                        </div>
                        <div id="calendarDiv">
                            <hr />
                            <h5>
                                Date</h5>
                            <div class="input-prepend input-append">
                                <asp:TextBox ID="ListingOrderDate" class="dtpickerStatic" ClientIDMode="Static" runat="server"></asp:TextBox>
                                <span class="add-on"><i class="icon-calendar"></i></span>
                            </div>
                            <hr />
                        </div>
                        <div id="bookingInformation" class="alert" style="display: none">
                        </div>
                        <h5>
                            Message
                        </h5>
                        <div class="">
                            <asp:TextBox Width="250px" runat="server" TextMode="MultiLine" ClientIDMode="Static"
                                ID="RequestListingMessage"></asp:TextBox>
                        </div>
                        <br />
                        <input type="button" data-loading-text="Please Wait.." data-complete-text="Order"
                            onclick="AddRequestListing()" value="Order" id="OrderButton" class="btn btn-large btn-block btn-primary" />
                        <br />
                        <div id="listingRequestOrderResultMessage">
                        </div>
                    </div>
                </div>
                <div style="border-style: solid; border-width: 1px; border-color: #D4D4D4; margin-bottom: 5px;">
                    <div style="margin: 10px">
                        <div align="center">
                            <div style="border-width: 2px; padding: 4px; border-color: #D4D4D4; border-style: solid;
                                max-width: 180px;">
                                <asp:Image ImageUrl="#" ID="ListingUserImage" runat="server" />
                            </div>
                            <a href="#" runat="server" id="userProfileHyperlink">
                                <h3>
                                    <asp:Literal runat="server" ID="UserNameLiteral"></asp:Literal>
                                </h3>
                            </a>
                        </div>
                        <ul class="unstyled">
                            <li runat="server" id="DishServedLi">
                                <div class="userBriefContent">
                                    <img src="img/icons/glyphicons_275_fast_food.png" alt="Dish Served" />
                                    <asp:Literal runat="server" ID="LiteralDishServed"></asp:Literal>
                                </div>
                                <h5>
                                    Dishes Served</h5>
                                <hr />
                            </li>
                            <li runat="server" id="FamousDishLi">
                                <div class="userBriefContent">
                                    <img src="img/icons/glyphicons_295_pot.png" alt="Dish Served" />
                                    <asp:Literal runat="server" ID="FamousDishLiteral"></asp:Literal>
                                </div>
                                <h5>
                                    Famous Dish</h5>
                                <hr />
                            </li>
                            <li>
                                <div class="userBriefContent">
                                    <img src="img/icons/glyphicons_054_clock.png" alt="Dish Served" />
                                    Few hours
                                </div>
                                <h5>
                                    Response Time</h5>
                            </li>
                        </ul>
                    </div>
                </div>
                <div id="OtherListingDiv">
                    <div id="blockTitle" class="navbar-inner" align="center">
                        <h4>
                            Other Listings</h4>
                    </div>
                    <div style="border-style: solid; border-width: 1px; border-color: #D4D4D4; margin-bottom: 5px;">
                        <ul class="unstyled" style="margin-top: 5px">
                            <asp:ListView runat="server" ID="OtherListingListView">
                                <ItemTemplate>
                                    <li style="margin-bottom: 5px;">
                                        <div style="overflow: hidden">
                                            <div style="float: left; border: 1px; margin-left: 5px; border-style: solid; padding: 2px;
                                                border-color: #D4D4D4; max-width: 200px">
                                                <a href='ListingDetails.aspx?Id=<%# Eval("listing.ID") %>'>
                                                    <img src="<%#Eval("ImageUrl")%>" style="width: 200px; height: 150px" alt="<%#Eval("listing.Title")%>" />
                                                </a>
                                            </div>
                                            <div style="float: left; margin-left: 10px; font-weight: bolder">
                                                <%#Eval("listing.Cost")%>
                                                RS
                                            </div>
                                        </div>
                                    </li>
                                </ItemTemplate>
                                <EmptyDataTemplate>
                                    No Listing present
                                </EmptyDataTemplate>
                            </asp:ListView>
                        </ul>
                    </div>
                </div>
                <div id="SimilarListingDiv">
                    <div id="Div3" class="navbar-inner" align="center">
                        <h4>
                            Similar Listings</h4>
                    </div>
                    <div style="border-style: solid; border-width: 1px; border-color: #D4D4D4; margin-bottom: 5px;">
                        <ul class="unstyled" style="margin-top: 5px">
                            <asp:ListView runat="server" ID="SimilarListingListView">
                                <ItemTemplate>
                                    <li style="margin-bottom: 5px;">
                                        <div style="overflow: hidden">
                                            <div style="float: left; border: 1px; margin-left: 5px; border-style: solid; padding: 2px;
                                                border-color: #D4D4D4; max-width: 200px">
                                                <a href='ListingDetails.aspx?Id=<%# Eval("listing.ID") %>'>
                                                    <img src="<%#Eval("ImageUrl")%>" style="width: 200px; height: 150px" alt="<%#Eval("listing.Title")%>" />
                                                </a>
                                            </div>
                                            <div style="float: left; margin-left: 10px; font-weight: bolder">
                                                <%#Eval("listing.Cost")%>
                                                RS
                                            </div>
                                        </div>
                                    </li>
                                </ItemTemplate>
                            </asp:ListView>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
     
    </form>
    <script type="text/javascript">

        var nowTemp = new Date();
        var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
        var maxDate = new Date(nowTemp.getFullYear(), nowTemp.getMonth() + 1, 0);

        var TasteRating = '<%=TasteRating%>';
        var QuantyRating = '<%=QuantyRating%>';
        var VfmRating = '<%=VfmRating%>';
        var BehaviorRating = '<%=BehaviorRating%>';
        var OverAllRating = '<%=OverAllRating%>';

        function getQuerystring(key, default_) {
            if (default_ == null) default_ = "";
            key = key.toLowerCase();
            key = key.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regex = new RegExp("[\\?&]" + key + "=([^&#]*)");
            var qs = regex.exec(window.location.href.toLowerCase());
            if (qs == null)
                return default_;
            else
                return qs[1];
        }


        function resetRequestListing() {
            var currentDate = new Date();
            var month = (currentDate.getMonth() + 1);
            var day = currentDate.getDate();
            var requestListingMessage = $("#RequestListingMessage");
            requestListingMessage.val('');
            var selectServings = $("#selectServings");
            selectServings.val(1);
            $('#ListingOrderDate').val((day < 10 ? '0' : '') + day + "/" + (month < 10 ? '0' : '') + month + "/" + currentDate.getFullYear());
            $('#ListingOrderDate').datepicker('update');

        }




        function SetDateRequestListing(requestListingdate, message) {
            var currentDate = new Date();
            var month = (currentDate.getMonth() + 1);
            var day = requestListingdate;
            $('#ListingOrderDate').val((day < 10 ? '0' : '') + day + "/" + (month < 10 ? '0' : '') + month + "/" + currentDate.getFullYear());
            $('#ListingOrderDate').datepicker('update');
            $('#calendarDiv').animate({ backgroundColor: "#d9edf7" }, 2000, function () {
                $('#calendarDiv').animate({ backgroundColor: "white" }, 'slow');
            });

            if (message.length > 0) {
                $("#bookingInformation").css("display", "block");
                $("#bookingInformation").html("Please note, on this date user is not available for " + message);
            } else {
                $("#bookingInformation").css("display", "none");
            }

            return false;
        }


        function AddRequestListing() {

            $("#OrderButton").button('loading');

            if (CheckAuthentication()) {
                var listingOrderDate = $("#ListingOrderDate");
                var selectServings = $("#selectServings");
                var requestListingMessage = $("#RequestListingMessage");
                var requestId = getQuerystring("Id");
                var postData = "{listingId:" + getQuerystring("Id") + ",requestedDate:'" + listingOrderDate.val() + "',requestedServings:" + selectServings.val() + ",message:'" + requestListingMessage.val() + "'}";
                var listingRequestOrderResultMessage = $("#listingRequestOrderResultMessage");
                //Comments total Div

                $.ajax({
                    type: "POST",
                    url: "ListingDetails.aspx/AddListingRequest",
                    data: postData,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        if (msg.d != null) {
                            if (msg.d > 0) {
                                listingRequestOrderResultMessage.hide();
                                listingRequestOrderResultMessage.addClass("alert alert-success");
                                listingRequestOrderResultMessage.html("Your order is sucessfully send at, enjoy..");
                                listingRequestOrderResultMessage.show();

                                //                                listingRequestOrderResultMessage.fadeIn(100, function () {
                                //                                  
                                //                                });
                                //                                resetRequestListing();
                            } else {
                                listingRequestOrderResultMessage.addClass("alert alert-error");
                                listingRequestOrderResultMessage.html("This is too bad..try again...oh god make it work");
                            }
                        } else {
                            listingRequestOrderResultMessage.addClass("alert alert-error");
                            listingRequestOrderResultMessage.html("This is too bad..try again...oh god make it work");
                        }
                    },
                    complete: function (msg) {
                        $("#OrderButton").button('complete');
                    },
                    error: function (msg) {
                        listingRequestOrderResultMessage.show().removeClass("alert-success").addClass("alert alert-error").text("Error occured, please try again");

                    }
                });
            }

        }


        $(document).ready(function () {
            $(document).on("AuthSuccess", AuthSuccessHandler);
        });

        // AuthSuccess event handler
        function AuthSuccessHandler(e) {
            $("#UserLoggedInHiddenField").val("true");
            $("#OrderButton").button('complete');
            $("#SubmitRatingButton").button('complete');
        }
        
        function CheckAuthentication() {
            if ($("#UserLoggedInHiddenField").val() == "false") {
                AuthenticateUser();
                //window.location.replace("AutheticationRedirection.aspx?RedirectUrl=ListingDetails.aspx?Id=" + $("#ListingIdHiddenField").val());
                return false;
            }

            return true;
        }

        function SaveUserRatingAndReview() {
            var validated = true;
            var errortext = "";

            if (CheckAuthentication()) {
                var userReview = $("#reviewBoxTextBox").val();

                if (!userReview.length > 0) {
                    errortext = "!! Review is empty, come on atleast write something.";
                    $("#ReviewSaveStatus").html();
                    validated = false;
                }

                var tasteRating = $("#StarTasteReview").raty('score');
                var quantityRating = $("#StarQuantityReview").raty('score');
                var valueForMoneyRating = $("#StarValueFormoneyReview").raty('score');
                var behaviorRating = $("#StarBehaviorReview").raty('score');


                if (typeof tasteRating == 'undefined') {
                    if (errortext.length > 0) {
                        validated = false;
                        errortext = errortext + "<br/>" + "!! Rating for Taste is missing";
                    } else {
                        errortext = errortext + "!! Rating for Taste is missing";
                    }
                }

                if (typeof quantityRating == 'undefined') {
                    validated = false;
                    if (errortext.length > 0) {
                        errortext = errortext + "<br/>" + "!! Rating for quantity is missing";
                    } else {
                        errortext = errortext + "!! Rating for quantity is missing";
                    }
                }
                if (typeof valueForMoneyRating == 'undefined') {
                    validated = false;
                    if (errortext.length > 0) {
                        errortext = errortext + "<br/>" + "!! Rating for value for money is missing";
                    } else {
                        errortext = errortext + "!! Rating for value for money is missing";
                    }
                }
                if (typeof behaviorRating == 'undefined') {
                    validated = false;
                    if (errortext.length > 0) {
                        errortext = errortext + "<br/>" + "!! Rating for service behaviour is missing";
                    } else {
                        errortext = errortext + "!! Rating for service behaviour is missing";
                    }
                }

                if (!validated) {
                    $("#ReviewSaveStatus").addClass("alert alert-error");
                    errortext = "<b>Can not submit your review , please solve below error(s)</b><br/>" + errortext;
                    $("#ReviewSaveStatus").html(errortext);
                } else {
                    $("#SubmitRatingButton").button('loading');
                    var postData = "{listingId:" + getQuerystring("Id") + ",userReview:'" + userReview + "',ratingTaste:" + tasteRating + ",ratingQunatity:" + quantityRating + ",ratingServiceBehavour:" + behaviorRating + ",ratingValueForMoney:" + valueForMoneyRating + "}";
                    $.ajax({
                        type: "POST",
                        url: "ListingDetails.aspx/NewReviewForListing",
                        data: postData,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (msg) {
                            $('#StarTasteReview').raty('cancel');
                            $('#StarQuantityReview').raty('cancel');
                            $('#StarValueFormoneyReview').raty('cancel');
                            $('#StarBehaviorReview').raty('cancel');
                            $("#reviewBoxTextBox").val("");
                            $("#ReviewSaveStatus").addClass("alert alert-success");
                            $("#ReviewSaveStatus").html("Your review saved saved successfully, it will appear after its been validated.");
                            $("#SubmitRatingButton").button('complete');
                        },
                        error: function (msg) {
                            $("#SubmitRatingButton").button('complete');
                            $("#ReviewSaveStatus").addClass("alert alert-error");
                            $("#ReviewSaveStatus").html("yeah error occured.lets try again.");
                        }
                    });
                }
            }

        }

        $(document).ready(function () {
            if (typeof latlang != "undefined") {
                $("#listingMapHyperlink").css("display", "block");
            }
            if ($("#ListingVisibiltyHiddenField").val() == "true") {

                $("#ManageListingDiv").css("display", "block");
                $("#SubmitRatingButton").removeClass("btn-primary");
                $("#OrderButton").removeClass("btn-primary");

                $("#SubmitRatingButton").addClass("disabled");
                $("#OrderButton").addClass(".disabled");

                $("#SubmitRatingButton").prop("disabled", true);
                $("#OrderButton").prop("disabled", true);

            } else {
                $("#ManageListingDiv").css("display", "none");
                $("#SubmitRatingButton").addClass("btn-primary");
                $("#OrderButton").addClass("btn-primary");

                $("#SubmitRatingButton").prop("disabled", true);
                $("#OrderButton").removeClass(".disabled");

                $("#SubmitRatingButton").prop("disabled", false);
                $("#OrderButton").prop("disabled", false);
            }

            var tasteRating = '<%=TasteRating%>';
            var quantyRating = '<%=QuantyRating%>';
            var vfmRating = '<%=VfmRating%>';
            var behaviorRating = '<%=BehaviorRating%>';
            var overAllRating = '<%=OverAllRating%>';

            var listingOrderDate = $("#ListingOrderDate").datepicker({
                format: "dd/mm/yyyy",
                onRender: function (date) {
                    return (date.valueOf() < now.valueOf() || date.valueOf() > maxDate.valueOf()) ? 'disabled' : '';
                }
            }).on('changeDate', function (ev) {
                var newDate = new Date(ev.date);
                var selectedDate = newDate.getDay();
                //alert($('div[date="12"]').length);
                listingOrderDate.hide();
                checkCalendarStatus(newDate.getDate());
            }).data('datepicker');

            function checkCalendarStatus(datevalue) {

                var calendarTable = $("#tblCalender");
                var perticularDate = calendarTable.find("[date='" + datevalue + "']");
                var firsthalf = false;
                var secondHalf = false;
                var message = "";
                perticularDate.each(function () {
                    if ($(this).attr("half") == "upper") {
                        if ($(this).hasClass("UserBusy")) {
                            firsthalf = true;
                        }
                    }
                    if ($(this).attr("half") == "second") {
                        if ($(this).hasClass("UserBusy")) {
                            secondHalf = true;
                        }
                    }
                });

                if (firsthalf && secondHalf) {
                    message = "full day";
                }
                else if (firsthalf) {
                    message = " first half i.e in morning";
                }
                else if (secondHalf) {
                    message = "second half i.e in evening";
                }

                SetDateRequestListing(datevalue, message);
            }


            $('#divTop a').click(function (e) {
                e.preventDefault();
                $(this).tab('show');
                if ($(this).attr("href") == "#listingMap") {
                    initializeMap();
                }
            });

            $('#divMiddle a').click(function (e) {
                e.preventDefault();
                $(this).tab('show');
            });

            $('#divBottoom a').click(function (e) {
                e.preventDefault();
                $(this).tab('show');
            });

            $(".item:first").addClass("active");

            $('#myCarousel').carousel();

            $('#starOverAll').raty({
                readOnly: true,
                score: overAllRating,
                starHalf: 'Rating/star-half-big.png',
                starOff: 'Rating/star-off-big.png',
                starOn: 'Rating/star-on-big.png',
                width: 170
            });
            $('#starTaste').raty({
                readOnly: true,
                score: tasteRating,
                starHalf: 'Rating/star-half.png',
                starOff: 'Rating/star-off.png',
                starOn: 'Rating/star-on.png',
                width: 170
            });
            $('#starQuantity').raty({
                readOnly: true,
                score: quantyRating,
                starHalf: 'Rating/star-half.png',
                starOff: 'Rating/star-off.png',
                starOn: 'Rating/star-on.png',
                width: 170
            });
            $('#starValueFormoney').raty({
                readOnly: true,
                score: vfmRating,
                starHalf: 'Rating/star-half.png',
                starOff: 'Rating/star-off.png',
                starOn: 'Rating/star-on.png',
                width: 170
            });
            $('#starBehavior').raty({
                readOnly: true,
                score: behaviorRating,
                starHalf: 'Rating/star-half.png',
                starOff: 'Rating/star-off.png',
                starOn: 'Rating/star-on.png',
                width: 170
            });

            $('#StarBehaviorReview').raty({
                readOnly: false,
                score: 0,
                starHalf: 'Rating/star-half-big.png',
                starOff: 'Rating/star-off-big.png',
                starOn: 'Rating/star-on-big.png',
                width: 170
            });

            $('#StarValueFormoneyReview').raty({
                readOnly: false,
                score: 0,
                starHalf: 'Rating/star-half-big.png',
                starOff: 'Rating/star-off-big.png',
                starOn: 'Rating/star-on-big.png',
                width: 170
            });

            $('#StarQuantityReview').raty({
                readOnly: false,
                score: 0,
                starHalf: 'Rating/star-half-big.png',
                starOff: 'Rating/star-off-big.png',
                starOn: 'Rating/star-on-big.png',
                width: 170
            });

            $('#StarTasteReview').raty({
                readOnly: false,
                score: 0,
                starHalf: 'Rating/star-half-big.png',
                starOff: 'Rating/star-off-big.png',
                starOn: 'Rating/star-on-big.png',
                width: 170
            });

            if ($("#ListingVisibiltyHiddenField").val() == "true") {
                $("#OrderButton").prop('value', "Complete the listing to order");
                $("#SubmitRatingButton").prop('value', "Complete the listing for rating");
            }
            else if ($("#UserLoggedInHiddenField").val() != "true") {
                $("#OrderButton").prop('value', "log-in to order");
                $("#SubmitRatingButton").prop('value', "log-in to submit rating");
            }


            if ($("#OtherListingHiddenField").val() == "false") {
                $("#OtherListingDiv").css("display", "none");
            }

            if ($("#SimilarlistingHiddenField").val() == "false") {
                $("#SimilarListingDiv").css("display", "none");
            }

            if ($("#SideListingTabHiddenField").val() == "false") {
                $("#RecommendedSideDishHyperlink").css("display", "none");
            }

            if ($("#ReviewTabHiddenField").val() == "false") {
                $("#WriteReviewHyperlink").tab('show');
                $("#listingReviewHyperlink").css("display", "none");
            }

            $(".tm-MainIngredient").tagsManager({ maxTags: 1, prefilled: [$("#HiddenFieldMainIngredients").val()] });
            $(".tm-SubIngredient").tagsManager({ prefilled: $("#HiddenFieldSubIngredients").val().split(',') });

        });
    </script>
    <script type="text/javascript">
        function initializeMap() {

            var lat = latlang[0];
            var lang = latlang[1];
            var settingsItemsMap = {
                zoom: 13,
                center: new google.maps.LatLng(lat, lang),
                zoomControlOptions: {
                    style: google.maps.ZoomControlStyle.LARGE
                },
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            var map = new google.maps.Map(document.getElementById('map_canvas'), settingsItemsMap);

            var myMarker = new google.maps.Marker({
                position: new google.maps.LatLng(lat, lang),
                draggable: false
            });

            // Add a Circle overlay to the map.
            var circle = new google.maps.Circle({
                map: map,
                radius: 1000 // 3000 km
            });

            circle.bindTo('center', myMarker, 'position');

            map.setCenter(myMarker.position);
            myMarker.setMap(map);
        }
    </script>
</body>
</html>
<script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
