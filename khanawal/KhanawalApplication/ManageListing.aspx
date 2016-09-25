<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="ManageListing.aspx.cs"
    Inherits="KhanawalApplication.ManageListing" %>

<%@ Register Src="TopNavigationUserControl.ascx" TagName="TopNavigationUserControl"
    TagPrefix="ucTopNavigation" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script src="js/vendor/bootstrap.min.js"></script>
    <script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/Custom.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <ucTopNavigation:TopNavigationUserControl  ID="TopNavigationUserControl1" runat="server" />
    <div class="container" style="margin-top: 60px;">
        <div id="blockTitle" class="navbar-inner" align="center">
            <h4>
                Dish Management</h4>
        </div>
        <div style="width: 225px;" class="well pull-left">
            <ul class="nav nav-list">
                <li class="active"><a runat="server" id="ManageListingHyperlink" href="ManageListing.aspx">
                    <i class="icon-edit"></i><b>Manage your Dish</b>&nbsp;<i runat="server" id="listingCompletionCount"
                        class="badge badge-important">5</i></a></li>
                <li><a href="ListingNewTitleDescription.aspx" runat="server" id="NameAndDescriptionHyperlink">
                    <i class="icon-text-width"></i><b>Name and Description</b></a></li>
                <li><a href="ListingNewCatIngredients.aspx" runat="server" id="ListingCatAndIngredientsHyperlink">
                    <i class="icon-tag"></i><b>Category and Ingredients</b></a></li>
                <li><a href="ListingNewPhotos.aspx" runat="server" id="ListingPhotosHyperlink"><i
                    class="icon-picture"></i><b>Photos</b></a></li>
                <li><a href="ListingNewLocationPricing.aspx" runat="server" id="ListingLocationAndPricingHyperlink">
                    <i class="icon-home"></i><b>Pickup location and Pricing</b></a></li>
                <li><a href="ListingsAdditionalOption.aspx" runat="server" id="listingAdditionalHyperlink">
                    <i class="icon-th-list"></i><b>Additional options</b></a></li>
            </ul>
        </div>
        <div class="pull-left" style="margin-left: 10px; margin-top: 10px; width: 665px">
            <div id="Div1" class="navbar-inner" align="center">
                <h5>
                    <asp:Literal runat="server" ID="ListingStatusLiteral" ></asp:Literal>
                    </h5>
            </div>
            <br />
           
                <ul class="thumbnails">
                    <li class="span3" runat="server" id="ListingTitleAndDesc">
                        <div class="thumbnail">
                            <h4>
                                Title & Description</h4>
                            <p>
                                Write a description of atleast to make your dish more tasty.</p>
                            <p>
                                <a runat="server" id="TitleAndDescHyperLink"  href="#" class="btn btn-info">Add Title & Description</a>
                            </p>
                        </div>
                    </li>
                    <li class="span3" runat="server" id="ListingCatAndIngredients">
                        <div class="thumbnail">
                            <h4>
                                Category & Ingredients</h4>
                            <p>
                                Add Ingredients and category to your dish.</p>
                            <p>
                                <a href="#" runat="server" id="IngredientsHyperLink" class="btn btn-info">Add Ingredients & Category</a>
                            </p>
                        </div>
                    </li>
                    <li class="span3" runat="server" id="ListingPhotos">
                        <div class="thumbnail">
                            <h4>
                                Photos</h4>
                            <p>
                                Add Photos and make your dish look more beautiful.</p>
                            <p>
                                <a href="#" runat="server" id="PhotosHyperlink" class="btn btn-info">Add Photo</a>
                            </p>
                        </div>
                    </li>
                    <li class="span3" runat="server" id="ListingLocationAndPricing">
                        <div class="thumbnail">
                            <h4>
                                Location & Pricing</h4>
                            <p>
                                Add Location where dish can be picked up and whats dish costs.
                            </p>
                            <p>
                                <a href="#" runat="server" id="LocationAndPricinghyerlink" class="btn btn-info">Add location & Pricing</a>
                            </p>
                        </div>
                    </li>
                </ul>
                
           
        </div>
    </div>
    </form>
</body>
</html>
<script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>