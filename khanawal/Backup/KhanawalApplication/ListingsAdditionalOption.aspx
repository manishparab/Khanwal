<%@ Page Title="Additional Options" ClientIDMode="Static" Language="C#" AutoEventWireup="true"
    CodeBehind="ListingsAdditionalOption.aspx.cs" Inherits="KhanawalApplication.ListingsAdditionalOption" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="TopNavigationUserControl.ascx" TagName="TopNavigationUserControl"
    TagPrefix="ucTopNavigation" %>
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
    <ucTopNavigation:TopNavigationUserControl HasPermissionOnCurrentListing="True" IsAuthenticated="True" ID="TopNavigationUserControl1" ReloadPage="True"
        runat="server" />
    <div class="container" style="margin-top: 60px;">
        <div id="blockTitle" class="navbar-inner" align="center">
            <h4>
                Additional Options</h4>
        </div>
        <div style="width: 225px;" class="well pull-left">
            <ul class="nav nav-list">
                <li><a runat="server" id="ManageListingHyperlink" href="ManageListing.aspx"><i class="icon-edit">
                </i><b>Manage your Dish</b>&nbsp;<i runat="server" id="listingCompletionCount" class="badge badge-important">5</i></a></li>
                <li><a href="ListingNewTitleDescription.aspx" runat="server" id="NameAndDescriptionHyperlink">
                    <i class="icon-text-width"></i><b>Name and Description</b></a></li>
                <li><a href="ListingNewCatIngredients.aspx" runat="server" id="ListingCatAndIngredientsHyperlink">
                    <i class="icon-tag"></i><b>Category and Ingredients</b></a></li>
                <li><a href="ListingNewPhotos.aspx" runat="server" id="ListingPhotosHyperlink"><i
                    class="icon-picture"></i><b>Photos</b></a></li>
                <li><a href="ListingNewLocationPricing.aspx" runat="server" id="ListingLocationAndPricingHyperlink">
                    <i class="icon-home"></i><b>Pickup location and Pricing</b></a></li>
                <li class="active"><a href="ListingsAdditionalOption.aspx" runat="server" id="listingAdditionalHyperlink">
                    <i class="icon-th-list"></i><b>Additional options</b></a></li>
            </ul>
        </div>
        <div class="pull-left" style="margin-top: 10px">
            <div class="form-horizontal">
                <div class="control-group">
                    <label class="control-label" for="CancellationDropDownList">
                        Cancellation policy</label>
                    <div class="controls">
                        <asp:DropDownList runat="server" ID="CancellationDropDownList">
                        </asp:DropDownList>
                        <div class="form-helpers">
                            Cancellation policy for your listting
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="SideDishes">
                        Provide Side dish for your Dish <i class="icon-question-sign" rel="tooltip" title="Are you going to provide side dish along with the main dish">
                        </i>
                    </label>
                    <div class="controls">
                        <div>
                            <label class="radio inline">
                                <asp:RadioButton GroupName="SideDish" Text="Yes" runat="server" ID="SideDishcheckbox" />
                            </label>
                            <label class="radio inline">
                                <asp:RadioButton GroupName="SideDish" Text="No" Checked="True" runat="server" ID="SideDishNocheckbox" />
                            </label>
                            <asp:HiddenField runat="server" ID="SideListingsHiddenFieldInitial" />
                            <div class="form-helpers">
                                if you have side dishes for your main dish, select them or Add a new side dish
                            </div>
                        </div>
                    </div>
                </div>
                <div class="control-group" id="SideDishValue" style="display: none">
                    <label class="control-label" for="SideDishes">
                        Select or Add Side Dishes <i class="icon-question-sign" rel="tooltip" title="If you have more than one side dish then separate them with semicoloum.">
                        </i>
                    </label>
                    <div class="controls">
                        <input type="text" id="sideListing" name="sideListing" placeholder="Side listing"
                            class="tm-sideListing tm-input tm-input-success tm-input-small" />
                        <asp:HiddenField runat="server" ID="HiddenFieldSideListing" />
                        <div class="form-helpers">
                            Select Side Listing or add your own listing.
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="HomedeliveryCheckbox">
                        Home delivery <i class="icon-question-sign" rel="tooltip" title="Are you going to provide free delivery">
                        </i>
                    </label>
                    <div class="controls">
                        <label class="radio inline">
                            <asp:RadioButton GroupName="HomeDelivery" Text="Yes" runat="server" ID="HomedeliveryCheckbox" />
                        </label>
                        <label class="radio inline">
                            <asp:RadioButton GroupName="HomeDelivery" Text="No" runat="server" Checked="True"
                                ID="HomedeliveryNoCheckbox" />
                        </label>
                        <div class="form-helpers">
                            check yes if you want to give free home delivery at requestors location.
                        </div>
                    </div>
                </div>
                <div class="control-group HomeDeliveryTextboxclass" style="display: none">
                    <label class="control-label" for="HomeDeliveryTextbox">
                        Home delivery charges
                    </label>
                    <div class="controls">
                        <label class="radio" style="padding-left: 0px;">
                            <asp:CheckBox Checked="True" runat="server" ID="HDfreeCheckbox" />
                            Free home delivery.
                        </label>
                        <asp:TextBox runat="server" ID="AdditionalHDChargesTextBox" disabled></asp:TextBox>
                        <span class="help-inline">Mention Charges for the home delivery</span>
                        <asp:HiddenField runat="server" ID="placeHolderforValidation" />
                    </div>
                </div>
                <div class="control-group">
                    <div class="controls">
                        <input type="button" id="btnSave" data-loading-text="Please Wait.." data-complete-text="Save"
                            value="Save" class="btn btn-primary" onclick="SaveListingAdditionalOption()" />
                    </div>
                </div>
                <div class="control-group">
                    <div id="DivStatus">
                    </div>
                </div>
            </div>
        </div>
    </div>
   
    <!-- Modal -->
    </form>
    <script type="text/javascript">

        $(function () {

            $.validator.addMethod('SideListingsValidation',
            function (value) {
                var returnValue = false;
                if ($("#SideDishcheckbox").attr("checked") != "undefined" && $("#SideDishcheckbox").attr("checked") == "checked") {
                    if ($('input[name="hidden-sideListing"]').val().length > 0 || $("#sideListing").val().length > 0) {
                        returnValue = true;
                    } else {
                        returnValue = false;
                    }
                } else {
                    returnValue = true;
                }
                return returnValue;
            }, 'Please enter your side dish');
            
            $.validator.addMethod('AdditionalHDCharges',
            function (value) {
                var returnValue = false;
                if ($("#HomedeliveryCheckbox").attr("checked") != "undefined" && $("#HomedeliveryCheckbox").attr("checked") == "checked") {
                    if ($("#AdditionalHDChargesTextBox").val().length > 0 || $("#HDfreeCheckbox").attr("checked") == "checked") {
                        returnValue = true;
                    } else {
                        returnValue = false;
                    }
                } else {
                    returnValue = true;
                }
                return returnValue;
            }, 'Enter your changes for the home delivery');

            $('.form-class').validate({
                ignore: '',
                rules: {
                    CancellationDropDownList: { required: true },
                    placeHolderforValidation: { AdditionalHDCharges: true },
                    HiddenFieldSideListing: { SideListingsValidation: true }
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

            $("#HDfreeCheckbox").change(function () {
                if ($(this).is(':checked')) {
                    $("#AdditionalHDChargesTextBox").attr("disabled", "");

                } else {

                    $("#AdditionalHDChargesTextBox").removeAttr("disabled");

                }
            });

            $("#SideDishcheckbox, #SideDishNocheckbox").change(function () {
                if ($("#SideDishcheckbox").is(':checked')) {
                    $("#SideDishValue").show();
                    $("#sideDishesTextBox").removeAttr("disabled");
                } else {
                    $("#SideDishValue").hide();
                    $("#sideDishesTextBox").attr("disabled", "");
                }
            });

            $("#HomedeliveryCheckbox, #HomedeliveryNoCheckbox").change(function () {
                if ($("#HomedeliveryCheckbox").is(':checked')) {
                    $(".HomeDeliveryTextboxclass").show();
                } else {
                    $(".HomeDeliveryTextboxclass").hide();
                }
            });

            // Intialise form
            $("#SideDishcheckbox").trigger('change');
            $("#HomedeliveryCheckbox").trigger('change');
            $("#HDfreeCheckbox").trigger('change');
            $(".tm-sideListing").tagsManager({ prefilled: $("#HiddenFieldSideListing").val().split(',') });
        });



        function SaveListingAdditionalOption() {

            if (!$('.form-class').valid()) {
                return false;
            }

            $("#btnSave").button('loading');

            var sideDishNames = $('input[name="hidden-sideListing"]').val();

            if (sideDishNames.length == 0) {
                sideDishNames = $("#sideListing").val();
            }

            

            var sideDishcheckboxVal = "";
            if ($("#SideDishcheckbox").attr("checked") != "undefined" && $("#SideDishcheckbox").attr("checked") == "checked") {
                sideDishcheckboxVal = "true";
            } else {
                sideDishcheckboxVal = "false";
            }

            var homedeliveryCheckboxVal = "";
            if ($("#HomedeliveryCheckbox").attr("checked") != "undefined" && $("#HomedeliveryCheckbox").attr("checked") == "checked") {
                homedeliveryCheckboxVal = "true";
            } else {
                homedeliveryCheckboxVal = "false";
            }

            var freeHomeDelivery = "";
            if ($("#HDfreeCheckbox").attr("checked") != "undefined" && $("#HDfreeCheckbox").attr("checked") == "checked") {
                freeHomeDelivery = "true";
            } else {
                freeHomeDelivery = "false";
            }


            var homeDeliveryCharges = $("#AdditionalHDChargesTextBox").val();
            if (!homeDeliveryCharges) {
                homeDeliveryCharges = "0";
            }
            var cancellationId = $("#CancellationDropDownList").val();

            var postData = "{sideDishProvided:'" + sideDishcheckboxVal + "',sidelistingsNames:'" + sideDishNames + "',homeDelivery:'" + homedeliveryCheckboxVal + "',freeHomeDelivery:'" + freeHomeDelivery + "',homeDeliveryCharges:" + homeDeliveryCharges + ",cancellationId:" + cancellationId + "}";


            $.ajax({
                type: "POST",
                url: "ListingsAdditionalOption.aspx/SaveListingAdditionalOption",
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


    </script>
</body>
</html>
<script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
