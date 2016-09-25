<%@ Page Title="" Language="C#" ClientIDMode="Static"  AutoEventWireup="true"
    CodeBehind="ListingNewTitleDescription.aspx.cs" Inherits="KhanawalApplication.ListingNewTitleDescription" %>
    <%@ Register Src="TopNavigationUserControl.ascx" TagName="TopNavigationUserControl"
    TagPrefix="ucTopNavigation" %>
	
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
	<title></title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script> window.jQuery || document.write('<script src="js/vendor/jquery-1.8.2.min.js"><\/script>')</script>
    <script src="js/vendor/bootstrap.min.js"></script>
    
    <script src="js/vendor/modernizr-2.6.1-respond-1.1.0.min.js"></script>
    
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    
    <link href="css/Custom.css" rel="stylesheet" type="text/css" />
    <link href="themes/default/default.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.validate.min.js" type="text/javascript"></script>
    <!--[if lt IE 9]>
    <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
  <![endif]-->
   <style>
        .BorderBox {
            border-style: solid; 
            border-width: 1px; 
            border-color: #D4D4D4
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="form-class">
        <ucTopNavigation:TopNavigationUserControl IsAuthenticated="True" ID="TopNavigationUserControl1" HasPermissionOnCurrentListing="True" runat="server" />
        <div class="container" style="margin-top: 60px;">
        <div id="blockTitle" class="navbar-inner" align="center">
            <h4>
                Title and Description</h4>
        </div>
        <div style="width: 217px;" class="well pull-left">
            <ul class="nav nav-list">
                
                <li><a runat="server" id="ManageListingHyperlink" href="ManageListing.aspx"><i class="icon-edit"></i><b>Manage your Dish</b>&nbsp;<i
                    runat="server" id="listingCompletionCount" class="badge badge-important">5</i></a></li>
                <li class="active"><a href="ListingNewTitleDescription.aspx" runat="server" id="NameAndDescriptionHyperlink" ><i class="icon-text-width"></i><b>Name and Description</b></a></li>
                <li><a href="ListingNewCatIngredients.aspx" runat="server" id="ListingCatAndIngredientsHyperlink" ><i class="icon-tag"></i><b>Category and Ingredients</b></a></li>
                <li><a href="ListingNewPhotos.aspx" runat="server" id="ListingPhotosHyperlink" ><i class="icon-picture"></i><b>Photos</b></a></li>
                <li><a href="ListingNewLocationPricing.aspx" runat="server" id="ListingLocationAndPricingHyperlink" ><i class="icon-home"></i><b>Pickup location & Cost</b></a></li>
                <li><a href="ListingsAdditionalOption.aspx" runat="server" id="listingAdditionalHyperlink" ><i class="icon-th-list"></i><b>Additional options</b></a></li>
            
            </ul>
        </div>
        <div class="pull-left" style="margin-top: 10px">
            <div class="form-horizontal" style="margin-top: 10px">
                <div class="control-group">
                    <label class="control-label" for="DishNameTextBox">
                        Dish Name</label>
                    <div class="controls">
                        <asp:TextBox runat="server" custom-validate="true" custom-required="true" MaxLength="25" custom-minlength="5" Width="300px" ID="DishNameTextBox">
                            
                        </asp:TextBox>
                        <label for="DishNameTextBox" style="display: none" generated="true" class="error">
                            Ok</label>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="DishDescriptionTextBox">
                        Dish Description</label>
                    <div class="controls">
                        <asp:TextBox custom-validate="true" custom-minlength="25" 
                            custom-required="true" runat="server" ID="DishDescriptionTextBox" Rows="20"
                            Columns="40" Width="500px" Height="250px" TextMode="MultiLine" 
                            ></asp:TextBox>
                        <label for="DishDescriptionTextBox" style="display: none" generated="true" class="error">
                            Ok</label>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="DishTypeDropDownList">
                        Veg or Non-Veg</label>
                    <div class="controls">
                        <asp:DropDownList custom-validate="true" runat="server" ID="DishTypeDropDownList"
                            Width="220px" ClientIDMode="Static">
                            <asp:ListItem Value="">-- Select Veg or Non Veg --</asp:ListItem>
                            <asp:ListItem Value="Veg">Veg</asp:ListItem>
                            <asp:ListItem Value="NonVeg">Non veg</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="PeopleDropDownList">
                        People <i class="icon-question-sign" rel="tooltip" title="How many people can sufficiently eat in a single dish">
                        </i>
                    </label>
                    <div class="controls">
                        <asp:DropDownList runat="server" ID="PeopleDropDownList" custom-validate="true" custom-required="true">
                            <asp:ListItem Value="" Selected="True">-- Select --</asp:ListItem>
                            <asp:ListItem Value="1">1</asp:ListItem>
                            <asp:ListItem Value="2">2</asp:ListItem>
                            <asp:ListItem Value="3">3</asp:ListItem>
                            <asp:ListItem Value="4">4</asp:ListItem>
                            <asp:ListItem Value="5">5</asp:ListItem>
                            <asp:ListItem Value="5+">5+</asp:ListItem>
                        </asp:DropDownList>
                        <label for="PeopleDropDownList" style="display: none" generated="true" class="error">
                            Ok</label>
                    </div>
                </div>
                <div class="control-group">
                    <div class="controls">
                        <input id="btnSave" type="button" data-loading-text="Please Wait.." data-complete-text="Save" value="Save" class="btn btn-primary" onclick="UpdateListingTitleAndDescription()"/>
                    </div>
                </div>
                <div id="DivStatus" class="">
                    
                </div>              
            </div>
        </div>
    </div>
     
    </form>
    
    <script type="text/javascript">

        function UpdateListingTitleAndDescription() {
            //string dishName, string dishDescription, string peopleCount,string dishType
            if (!$('.form-class').valid()) {
                return false;
            }
           
            $("#btnSave").button('loading');
            var dishName = $("#DishNameTextBox").val().replace(/'/g,"\"");
            var dishDescription = $("#DishDescriptionTextBox").val().replace(/'/g, "\"");
            var peopleCount = $("#PeopleDropDownList").val();
            var dishType = $("#DishTypeDropDownList").val();
            var postData = "{dishName:'" + dishName + "',dishDescription:'" + dishDescription + "',peopleCount:'" + peopleCount + "',dishType:'" + dishType + "'}";

            $.ajax({
                type: "POST",
                url: "ListingNewTitleDescription.aspx/UpdateListingTitleAndDescription",
                data: postData,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    $("#btnSave").button('complete');
                    $("#DivStatus").fadeIn('slow').removeClass("alert-error").addClass("alert alert-success").text("Lisiting details updated successfully").delay(5000).fadeOut();
                },
                error: function (msg) {
                    debugger;
                    $("#btnSave").button('complete');
                    $("#DivStatus").fadeIn('slow').removeClass("alert-success").addClass("alert alert-error").text("Error occured, please try again").delay(5000).fadeOut();
                }
            });
        }

        $(function () {
            $('.form-class').validate({
                ignore: "",
                rules: {
                    DishNameTextBox: { required: true },
                    PeopleDropDownList: { required: true },
                    DishDescriptionTextBox: { required: true },
                    DishTypeDropDownList : {required:true}
                },
                highlight: function (label) {
                    $(label).closest('.control-group').removeClass('success');
                    $(label).closest('.control-group').addClass('error');
                },
                success: function (label) {
                    label
                        .text('OK!').addClass('valid')
                        .closest('.control-group').removeClass('error')
                        .closest('.control-group').addClass('success');
                }
            });
        });
    </script>
</body>
</html>
<script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
