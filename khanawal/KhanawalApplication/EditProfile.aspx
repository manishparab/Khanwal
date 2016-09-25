<%@ Page Language="C#" AutoEventWireup="true" ClientIDMode="Static" CodeBehind="EditProfile.aspx.cs"
    Inherits="KhanawalApplication.EditProfile" %>

<%@ Register TagPrefix="ucTopNavigation" TagName="TopNavigationUserControl" Src="~/TopNavigationUserControl.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script src="js/jquery.validate.min.js" type="text/javascript"></script>
    <script src="js/vendor/bootstrap.min.js"></script>
    <script src="js/bootstrap-datepicker.js" type="text/javascript"></script>
    <!--[if lt IE 9]>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?v=3&sensor=true"></script>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/Custom.css" rel="stylesheet" type="text/css" />
    <link href="css/datepicker.css" rel="stylesheet" type="text/css" />
    <link href="css/select2/select2.css" rel="stylesheet" type="text/css" />
    <script src="js/select2.min.js" type="text/javascript"></script>
    <script src="//j.maxmind.com/js/apis/geoip2/v2.0/geoip2.js" type="text/javascript"></script>
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
            width: auto;
            height: 300px;
        }
        #map_canvas_postal
        {
            width: auto;
            height: 300px;
            display: none;
        }
        #map_verified_AddRess
        {
            margin-top: 10px;
        }
        .scrollable_content
        {
            margin-top: 25px;
            overflow: auto;
            width: 100%;
            height: 200px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="form-horizontal">
    <ucTopNavigation:TopNavigationUserControl ReloadPage="true" IsAuthenticated="False"
        ID="TopNavigationUserControl1" runat="server" />
    <div class="container" style="margin-top: 60px">
        <div id="blockTitle" class="navbar-inner" align="left">
            <h4>
                <a href="DashBoard.aspx">DashBoard</a> > Edit Profile</h4>
        </div>
        <div style="width: 217px;" class="well pull-left">
            <ul class="nav nav-list">
                <li class="active"><a href="ListingNewTitleDescription.aspx" runat="server" id="NameAndDescriptionHyperlink">
                    <i class="icon-user"></i><b>Basic Profile</b></a></li>
                <li><a href="EditProfileSocialPreferance.aspx" runat="server" id="SocialPreferancelink">
                    <i class="icon-wrench"></i><b>Social Preferances</b></a></li>
                <li><a href="EditProfileContact.aspx" runat="server" id="EditProfileHyperlink"><i
                    class="icon-envelope"></i><b>Contact</b></a></li>
            </ul>
        </div>
        <div class="pull-left" style="margin-top: 10px; margin-left: 10px; width: 720px">
            <div class="control-group">
                <label class="control-label" for="FirstNameTextBox">
                    First Name</label>
                <div class="controls">
                    <asp:TextBox runat="server" ID="FirstNameTextBox" Width="450px"></asp:TextBox>
                    <div class="form-helpers">
                        your first name eg: manish
                    </div>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="LastNameTextBox">
                    Last Name</label>
                <div class="controls">
                    <asp:TextBox runat="server" ID="LastNameTextBox" Width="450px"></asp:TextBox>
                    <div class="form-helpers">
                        your last name eg: jadhav
                    </div>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="UserGenderDropDownList">
                    I Am
                </label>
                <div class="controls">
                    <asp:DropDownList runat="server" ID="UserGenderDropDownList">
                        <Items>
                            <asp:ListItem Value="" Text="Gender"></asp:ListItem>
                            <asp:ListItem Value="female" Text="Female"></asp:ListItem>
                            <asp:ListItem Value="male" Text="Male"></asp:ListItem>
                        </Items>
                    </asp:DropDownList>
                    <div class="form-helpers">
                        select your gender Male or Female
                    </div>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="BirthDateTextBox">
                    Birth Date
                </label>
                <div class="controls">
                    <asp:TextBox runat="server" ID="BirthDateTextBox" data-date-format="dd-mm-yyyy"></asp:TextBox>
                    <div class="form-helpers">
                        your birth date watch the year.
                    </div>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="EmailAddressTextBox">
                    Email address
                </label>
                <div class="controls">
                    <asp:TextBox runat="server" ID="EmailAddressTextBox" Width="450px"></asp:TextBox>
                    <div class="form-helpers">
                        your email address where all the mails will be send. it will not be displyed or
                        Shared with other users
                    </div>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="PhoneNumberTextBox">
                    Phone Number
                </label>
                <div class="controls">
                    <asp:TextBox runat="server" ID="PhoneNumberTextBox"></asp:TextBox>
                    <div class="form-helpers">
                        your phone number , this will not be displyed or shared with other user
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
                    <div class="tab-content">
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
                                  
                                    <asp:TextBox runat="server" ID="UserCityDropDownList"></asp:TextBox>
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
                                        <asp:TextBox runat="server" ID="UserStateDropDownList"></asp:TextBox>
                                    <div class="form-helpers">
                                        your state
                                    </div>
                                </div>
                            </div>
                            <input type="button" id="VerifyAddressButton" value="Verify your address" data-loading-text="Please Wait.."
                                data-complete-text="Verify your address" onclick="ViewPostalMap()" class="btn btn-primary" />
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
                                    Use Current location as Home Address.
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
                <label class="control-label" for="UserDescriptionTextBox" width="450px">
                    Your Currency Preferance
                </label>
                <div class="controls">
                    <asp:DropDownList runat="server" width="150px" ID="currencyPreferance" DataTextField="Name" DataValueField="Name">
                    </asp:DropDownList>
                    <div class="form-helpers">
                        which currency you are familiar with.
                    </div>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="UserDescriptionTextBox" width="450px">
                    Your Description
                </label>
                <div class="controls">
                    <asp:TextBox runat="server" TextMode="MultiLine" Rows="10" Columns="50" ID="UserDescriptionTextBox"></asp:TextBox>
                    <div class="form-helpers">
                        Describe your self , tell your love about food love, which dish is your favorite,
                        whats the best place have you eaten..or anything interesing about you
                    </div>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="UserDescriptionTextBox" width="450px">
                    Terms And Conditions
                </label>
                <div class="controls">
                    I Aggree to terms and conditions
                    <asp:CheckBox runat="server" ID="TermsCheckBox" name="TermsCheckBox" />
                    <div class="form-helpers">
                        Terms and Conditions for the site
                    </div>
                </div>
            </div>
            <div class="control-group">
                <div id="DivStatus">
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="SaveUserProfileButton">
                </label>
                <div class="controls">
                    <input type="button" id="btnSave" value="Save Profile" data-loading-text="Please Wait.."
                        data-complete-text="Save" class="btn btn-primary" onclick="SaveUserProfile();" />
                </div>
            </div>
        </div>
        <asp:HiddenField runat="server" ID="TempHiddenField" />
    </div>
    </form>
    <script type="text/javascript">
        var userLocationPostalPreferance = true;
        var userLocationValidationMessage = "";
        var userAddressVerified = false;
        var lattitue;
        var longitude;

        $(document).ready(function () {
            if ($("#TempHiddenField").val() == "1") {
                $("#btnSave").val("Complete Registration");
            }
            $("#currencyPreferance").select2();

            if ($("#AddressStyleHiddenField").val() == "postal") {
                $("#UserPostalStyleHyperlink").tab('show');
                userLocationPostalPreferance = true;
                $("#AddressStyleHiddenField").val("postal");
                $("#UserAddressAddressLine2").removeClass("ignore");
                $("#UserCityDropDownList").removeClass("ignore");
                $("#UserStateDropDownList").removeClass("ignore");
                $("#UserAddressAddressPostalCode").removeClass("ignore");
                $("#AddressHiddenField").addClass("ignore");

            } else {
                $("#UserMapStyleHyperlink").tab("show");
                userLocationPostalPreferance = false;
                $("#UserAddressAddressLine2").addClass("ignore");
                $("#UserAddressAddressPostalCode").addClass("ignore");
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

            $.validator.addMethod('UserAddressLineValidation',
                    function (value) {
                        if (($("#UserAddressAddressLine1").val().length > 0 || $("#UserAddressAddressLine2").val().length > 0) && $("#UserAddressAddressPostalCode").val().length > 0) {
                            return true;
                        } else {
                            return false;
                        }
                    }, 'Atleast one address line should be filled along with postal code.');

            $("#AddressHiddenField").addClass("ignore");
            var birthDate = $("#BirthDateTextBox").datepicker({ format: "dd/mm/yyyy" }).on('changeDate', function (ev) {
                $("#BirthDateTextBox").blur();
            });

            $('.form-horizontal').validate({
                ignore: ".ignore",
                rules: {
                    FirstNameTextBox: { required: true },
                    LastNameTextBox: { required: true },
                    UserGenderDropDownList: { required: true },
                    EmailAddressTextBox: { required: true, email: true },
                    PhoneNumberTextBox: { required: true },
                    UserAddressTextBox: { required: true },
                    UserDescriptionTextBox: { required: true },
                    AddressHiddenField: { required: true },
                    UserAddressAddressLine2: { UserAddressLineValidation: true },
                    UserAddressAddressPostalCode: { UserAddressLineValidation: true },
                    UserCityDropDownList: { required: true },
                    UserStateDropDownList: { required: true },
                    currencyPreferance: { required: true },
                    TermsCheckBox: { required: true }
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

        function SetDefaultMapLocation(checkbox) {
            if (checkbox.checked) {
                initializeMap(true);
            }
        }

        function CheckifWeNeedInitializeMap(hyperlink) {
            // alert(hyperlink.attr("href"));
            if (hyperlink.attr("href") == "#UserMapStyle") {
                $("#AddressStyleHiddenField").val("map");
                userLocationPostalPreferance = false;
                $("#UserAddressAddressLine2").addClass("ignore");
                $("#UserAddressAddressPostalCode").addClass("ignore");
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
                $("#UserAddressAddressPostalCode").removeClass("ignore");
                $("#AddressHiddenField").addClass("ignore");
            }
        }

        function SaveUserProfile() {

            $("#btnSave").button('loading');
            if ($('.form-horizontal').valid()) {
                if (!userAddressVerified && userLocationPostalPreferance) {
                    alert("you have not verified your address,please verify");
                    $("#btnSave").button('complete');
                    return true;
                }
                var firstName = $("#FirstNameTextBox").val();
                var lastname = $("#LastNameTextBox").val();
                var gender = $("#UserGenderDropDownList").val();
                var birthDate = $("#BirthDateTextBox").val();
                var emailAddress = $("#EmailAddressTextBox").val();
                var phoneNumber = $("#PhoneNumberTextBox").val();

                var address = $("#AddressHiddenField").val();
                var lat = $("#latHiddenField").val();
                var lang = $("#lngHiddenField").val();

                var addressLine1 = $("#UserAddressAddressLine1").val();
                var addressLine2 = $("#UserAddressAddressLine2").val();
                var postalCode = $("#UserAddressAddressPostalCode").val();
                var city = $("#UserCityDropDownList").val();
                var state = $("#UserStateDropDownList").val();
                var description = $("#UserDescriptionTextBox").val();
                var isPostalStyleSelected = $("#AddressStyleHiddenField").val();
                var selectedCurrencyType = $("#currencyPreferance").val();


                var postData = "{firstName:'" + firstName + "',lastName:'" + lastname + "',gender:'" + gender + "',birthDate:'" + birthDate + "',emailAddress:'" + emailAddress + "',hp:'" + phoneNumber + "',address:'" + address + "',description:'" + description.replace(/'/g, "\\'") + "',addressLang:'" + lang + "',addressLat:'" + lat + "',addressLine1:'" + addressLine1 + "',addressLine2:'" + addressLine2 + "',postalcode:'" + postalCode + "',city:'" + city + "',state:'" + state + "',isPostalStyleSeleted:'" + isPostalStyleSelected + "',phoneNumber:'" + phoneNumber + "',preferredCurrencyType:'" + selectedCurrencyType + "'}";

                $.ajax({
                    type: "POST",
                    url: "EditProfile.aspx/SaveUserProfile",
                    data: postData,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (msg) {
                        $("#btnSave").button('complete');
                        $("#DivStatus").fadeIn('slow').removeClass("alert-error").addClass("alert alert-success").text("Lisiting details updated successfully").delay(5000).fadeOut();
                        if (querystring("SignUp") != null || querystring("SignUp") != "") {
                            window.location.href = "Home.aspx";
                        }
                    },
                    error: function (msg) {
                        $("#btnSave").button('complete');
                        $("#DivStatus").fadeIn('slow').removeClass("alert-success").addClass("alert alert-error").text("Error occured, please try again").delay(5000).fadeOut();
                    }
                });
            }
            else {

                $("#btnSave").button('complete');
                $("#DivStatus").fadeIn('slow').removeClass("alert-success").addClass("alert alert-error").text("Form information is not valid, please rectify your information and then save").delay(5000).fadeOut();
            }

        }


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


        function codeAddress(address) {
            var geocoder = new google.maps.Geocoder();
            geocoder.geocode({ 'address': address }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    userAddressVerified = true;
                    $("#map_verified_AddRess").addClass("alert alert-info");
                    $("#map_verified_AddRess").text(results[0].formatted_address);
                    $("#map_canvas_postal").show();
                    setPostionOnMap(results[0].geometry.location.lat(), results[0].geometry.location.lng(), "map_canvas_postal");
                } else {
                    alert("Geocode was not successful for the following reason: " + status);
                }
            });
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
                codeLatLng(myMarker.position.lat(), myMarker.position.lng())
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



        function ViewPostalMap() {
            $("#VerifyAddressButton").button('loading');
            $("#UserAddressAddressLine1").valid();
            $("#UserAddressAddressLine2").valid();
            $("#UserAddressAddressPostalCode").valid();
            var address = "";
            var addressLine1 = $("#UserAddressAddressLine1").val();
            var addressLine2 = $("#UserAddressAddressLine2").val();
            var postalCode = $("#UserAddressAddressPostalCode").val();
            var city = $("#UserCityDropDownList").val();
            var state = $("#UserStateDropDownList").val();
            address = postalCode + "," + city + "," + state + "," + addressLine1 + "," + addressLine2;
            //alert(address); 
            codeAddress(address);
            $("#VerifyAddressButton").button('complete');
        }



        var onSuccess = function (location) {
            lattitue = location.location.latitude;
            longitude = location.location.longitude;
            $("#latHiddenField").val(lattitue);
            $("#lngHiddenField").val(longitude);
            setPostionOnMap(lattitue, longitude, "map_canvas");
        };

        var onError = function (error) {
            lattitue = $("#latHiddenField").val();
            longitude = $("#lngHiddenField").val();
            setPostionOnMap(lattitue, longitude, "map_canvas");
        };

        function initializeMap(getCurrentLocation) {
            var map;
            if (getCurrentLocation) {
                lattitue = $("#latHiddenField").val();
                longitude = $("#lngHiddenField").val();
                setPostionOnMap(lattitue, longitude, "map_canvas");
            } else {
                geoip2.city(onSuccess, onError);
            }

            //                if (navigator.geolocation) {
                //                    navigator.geolocation.getCurrentPosition(function (position) {
                //                        lattitue = position.coords.latitude;
                //                        longitude = position.coords.longitude;
                //                        $("#latHiddenField").val(lattitue);
                //                        $("#lngHiddenField").val(longitude);
                //                        setPostionOnMap(lattitue, longitude, "map_canvas");
                //                    });
                //}
                //            } else {
                //                lattitue = $("#latHiddenField").val();
                //                longitude = $("#lngHiddenField").val();
                //                setPostionOnMap(lattitue, longitude, "map_canvas");
                //            }

            }

        function querystring(key) {
            var re = new RegExp('(?:\\?|&)' + key + '=(.*?)(?=&|$)', 'gi');
            var r = [], m;
            while ((m = re.exec(document.location.search)) != null) r.push(m[1]);
            return r;
        }
    </script>
</body>
</html>
<script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
