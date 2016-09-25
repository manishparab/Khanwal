<%@ Page Title="" Language="C#" AutoEventWireup="true" EnableEventValidation="false"
    CodeBehind="ListingNewCatIngredients.aspx.cs" ClientIDMode="Static" Inherits="KhanawalApplication.ListingNewCatIngredients" %>


<%@ Register Src="TopNavigationUserControl.ascx" TagName="TopNavigationUserControl"
    TagPrefix="ucTopNavigation" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script src="js/vendor/bootstrap.min.js"></script>
    <script src="js/vendor/modernizr-2.6.1-respond-1.1.0.min.js"></script>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/Custom.css" rel="stylesheet" type="text/css" />
    <link href="themes/default/default.css" rel="stylesheet" type="text/css" />
    <link href="css/select2/select2.css" rel="stylesheet" type="text/css" />
    <script src="js/select2.min.js" type="text/javascript"></script>
    <script src="js/jquery.validate.min.js" type="text/javascript"></script>
    <script src="js/bootstrap-tagmanager.js" type="text/javascript"></script>
    <link href="css/bootstrap-tagmanager.css" rel="stylesheet" type="text/css" />
    <!--[if lt IE 9]>
    <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
  <![endif]-->
    <style>
        .form-helpers
        {
            margin-top: 6px;
            margin-bottom: 4px;
            line-height: 16px;
            color: #c8c8c8;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="form-class">
    <ucTopNavigation:TopNavigationUserControl IsAuthenticated="True" ReloadPage="True"
        HasPermissionOnCurrentListing="True" ID="TopNavigationUserControl1" runat="server" />
    <div class="container" style="margin-top: 60px;">
        <div id="blockTitle" class="navbar-inner" align="center">
            <h4>
                Category and Ingredients</h4>
        </div>
        <div style="width: 225px;" class="well pull-left">
            <ul class="nav nav-list">
                <li><a runat="server" id="ManageListingHyperlink" href="ManageListing.aspx"><i class="icon-edit">
                </i><b>Manage your Dish</b>&nbsp;<i runat="server" id="listingCompletionCount" class="badge badge-important">5</i></a></li>
                <li><a href="ListingNewTitleDescription.aspx" runat="server" id="NameAndDescriptionHyperlink">
                    <i class="icon-text-width"></i><b>Name and Description</b></a></li>
                <li class="active"><a href="ListingNewCatIngredients.aspx" runat="server" id="ListingCatAndIngredientsHyperlink">
                    <i class="icon-tag"></i><b>Category and Ingredients</b></a></li>
                <li><a href="ListingNewPhotos.aspx" runat="server" id="ListingPhotosHyperlink"><i
                    class="icon-picture"></i><b>Photos</b></a></li>
                <li><a href="ListingNewLocationPricing.aspx" runat="server" id="ListingLocationAndPricingHyperlink">
                    <i class="icon-home"></i><b>Pickup location and Pricing</b></a></li>
                <li><a href="ListingsAdditionalOption.aspx" runat="server" id="listingAdditionalHyperlink">
                    <i class="icon-th-list"></i><b>Additional options</b></a></li>
            </ul>
        </div>
        <div class="pull-left" style="margin-top: 10px; width: 70%">
            <div class="form-horizontal">
                <div class="alert alert-info" style="margin-left: 20px;">
                    <b>Newly added main ingredients and sub ingredients will only appear once the listing
                        is validated.</b>
                </div>
                <div class="control-group">
                    <label class="control-label" for="TasteDropDownList">
                        Taste
                    </label>
                    <div class="controls">
                        <asp:DropDownList custom-validate="true" runat="server" ID="TasteDropDownList" Width="220px"
                            ClientIDMode="Static">
                        </asp:DropDownList>
                        <div class="form-helpers">
                            How is your dish, is it spicy or sweet or something else..
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="RecipetypeDropDownList">
                        Recipe type
                    </label>
                    <div class="controls">
                        <asp:DropDownList custom-validate="true" runat="server" ID="RecipetypeDropDownList"
                            Width="220px" ClientIDMode="Static">
                        </asp:DropDownList>
                        <div class="form-helpers">
                            Is it starter or main dish.
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="CuisineTypeDropDownList">
                        Cuisine Type
                    </label>
                    <div class="controls">
                        <asp:DropDownList custom-validate="true" runat="server" ID="CuisineTypeDropDownList"
                            Width="220px" ClientIDMode="Static">
                        </asp:DropDownList>
                        <div class="form-helpers">
                            select Cuisine type for eg punjabi.
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="MainIngredientDropDownList">
                        Main Ingredient <i class="icon-question-sign" rel="tooltip" title="What will be the main ingredient in the food, for eg : chiken tikka has chiken as main ingredient">
                        </i>
                    </label>
                    <div class="controls">
                        <input type="text" id="MainIngredient" name="MainIngredient" placeholder="Main Ingredient"
                            class="tm-MainIngredient tm-input tm-input-success" />
                        <asp:HiddenField runat="server" ID="HiddenFieldMainIngredients" />
                        <div class="form-helpers">
                            whats the main Ingredient you have used in your dish, you can only enter one main
                            ingredient. Please press enter or Tab after entering main ingredient.
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="SubIngredientTextBox">
                        Sub Ingredient <i class="icon-question-sign" rel="tooltip" title="What will be the sub ingredients in the food, for eg : Dal tadka has ginger as sub ingredient">
                        </i>
                    </label>
                    <div class="controls">
                        <input type="text" id="SubIngredient" name="SubIngredient" placeholder="Sub Ingredient's"
                            class="tm-SubIngredient tm-input tm-input-success tm-input-small" />
                        <asp:HiddenField runat="server" ID="HiddenFieldSubIngredients" />
                        <div class="form-helpers">
                            Please press enter or Tab after entering sub ingredient.
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <div class="controls">
                        <input id="btnSave" type="button" data-loading-text="Please Wait.." data-complete-text="Save"
                            value="Save" class="btn btn-primary" onclick="SaveCategoryAndIngredients()" />
                    </div>
                </div>
                <div class="control-group">
                    <div id="DivStatus">
                    </div>
                </div>
            </div>
        </div>
    </div>
   
    </form>
    <script type="text/javascript">
        var subIngredientsDropDownListVal = "";
        var mainIngredientsDropDownListVal = "";


        $(function () {
            $.validator.addMethod('ValidateTaste',
            function (value) {
                var returnValue = false;
                if ($("#TasteDropDownList").val() > 0) {
                    returnValue = true;
                }
                return returnValue;
            }, 'Please select taste');

            $.validator.addMethod('ValidateCuisine',
            function (value) {
                var returnValue = false;
                if ($("#CuisineTypeDropDownList").val() > 0) {
                    returnValue = true;
                }
                return returnValue;
            }, 'Please select Cuisine Type');

            $.validator.addMethod('ValidateRecipe',
            function (value) {
                var returnValue = false;
                if ($("#RecipetypeDropDownList").val() > 0) {
                    returnValue = true;
                }
                return returnValue;
            }, 'Please select taste');

            $.validator.addMethod('ValidateMainIngredient',
            function (value) {
                var returnValue = false;
                if ($('input[name="hidden-MainIngredient"]').val().length > 0) {
                    returnValue = true;
                }
                return returnValue;
            }, 'Please select main ingredient');


            $('.form-class').validate({
                ignore: '',
                rules: {
                    TasteDropDownList: { ValidateTaste: true },
                    RecipetypeDropDownList: { ValidateRecipe: true },
                    CuisineTypeDropDownList: { ValidateCuisine: true },
                    MainIngredient: { ValidateMainIngredient: true }
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

            $("#TasteDropDownList").select2();
            $("#RecipetypeDropDownList").select2();
            $("#CuisineTypeDropDownList").select2();
            $(".tm-MainIngredient").tagsManager({ maxTags: 1, prefilled: [$("#HiddenFieldMainIngredients").val()] });
            $(".tm-SubIngredient").tagsManager({ prefilled: $("#HiddenFieldSubIngredients").val().split(',') });


        });


        function SaveCategoryAndIngredients() {
            //SaveCategoryAndIngredients(string tasteId, string recipeTypeId, string cusineTypeId,string mainIngredients, string subIngredients)
            if (!$('.form-class').valid()) {
                return false;
            }

            $("#btnSave").button('loading');

            var tasteId = $("#TasteDropDownList").val();
            var recipeTypeId = $("#RecipetypeDropDownList").val();
            var cusineTypeId = $("#CuisineTypeDropDownList").val();
            var subIngredients = $('input[name="hidden-SubIngredient"]').val();
            var mainIngredients = $('input[name="hidden-MainIngredient"]').val();

            var postData = "{tasteId:'" + tasteId + "',recipeTypeId:'" + recipeTypeId + "',cusineTypeId:'" + cusineTypeId + "',mainIngredient:'" + mainIngredients + "',subIngredients:'" + subIngredients + "'}";

            $.ajax({
                type: "POST",
                url: "ListingNewCatIngredients.aspx/SaveCategoryAndIngredients",
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

        function format(sideDish) {
            var originalOption = sideDish.element;
            return "<div><b>" + sideDish.text + "</b><small>" + " (" + $(originalOption).data('descfull') + ")</small></div>";

        }

       

      
    </script>
</body>
</html>
<script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
