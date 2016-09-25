<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="ListingNewLocationPricing.aspx.cs"
    Inherits="KhanawalApplication.ListingNewLocationPricing" %>

<%@ Register Src="TopNavigationUserControl.ascx" TagName="TopNavigationUserControl"
    TagPrefix="ucTopNavigation" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script src="js/jquery.validate.min.js" type="text/javascript"></script>
    <script src="js/vendor/bootstrap.min.js"></script>
    <!--[if lt IE 9]>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?v=3&sensor=true"></script>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/Custom.css" rel="stylesheet" type="text/css" />
    <link href="css/datepicker.css" rel="stylesheet" type="text/css" />
    <link href="css/select2/select2.css" rel="stylesheet" type="text/css" />
    <script src="js/select2.min.js" type="text/javascript"></script>
    <style type="text/css">
        .form-helpers
        {
            margin-top: 6px;
            margin-bottom: 4px;
            line-height: 16px;
            color: #c8c8c8;
        }
        #map_canvas
        {
            height: 300px;
        }
        #map_canvas_postal
        {
            width: auto;
            height: 300px;
            display: none;
            margin-bottom: 10px;
        }
        #map_verified_AddRess
        {
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="form-horizontal">
    <ucTopNavigation:TopNavigationUserControl HasPermissionOnCurrentListing="True" IsAuthenticated="True" ReloadPage="True" ID="TopNavigationUserControl1" runat="server" />
    <div class="container" style="margin-top: 60px;">
        <div id="blockTitle" class="navbar-inner" align="center">
            <h4>
                Pickup location & Pricing</h4>
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
                <li class="active"><a href="ListingNewLocationPricing.aspx" runat="server" id="ListingLocationAndPricingHyperlink">
                    <i class="icon-home"></i><b>Pickup location and Pricing</b></a></li>
                <li><a href="ListingsAdditionalOption.aspx" runat="server" id="listingAdditionalHyperlink">
                    <i class="icon-th-list"></i><b>Additional options</b></a></li>
            </ul>
        </div>
        <div class="pull-left" style="margin-top: 10px; width: 720px; margin-left: 10px;">
            <div class="form-horizontal">
                <div class="control-group">
                    <label class="control-label" for="CostTextBox">
                        Dish Cost</label>
                    <div class="controls">
                        <asp:TextBox runat="server" ID="CostTextBox" Rows="20" Columns="40"></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="PickUpLocation">
                        Use home address as pick up location?<i class="icon-question-sign" rel="tooltip"
                            title="are you going use your home addess as the pick up address, or you want to specify some other address, your browser may ask request to share your current location"></i>
                    </label>
                    <div class="controls">
                        <div style="float: left">
                            <label class="radio" style="float: left; margin-right: 10px;">
                                <asp:RadioButton Text="Yes" GroupName="PickUplocation" runat="server" ID="PickUplocationCheckBox"
                                    Checked="True" ClientIDMode="Static" />
                            </label>
                            <label class="radio" style="float: left;">
                                <asp:RadioButton runat="server" Text="No" GroupName="PickUplocation" ID="PickUplocationNoCheckBox"
                                    ClientIDMode="Static" />
                            </label>
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="UserAddressTextBox">
                        Your Address
                    </label>
                    <div class="controls">
                        <ul class="nav nav-pills" id="UserLocation">
                            <li class="active"><a href="#UserPostalStyle" id="UserPostalStyleHyperlink" data-toggle="tab">
                                Postal Style</a> </li>
                            <li><a href="#UserMapStyle" id="UserMapStyleHyperlink" data-toggle="tab">Map Style</a></li>
                        </ul>
                        <div class="tab-content" style="width: 520px">
                            <div id="UserPostalStyle" class="tab-pane active">
                                <div class="control-group">
                                    <label class="control-label" for="UserAddressAddressLine1" style="width: 120px;">
                                        Address Line 1 :
                                    </label>
                                    <div class="controls" style="margin-left: 140px">
                                        <asp:TextBox runat="server" ID="UserAddressAddressLine1" Width="350px"></asp:TextBox>
                                        <div class="form-helpers">
                                            your unit number, building number, society number
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="UserAddressAddressLine2" style="width: 120px;">
                                        Address Line 2 :
                                    </label>
                                    <div class="controls" style="margin-left: 140px">
                                        <asp:TextBox runat="server" ID="UserAddressAddressLine2" Width="350px"></asp:TextBox>
                                        <div class="form-helpers">
                                            street name, Area Name
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="UserAddressAddressPostalCode" style="width: 120px;">
                                        Postal Code :
                                    </label>
                                    <div class="controls" style="margin-left: 140px">
                                        <asp:TextBox runat="server" ID="UserAddressAddressPostalCode" Width="350px"></asp:TextBox>
                                        <div class="form-helpers">
                                            Postal code/ Pin code
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="UserCityDropDownList" style="width: 120px;">
                                        City :
                                    </label>
                                    <div class="controls" style="margin-left: 140px">
                                        <asp:DropDownList AppendDataBoundItems="true" runat="server" DataTextField="city_name"
                                            Width="350px" DataValueField="city_id" ID="UserCityDropDownList" />
                                        <div class="form-helpers">
                                            your city
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="UserStateDropDownList" style="width: 120px;">
                                        State :
                                    </label>
                                    <div class="controls" style="margin-left: 140px">
                                        <asp:DropDownList DataValueField="ID" Width="350px" DataTextField="Name" runat="server"
                                            ID="UserStateDropDownList" />
                                        <div class="form-helpers">
                                            your state
                                        </div>
                                    </div>
                                </div>
                                <input type="button" value="Verify your address" onclick="ViewPostalMap()" class="btn btn-primary" />
                                <div id="map_verified_AddRess">
                                </div>
                                <div id="map_canvas_postal">
                                </div>
                            </div>
                            <div id="UserMapStyle" class="tab-pane">
                                <div class="control-group">
                                    <label class="control-label" for="UserAddressAddressLine2" style="width: 120px;">
                                        Home Address :
                                    </label>
                                    <div class="controls" style="margin-left: 140px">
                                        <input type="checkbox" checked="checked" id="CurrentlocationAsHomeAddress" onclick="SetDefaultMapLocation(this)" />
                                        Use Current location as pickup address.
                                        <div class="form-helpers">
                                            your current location will be determined from browser, depeding on preferances your
                                            browser might ask for your permission
                                        </div>
                                    </div>
                                </div>
                                <div id="NavigatorNotSuported" class="alert alert-danger" style="display: none">
                                    Geolocation is not supported for this Browser/OS version yet.you need manually select
                                    your address on map or you can use postal style address
                                </div>
                                <div id="UserCurrentAddress" class="alert alert-info">
                                </div>
                                <div id="map_canvas">
                                </div>
                            </div>
                        </div>
                        <asp:HiddenField runat="server" ID="latHiddenField" />
                        <asp:HiddenField runat="server" ID="lngHiddenField" />
                        <asp:HiddenField runat="server" ID="AddressHiddenField" />
                        <asp:HiddenField runat="server" ID="AddressStyleHiddenField" Value="postal" />
                    </div>
                </div>
                <div class="control-group">
                    <div class="controls">
                        <input onclick="SaveLocationAndPricing()" data-loading-text="Please Wait.." data-complete-text="Save"
                            type="button" id="btnSave" value="Save" class="btn btn-primary pull-right" />
                    </div>
                </div>
                <div class="control-group">
                    <div id="DivStatus" class="">
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    </form>
    <script type="text/javascript">
        var userLocationPostalPreferance = true;
        var userLocationValidationMessage = "";
        var userAddressVerified = false;

        function codeLatLng(lat, lng) {
            var geocoder = new google.maps.Geocoder();
            var latlng = new google.maps.LatLng(lat, lng);
            geocoder.geocode({ 'latLng': latlng }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    if (results[1]) {
                        $("#AddressHiddenField").val(results[0].formatted_address);
                        $("#UserCurrentAddress").html("Current Address : <b>" + results[0].formatted_address + "</b>");
                        $("#map_verified_AddRess").html("Current Address : <b>" + results[0].formatted_address + "</b>");
                    }
                }
            });
        }

        function ViewPostalMap() {
            $("#UserAddressAddressLine1").valid();
            $("#UserAddressAddressLine2").valid();
            //            $("#UserAddressAddressPostalCode").valid();
            var address = "";
            var addressLine1 = $("#UserAddressAddressLine1").val();
            var addressLine2 = $("#UserAddressAddressLine2").val();
            var postalCode = $("#UserAddressAddressPostalCode").val();
            var city = $("#UserCityDropDownList option:selected").text();
            var state = $("#UserStateDropDownList option:selected").text();
            address = postalCode + "," + city + "," + state + "," + addressLine2 + "," + addressLine1;
            //alert(address);
            codeAddress(address);
        }


        function codeAddress(address) {
            var geocoder = new google.maps.Geocoder();
            geocoder.geocode({ 'address': address }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    userAddressVerified = true;
                    $("#map_verified_AddRess").addClass("alert alert-info");
                    $("#map_verified_AddRess").text(results[0].formatted_address);
                    $("#map_canvas_postal").show();
                    setPostionOnMap(results[0].geometry.location.lat(), results[0].geometry.location.lng(), "map_canvas_postal");
                    $("#latHiddenField").val(results[0].geometry.location.lat());
                    $("#lngHiddenField").val(results[0].geometry.location.lng());
                } else {
                    //alert("Geocode was not successful for the following reason: " + status);
                    alert("your address is not validated, please corret your address and validate again");
                }
            });
        }

        function SaveLocationAndPricing() {
            $("#btnSave").button('loading');
            if ($(".form-horizontal").valid()) {
                if (!userAddressVerified && userLocationPostalPreferance) {
                    alert("you have not verified your address,please verify");
                    $("#btnSave").button('complete');
                    return true;
                }

                var lat = $("#latHiddenField").val();
                var lang = $("#lngHiddenField").val();


                var addressLine1 = $("#UserAddressAddressLine1").val();
                var addressLine2 = $("#UserAddressAddressLine2").val();
                var postalCode = $("#UserAddressAddressPostalCode").val();
                var city = $("#UserCityDropDownList").val();
                var state = $("#UserStateDropDownList").val();
                var isPostalStyleSelected = $("#AddressStyleHiddenField").val();
                var costTextBox = $("#CostTextBox").val();

                var homeAddressSelected = 0;

                if ($("#PickUplocationCheckBox").attr("checked") != "undefined" && $("#PickUplocationCheckBox").attr("checked") == "checked") {
                    homeAddressSelected = 1;
                }

                var postData = "{lattitude:'" + lat + "',longitude:'" + lang + "',postalCode:'" + postalCode + "',addressLine1:'" + addressLine1 + "',addressLine2:'" + addressLine2 + "',cityId:'" + city + "',stateId:'" + state + "',isPostalStyleSelected:'" + isPostalStyleSelected + "',cost:'" + costTextBox + "'" + ",homeAddressAsPickUpLocation:'" + homeAddressSelected + "' }";

                $.ajax({
                    type: "POST",
                    url: "ListingNewLocationPricing.aspx/SaveLocationAndPricing",
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

            } else {
                $("#btnSave").button('complete');
                $("#DivStatus").fadeIn('slow').removeClass("alert-success").addClass("alert alert-error").text("Please fill form correctly, and then save").delay(5000).fadeOut();
            }
        }

        function SetDefaultMapLocation(checkbox) {
            if (checkbox.checked) {
                initializeMap(true);
            }
        }

        function CheckifWeNeedInitializeMap(hyperlink) {
            if (hyperlink.attr("href") == "#UserMapStyle") {
                $("#AddressStyleHiddenField").val("map");
                userLocationPostalPreferance = false;
                $("#UserAddressAddressLine2").addClass("ignore");
                $("#UserCityDropDownList").addClass("ignore");
                $("#UserStateDropDownList").addClass("ignore");
                $("#AddressHiddenField").removeClass("ignore");

               
                
                if ($("#latHiddenField").val().length > 0 && $("#lngHiddenField").val().length > 0) {
                    $("#CurrentlocationAsHomeAddress").attr('checked', false);
                    initializeMap(false);
                } else {
                    $("#CurrentlocationAsHomeAddress").attr('checked', true);
                    initializeMap(true);
                }

            } else {
                userLocationPostalPreferance = true;
                $("#AddressStyleHiddenField").val("postal");
                $("#UserAddressAddressLine2").removeClass("ignore");
                $("#UserCityDropDownList").removeClass("ignore");
                $("#UserStateDropDownList").removeClass("ignore");
                $("#AddressHiddenField").addClass("ignore");
            }
        }

        function setPostionOnMap(lattitue, longitude, mapCanvasId) {
            var map;
            codeLatLng(lattitue, longitude);
            var myOptions = {
                zoom: 15,
                center: new google.maps.LatLng(lattitue, longitude),
                zoomControlOptions: {
                    style: google.maps.ZoomControlStyle.LARGE
                },
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };

            map = new google.maps.Map(document.getElementById(mapCanvasId), myOptions);

            var myMarker = new google.maps.Marker({
                position: new google.maps.LatLng(lattitue, longitude),
                draggable: true
            });

            google.maps.event.addListener(myMarker, 'dragend', function () {
                $("#latHiddenField").val(myMarker.position.lat());
                $("#lngHiddenField").val(myMarker.position.lng());
                codeLatLng(myMarker.position.lat(), myMarker.position.lng());
            });

            // Add a Circle overlay to the map.
            var circle = new google.maps.Circle({
                map: map,
                radius: 500 // 3000 km
            });

            circle.bindTo('center', myMarker, 'position');

            map.setCenter(myMarker.position);
            myMarker.setMap(map);
        }



        function initializeMap(getCurrentLocation) {
            var lattitue;
            var longitude;
            var map;
            if (getCurrentLocation) {
                if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(function (position) {
                        lattitue = position.coords.latitude;
                        longitude = position.coords.longitude;
                        $("#latHiddenField").val(lattitue);
                        $("#lngHiddenField").val(longitude);
                        setPostionOnMap(lattitue, longitude, "map_canvas");
                    });
                }
            } else {
                lattitue = $("#latHiddenField").val();
                longitude = $("#lngHiddenField").val();
                setPostionOnMap(lattitue, longitude, "map_canvas");
            }
        }

        function showPosition(position) {
            //x.innerHTML = "Latitude: " + position.coords.latitude + "<br>Longitude: " + position.coords.longitude;
        }

        $(function () {

            if ($("#AddressStyleHiddenField").val() == "postal") {
                $("#UserPostalStyleHyperlink").tab('show');

                userLocationPostalPreferance = true;

                $("#UserAddressAddressLine2").removeClass("ignore");
                $("#UserCityDropDownList").removeClass("ignore");
                $("#UserStateDropDownList").removeClass("ignore");
                $("#AddressHiddenField").addClass("ignore");

            } else {
                $("#UserMapStyleHyperlink").tab("show");

                userLocationPostalPreferance = false;
                $("#UserAddressAddressLine2").addClass("ignore");
                $("#UserCityDropDownList").addClass("ignore");
                $("#UserStateDropDownList").addClass("ignore");
                $("#AddressHiddenField").removeClass("ignore");

                if ($("#latHiddenField").val().length > 0 && $("#lngHiddenField").val().length > 0) {
                    $("#CurrentlocationAsHomeAddress").attr('checked', false);
                    initializeMap(false);
                } else {
                    $("#CurrentlocationAsHomeAddress").attr('checked', true);
                    initializeMap(true);
                }
            }

            $('#UserLocation a').click(function (e) {
                e.preventDefault();
                $(this).tab('show');
                CheckifWeNeedInitializeMap($(this));
            });

            $.validator.addMethod('positiveNumber',
    function (value) {
        return parseInt(value) > 0;
    }, 'Enter proper cost, decimal places like 10.50 are not allowed');

            $.validator.addMethod('UserAddressLineValidation',
                 function (value) {
                     if ($("#UserAddressAddressLine1").val().length > 0 || $("#UserAddressAddressLine2").val().length > 0) {
                         return true;
                     } else {
                         return false;
                     }
                 }, 'Atleast one address line should be filled.');

            $("#AddressHiddenField").addClass("ignore");


            $('.form-horizontal').validate({
                ignore: ".ignore",
                rules: {
                    CostTextBox: { required: true, positiveNumber: true },
                    AddressHiddenField: { required: true },
                    UserAddressAddressLine2: { UserAddressLineValidation: true },
                    UserCityDropDownList: { required: true },
                    UserStateDropDownList: { required: true }
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
