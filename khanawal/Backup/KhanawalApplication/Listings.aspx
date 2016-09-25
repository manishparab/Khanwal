<%@ Page Language="C#" AutoEventWireup="true" Inherits="KhanawalApplication.Listings"
    CodeBehind="Listings.aspx.cs" %>

<%@ Register Src="ListingUserControl.ascx" TagName="ListingUserControl" TagPrefix="uc1" %>
<%@ Register Src="TopNavigationUserControl.ascx" TagName="TopNavigationUserControl"
    TagPrefix="ucTopNavigation" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Search Home made food ,Indian food ,chiken biryani, cake , indian snacks , pizza
        , prawn dishes, butter chicken, breakfast, dinner, indian Recipes, Sell food
    </title>
    <meta content="Search  your favourite dish using various filters like distance, food type, food taste, distance.Or you can request your dish from users in your area.khanawal(khanawal.com) is online place providing home made yummy food, low fat food, sea food, healthy dishes and pure vagetarian dishes. The food is home cooked in home which makes it healthy and tasty .it is an alternative to tiffin service and restaurants.people can eat from food like seafood, Chiken to pure vegetarian food."
        name="Description" />
    <meta name="keywords" content="Search food, Request food, Search Home made dish, Request dish, Order Home made food ,Indian food ,chiken biryani, cake , indian snacks , pizza , prawn dishes, butter chicken, breakfast, dinner, indian Recipes" />
    <meta name="author" content="khanawal.com" />
    <meta property="og:image" content="http://khanawal.com/Capture/Images/HomePage/HomeCooked_India_food.jpg">
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="js/bootstrap-tagmanager.js" type="text/javascript"></script>
    <script src="js/vendor/bootstrap.min.js"></script>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/Custom.css" rel="stylesheet" type="text/css" />
    <!--[if lt IE 9]>
    <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script> 
  <![endif]-->
    <link href="themes/default/default.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.9.1/themes/base/jquery-ui.css" />
    <script src="http://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>
    <script src="js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="js/date.js" type="text/javascript"></script>
    <script src="js/select2.js" type="text/javascript"></script>
    <script src="https://maps.googleapis.com/maps/api/js?sensor=false&libraries=places"></script>
    <link href="css/select2/select2.css" rel="stylesheet" type="text/css" />
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />
    <script src="js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
    <link href="css/bootstrap-tagmanager.css" rel="stylesheet" type="text/css" />
    <script src="//j.maxmind.com/js/apis/geoip2/v2.0/geoip2.js" type="text/javascript"></script>
    <style type="text/css">
        body
        {
            padding-top: 60px;
        }
        .clear_location_hyperlink
        {
            font-weight: bold;
            color: #f6931f;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <ucTopNavigation:TopNavigationUserControl ID="TopNavigationUserControl1" runat="server" />
    <asp:HiddenField runat="server" ID="isUserLoggedIn" ClientIDMode="Static" />
    <div class="container">
        <div class="span12">
            <div id="UserGeolocation">
            </div>
            <div id="blockTitle" class="navbar-inner">
                <div style="margin-top: 7px;">
                    <b>Dish Name</b>
                    <asp:TextBox runat="server" ClientIDMode="Static" ID="txtSearch"></asp:TextBox>
                    <img src="img/icons/glyphicons_275_fast_food.png" />&nbsp;&nbsp;&nbsp;
                    <input type="button" value="Update Search Results" class="btn btn-primary" id="SearchButton"
                        onclick="FilterSearchResults('none')" />
                </div>
            </div>
        </div>
        <br />
        <br />
        <br />
        <div class="span3" width="95%" style="margin-bottom: 5px; border-top-color: #d4d4d4;
            border-right-color: #d4d4d4; border-bottom-color: #d4d4d4; border-left-color: #d4d4d4;
            border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px;
            border-top-style: solid; border-right-style: solid; border-bottom-style: solid;
            border-left-style: solid;">
            <div id="UserGeolocationInput">
                <div class="navbar-inner" onclick="divContent_click(this)">
                    <h5>
                        User Location <span class="icon-chevron-down"></span>
                    </h5>
                </div>
                <div style="min-height: 40px; margin-bottom: 10px;" class="contentDiv">
                    <p>
                        <input id="searchTextField" type="text" style="border: 1 !important; color: #f6931f;
                            font-weight: bold;" />
                    </p>
                    <div id="Div1">
                    </div>
                </div>
            </div>
            <div>
                <div class="navbar-inner" onclick="divContent_click(this)">
                    <h5>
                        Food Type <span class="icon-chevron-down"></span>
                    </h5>
                </div>
                <div style="min-height: 40px; margin-left: 10px;" class="contentDiv">
                    <div class="asp_checkboxList" id="FoodTypeCheckBoxListDiv">
                        <asp:CheckBoxList CssClass="nav nav-list" ClientIDMode="Static" runat="server" ID="FoodTypeCheckBoxList"
                            RepeatLayout="UnorderedList">
                            <asp:ListItem Value="1">Veg</asp:ListItem>
                            <asp:ListItem Value="0">Non-Veg</asp:ListItem>
                        </asp:CheckBoxList>
                    </div>
                </div>
            </div>
            <div>
                <div class="navbar-inner" onclick="divContent_click(this)">
                    <h5>
                        Recipe Type <span class="icon-chevron-down"></span>
                    </h5>
                </div>
                <div style="min-height: 40px; margin-left: 10px;" class="contentDiv">
                    <div class="asp_checkboxList" id="RecipeTypeDiv">
                        <asp:CheckBoxList CssClass="nav nav-list" ClientIDMode="Static" runat="server" ID="RecipeTypeCheckBoxList"
                            RepeatLayout="UnorderedList">
                        </asp:CheckBoxList>
                        <asp:HiddenField runat="server" ID="RecipeTypeHiddenField" />
                    </div>
                </div>
            </div>
            <div>
                <div class="navbar-inner" onclick="divContent_click(this)">
                    <h5>
                        Cost <span class="icon-chevron-down"></span>
                    </h5>
                </div>
                <div style="min-height: 40px; margin-bottom: 10px;" class="contentDiv">
                    <p>
                        <label for="amount">
                            Price range:</label>
                        <input type="text" id="amount" style="border: 0 !important; color: #f6931f; font-weight: bold;" />
                    </p>
                    <div id="slider-range">
                    </div>
                </div>
            </div>
            <div>
                <div class="navbar-inner" onclick="divContent_click(this)">
                    <h5>
                        Taste <span class="icon-chevron-down"></span>
                    </h5>
                </div>
                <div class="asp_checkboxList contentDiv" id="TasteCheckBoxListDiv">
                    <asp:CheckBoxList AutoPostBack="False" CssClass="nav nav-list" runat="server" ID="TasteCheckBoxList"
                        ClientIDMode="Static" RepeatLayout="UnorderedList">
                    </asp:CheckBoxList>
                </div>
            </div>
            <div>
                <div class="navbar-inner" onclick="divContent_click(this)">
                    <h5>
                        Rating <span class="icon-chevron-down"></span>
                    </h5>
                </div>
                <div style="min-height: 40px" class="contentDiv">
                    <p>
                        <label for="rating">
                            Rating :</label>
                        <input type="text" id="rating" style="border: 0 !important; color: #f6931f; font-weight: bold;" />
                    </p>
                    <div id="slider-rating">
                    </div>
                </div>
            </div>
            <div>
                <div class="navbar-inner" onclick="divContent_click(this)">
                    <h5>
                        Nearby <span class="icon-chevron-down"></span>
                    </h5>
                </div>
                <div style="min-height: 40px" class="contentDiv">
                    <p>
                        <label for="distance">
                            Distance :</label>
                        <input type="text" id="distance" style="border: 0 !important; color: #f6931f; font-weight: bold;" />
                    </p>
                    <div id="slider-distance">
                    </div>
                </div>
            </div>
        </div>
        <div class="span9">
            <div class="navbar" id="topDivTabs">
                <div class="navbar-inner">
                    <ul class="nav nav-tabs" id="divTop">
                        <li class="active"><a href="#UserListing">Dishes in your area</a> </li>
                        <li><a id="UserRequestHyperLink" href="#UserRequest">Request your dish[beta]</a></li>
                    </ul>
                </div>
            </div>
            <div class="tab-content" style="margin: 10px">
                <div id="UserListing" class="tab-pane active">
                    <div class="navbar-inner">
                        <h5>
                            <div id="resultsCountDiv">
                                <asp:Literal runat="server" ID="resultLiteral" ClientIDMode="Static"></asp:Literal>
                            </div>
                        </h5>
                    </div>
                    <div id="listingsDiv">
                        <uc1:ListingUserControl ID="ListingUserControl" runat="server" />
                    </div>
                </div>
                <div id="UserRequest" class="tab-pane">
                </div>
            </div>
        </div>
    </div>
    <div id="spinner">
        loading....
    </div>
    </form>
</body>
<script type="text/javascript">
    var mincost = "";
    var maxCost = "";
    var distance = "100";
    var spinnerVisible = false;
    var lat = "";
    var lang = "";
    var minRating = 0;
    var maxRating = 5;
    var timepickerTime;
    var isUserListingTab = true;

    function showProgress() {
        if (!spinnerVisible) {
            $("div#spinner").fadeIn("fast");
            spinnerVisible = true;
        }
    }

    function hideProgress() {
        if (spinnerVisible) {
            var spinner = $("div#spinner");
            spinner.stop();
            spinner.fadeOut("fast");
            spinnerVisible = false;
        }
    };

    $(document).ready(function () {
        $("#dp3").datepicker();
        $("#dp4").datepicker();

        $("[id*=TasteCheckBoxList] input[type=checkbox]").click(function () {
            FilterSearchResults("taste");
        });

        $("[id*=RecipeTypeCheckBoxList] input[type=checkbox]").click(function () {
            FilterSearchResults("recipeType");
        });

        $("[id*=FoodTypeCheckBoxList] input[type=checkbox]").click(function () {
            FilterSearchResults("foodType");
        });

        //        if (window.navigator.geolocation) {
        //            window.navigator.geolocation.getCurrentPosition(show_map);
        //        } else {
        //            $("#UserGeolocation").text("Your current browser dose not support sharing location, location is needed for better search result, please provide your location in user location box");
        //            $("#UserGeolocation").addClass("alert alert-error");
        //        }

    });

    function CheckIfUserHasAddress() {
        $.ajax({
            type: "POST",
            url: "Listings.aspx/CheckIfUserHasAddress",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            beforeSend: function () {
                //Mask page
                showProgress();
            },
            complete: function () {
                //remove Mask
                hideProgress();

            },
            success: function (msg) {
                if (msg.d.length > 0) {
                    if (msg.d == "-1") {
                        $("#User_Pickup_Address").fadeIn('slow').removeClass("alert-success").addClass("alert alert-error").html("please <a href='EditProfile.aspx'> update your</a> address to select this option");
                    } else {
                        $("#User_Pickup_Address").fadeIn('slow').removeClass("alert-error").addClass("alert alert-success").text(msg.d);
                    }
                } else {
                    $("#User_Pickup_Address").fadeIn('slow').removeClass("alert-success").addClass("alert alert-error").html("Please login to select home delivery option");
                }
            },
            error: function (msg) {
                debugger;
                alert("fail");

            }
        });
    }

    window.onload = function () {
        var onSuccess = function (location) {
            lat = location.location.latitude;
            lang = location.location.longitude;
            codeLatLng(location.location.latitude, location.location.longitude);
        };

        var onError = function (error) {
        };

        geoip2.city(onSuccess, onError);
        
//        if (navigator.geolocation) {
//            navigator.geolocation.getCurrentPosition(function (position) {
//                show_map(position);
//            }, function (error) {
//                geoip2.city(onSuccess, onError);
//            }, { timeout: 5000 });
//        } else {
//            geoip2.city(onSuccess, onError);
//        }
    };

    function codeAddressChanged(address) {
        var geocoder = new google.maps.Geocoder();
        geocoder.geocode({ 'address': address }, function (results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                lat = results[0].geometry.location.lat();
                lang = results[0].geometry.location.lng();
                codeLatLng(lat, lang);
            } else {
                $("#UserGeolocation").removeClass();
                $("#UserGeolocation").addClass("alert alert-error");
                $("#UserGeolocation").html("Could not locate your area, please be more specific");
            }
        });
    }

    function show_map(position) {
        lat = position.coords.latitude;
        lang = position.coords.longitude;
        // Add code to show a map here
        codeLatLng(lat, lang);

    }

    function codeLatLng(lattitude, longitude) {
        var geocoder = new google.maps.Geocoder();
        var latlng = new google.maps.LatLng(lattitude, longitude);
        geocoder.geocode({ 'latLng': latlng }, function (results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                if (results[1]) {
                    $("#searchTextField").val(results[0].formatted_address);
                    $("#UserGeolocation").removeClass();
                    $("#UserGeolocation").addClass("alert alert-info");
                    $("#UserGeolocation").html("Search result updated for  <b>" + results[0].formatted_address + "</b> ,change user location to search dishes in other location or <a id='link_Clear_location' onClick=clearLocation(); class='clear_location_hyperlink'> Clear location </a> to see all dishes");
                    if (isUserListingTab) {
                        //                        if ($("#RecipeTypeHiddenField").val() == "1") {
                        //                            FilterSearchResults("recipeType");
                        //                        } else {
                        //                            FilterSearchResults("distance");
                        //                                                }
                        FilterSearchResults("distance");

                    } else {
                        SeachUser();
                    }

                }
            }
        });
    }

    $("#searchTextField").focusout(function () {
        if ($(this).val() == "") {
            clearLocation();
        } else {
            codeAddressChanged($(this).val());
        }
    });


    function clearLocation() {
        lat = "";
        lang = "";
        $("#UserGeolocation").removeClass();
        $("#UserGeolocation").addClass("alert alert-info");
        $("#UserGeolocation").html("Showing dishes from all over");
        $("#searchTextField").val("");
        if (isUserListingTab) {
            if ($("#RecipeTypeHiddenField").val() == "1") {
                FilterSearchResults("recipeType");
            } else {
                FilterSearchResults("none");
            }
        } else {
            SeachUser();
        }
    };

    var pac_input = document.getElementById('searchTextField');

    function codeAddress(address) {
        var geocoder = new google.maps.Geocoder();
        geocoder.geocode({ 'address': address }, function (results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                setPostionOnMap(results[0].geometry.location.lat(), results[0].geometry.location.lng(), "map_canvas_postal");
                $("#latHiddenField").val(results[0].geometry.location.lat());
                $("#lngHiddenField").val(results[0].geometry.location.lng());
            } else {
                //alert("Geocode was not successful for the following reason: " + status);
                alert("your address is not validated, please corret your address and validate again");
            }
        });
    }

    (function pacSelectFirst(input) {
        // store the original event binding function
        var _addEventListener = (input.addEventListener) ? input.addEventListener : input.attachEvent;

        function addEventListenerWrapper(type, listener) {
            // Simulate a 'down arrow' keypress on hitting 'return' when no pac suggestion is selected,
            // and then trigger the original listener.

            if (type == "keydown") {
                var orig_listener = listener;
                listener = function (event) {
                    var suggestion_selected = $(".pac-item.pac-selected").length > 0;
                    if (event.which == 13 && !suggestion_selected) {
                        var simulated_downarrow = $.Event("keydown", { keyCode: 40, which: 40 });
                        orig_listener.apply(input, [simulated_downarrow]);
                    }

                    orig_listener.apply(input, [event]);
                };
            }

            // add the modified listener
            _addEventListener.apply(input, [type, listener]);
        }

        if (input.addEventListener)
            input.addEventListener = addEventListenerWrapper;
        else if (input.attachEvent)
            input.attachEvent = addEventListenerWrapper;

    })(pac_input);


    $(function () {

        var userRequest = getParameterByName("UserRequest");

        if (userRequest != "1") {
            var autocomplete = new google.maps.places.Autocomplete(pac_input);
            var componentRestrictions = { country: 'ind' };
            autocomplete.setComponentRestrictions(componentRestrictions);

            google.maps.event.addListener(autocomplete, 'place_changed', function () {
                var place = autocomplete.getPlace();
                lat = place.geometry.location.lat();
                lang = place.geometry.location.lng();
                $("#UserGeolocation").removeClass();
                $("#UserGeolocation").addClass("alert alert-info");
                $("#UserGeolocation").html("All dishes from <b>" + place.name + "</b> will be searched or <a id='link_Clear_location' onClick=clearLocation(); class='clear_location_hyperlink'> Clear location </a> to see dishes from all areas");
                FilterSearchResults("distance");

                //FilterSearchResults("distance");
                //            document.getElementById('city2').value = place.name;
                //            document.getElementById('cityLat').value = place.geometry.location.lat();
                //            document.getElementById('cityLng').value = place.geometry.location.lng();
                //alert("This function is working!");
                //alert(place.name);
                // alert(place.address_components[0].long_name);

            });
        } else {
            isUserListingTab = false;
            SeachUser();
            $("#UserRequestHyperLink").tab('show');
        }
    });

    function getParameterByName(name) {
        name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
        var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
        return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
    }

    $(function () {
        $("#slider-range").slider({
            range: true,
            min: 1,
            max: 1000,
            values: [1, 1000],
            slide: function (event, ui) {
                $("#amount").val("Rs " + ui.values[0] + " -  Rs " + ui.values[1]);
            },
            change: function (event, ui) {
                mincost = ui.values[0];
                maxCost = ui.values[1];
                FilterSearchResults("cost");


            }
        });
        $("#amount").val("Rs " + $("#slider-range").slider("values", 0) +
            " - Rs " + $("#slider-range").slider("values", 1));
    });

    $(function () {
        $("#slider-rating").slider({
            range: true,
            min: 0,
            max: 5,
            values: [0, 5],
            slide: function (event, ui) {
                $("#rating").val("" + ui.values[0] + " - " + ui.values[1]);
            },
            change: function (event, ui) {
                minRating = ui.values[0];
                maxRating = ui.values[1];
                FilterSearchResults("rating");

            }
        });
        $("#rating").val("" + $("#slider-rating").slider("values", 0) +
            " - " + $("#slider-rating").slider("values", 1));
    });

    $(function () {
        $("#slider-distance").slider({
            range: "min",
            min: 0,
            max: 100,
            value: 50,
            slide: function (event, ui) {
                distance = ui.value;
                $("#distance").val("1 Km " + " - Km " + ui.value);
            },
            change: function (event, ui) {
                distance = ui.value;
                FilterSearchResults("distance");

            }
        });

        $("#distance").val("1 Km " +
            " - Km " + $("#slider-distance").slider("values", 1));
    });

    $(document).ready(function () {
        $(document).on("AuthSuccess", AuthSuccessHandler);
    });

    // AuthSuccess event handler
    function AuthSuccessHandler(e) {
        $("#isUserLoggedIn").val("true");
        $("#ButtonNotifySelectedUsers").val("Notify selected users");
        $("#ButtonNotifyAllUsers").val("Notify all users");
    }



    function CheckAuthThenSaveRequestAndNotifyUser() {
        if ($("#isUserLoggedIn").val() == "true") {
            SaveRequestAndNotifyUser();
        } else {
            AuthenticateUser();
        }
    }

    function SaveRequestAndNotifyUser() {
        var userAddressEnity = [];
        var objCode;
        var isError = false;
        var deliveryType = "";
        var errorMessage = "<b>Can not submit your request , please solve below error(s)</b><br><br>";
        var dishName = $("#txtSearch").val();

        if (dishName == "") {
            errorMessage = errorMessage + "!! Please Provide dish name <br>";
            isError = true;
        }



        if ($("#CheckboxHomeDelivery").is(':checked')) {
            deliveryType = "HomeDelivery";
        }
        else if ($("#CheckboxPickUpLocation").is(':checked')) {
            deliveryType = "PickUpLocation";
        }

        if (deliveryType == "") {
            errorMessage = errorMessage + "!! Please select delivery type <br>";
            isError = true;
        }

        if (deliveryType == "PickUpLocation") {
            if ($("#UserAddressAddressLine1").val().length == 0 && $("#UserAddressAddressLine2").val().length == 0) {
                errorMessage = errorMessage + "!! Please Provide Address <br>";
                isError = true;
            }

            if ($("#UserAddressAddressPostalCode").val().length == 0) {
                errorMessage = errorMessage + "!! Please Provide Postal Code <br>";
                isError = true;
            }

            if ($("#CityTextBox").val().length == 0) {
                errorMessage = errorMessage + "!! Please Provide City location <br>";
                isError = true;
            }

            if ($("#StateTextBox").val().length == 0) {
                errorMessage = errorMessage + "!! Please Provide State <br>";
                isError = true;
            }
        }


        var selectedUsers = "";
        $('input[type=checkbox]:checked[representsUserId="' + "true" + '"]').each(function () {
            selectedUsers = selectedUsers + $(this).attr('id') + ",";
        });

        if (selectedUsers == "") {
            errorMessage = errorMessage + "!! Please select atleast one user to notify <br>";
            isError = true;
        }

        if (lat.length == 0 || lang.length == 0) {
            errorMessage = errorMessage + "!! Please enter your location in user location block <br>";
            isError = true;
        }

        var curretTime = GetUTCNumber(new Date().addHours(4));
        var requesttime = $('#datetimepicker').data('datetimepicker').getLocalDate();

        if (GetUTCNumber(requesttime) < curretTime) {
            errorMessage = errorMessage + "!! delivery time should be aleast 4 hours than current time  <br>";
            isError = true;
        } else {
            requesttime = requesttime.toUTCString();
        }

        if (isError) {
            $("#divSaveRequestNotification").attr("style", "block").addClass("alert-error").removeClass("alert-success");
            $("#divSaveRequestNotification").html(errorMessage);
            return false;
        }

        objCode = new Object();
        //objCode.ID = 0;
        objCode.AddRessLine1 = $("#UserAddressAddressLine1").val();
        objCode.AddRessLine2 = $("#UserAddressAddressLine2").val();
        objCode.PinCode = $("#UserAddressAddressPostalCode").val();
        objCode.City = $("#CityTextBox").val();
        objCode.State = $("#StateTextBox").val();
        objCode.LandMark = $("#TextAdditionalInformation").val();
        objCode.Country = "";
        //objCode.AdHocRequestId = 0;

        userAddressEnity.push(objCode);


        var selectedFoodtype = "";


        if ($("#VegRequestType").is(':checked')) {
            selectedFoodtype = "veg";
        }

        if ($("#NonVegRequestType").is(':checked')) {
            selectedFoodtype = "nonveg";
        }

        var requestTasteId = $("#TasteDropDownList").select2("val");
        var requestSideDishes = $('input[name="hidden-tagsSideDishes"]').val();
        var requestAvoideIngredients = $('input[name="hidden-tagsIngredientToAvoide"]').val();

        var requestCost = $("#RequestCostTextBox").val();
        var textAdditionalInformation = $("#TextAdditionalInformation").val();




        var postData = "{selectedUserId:'" + selectedUsers +
                            "',dishName:'" + dishName +
                            "',tasteId:'" + requestTasteId +
                            "',deliveryTime:'" + requesttime +
                            "',sideDishes:'" + requestSideDishes +
                            "',ingredientsToavoide:'" + requestAvoideIngredients +
                             "',cost :'" + requestCost +
                             "',textAdditionalInformation:'" + textAdditionalInformation +
                             "',foodType:'" + selectedFoodtype +
                             "',RequestPickupLocation:" + JSON.stringify(userAddressEnity) +
                             ",deliveryMode:'" + deliveryType +
                             "'}";

        $.ajax({
            type: "POST",
            url: "Listings.aspx/CreateAdhocRequest",
            data: postData,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            beforeSend: function () {
                //Mask page
                showProgress();
            },
            complete: function () {
                //remove Mask
                hideProgress();

            },
            success: function (msg) {
                alert("success");
            },
            error: function (msg) {
                debugger;
                alert("fail");

            }
        });

        //public static int CreateAdhocRequest(string selectedUserId, string dishName, string tasteId, string deliveryTime, string sideDishes, string ingredientsToavoide)

    }

    function CheckAuthThenSaveRequestAndNotifyAllUsers() {
        if ($("#isUserLoggedIn").val() == "true") {
            SaveRequestAndNotifyAllUsers();
        } else {
            AuthenticateUser();
        }
    }

    function GetUTCNumber(now) {
        var d = Date.UTC(now.getFullYear(), now.getMonth(), now.getDate(), now.getHours(), now.getMinutes(), now.getSeconds(), now.getMilliseconds());
        return d;
    }

    function SaveRequestAndNotifyAllUsers() {
        var userAddressEnity = [];
        var objCode;
        var isError = false;
        var deliveryType = "";
        var errorMessage = "<b>Can not submit your request , please solve below error(s)</b><br><br>";
        var dishName = $("#txtSearch").val();

        if (dishName == "") {
            errorMessage = errorMessage + "!! Please Provide dish name <br>";
            isError = true;
        }


        if ($("#CheckboxHomeDelivery").is(':checked')) {
            deliveryType = "HomeDelivery";
        }
        else if ($("#CheckboxPickUpLocation").is(':checked')) {
            deliveryType = "PickUpLocation";
        }

        if (deliveryType == "") {
            errorMessage = errorMessage + "!! Please select delivery type <br>";
            isError = true;
        }

        if (deliveryType == "PickUpLocation") {
            if ($("#UserAddressAddressLine1").val().length == 0 && $("#UserAddressAddressLine2").val().length == 0) {
                errorMessage = errorMessage + "!! Please Provide Address <br>";
                isError = true;
            }

            if ($("#UserAddressAddressPostalCode").val().length == 0) {
                errorMessage = errorMessage + "!! Please Provide Postal Code <br>";
                isError = true;
            }

            if ($("#CityTextBox").val().length == 0) {
                errorMessage = errorMessage + "!! Please Provide City location <br>";
                isError = true;
            }

            if ($("#StateTextBox").val().length == 0) {
                errorMessage = errorMessage + "!! Please Provide State <br>";
                isError = true;
            }
        }


        var selectedUsers = "";
        $('#ListingSearchUserDiv input[type=checkbox]').each(function () {
            selectedUsers = selectedUsers + $(this).attr('id') + ",";
        });

        if (selectedUsers == "") {
            errorMessage = errorMessage + "!! There should be atleast one cook to send request <br>";
            isError = true;
        }

        var peopleCount = $("#numberOfPeople").val();
        if (peopleCount == "") {
            errorMessage = errorMessage + "!! Please enter number of people for whom you want the dish<br>";
            isError = true;
        }

        if (selectedUsers == "") {
            errorMessage = errorMessage + "!! There should be atleast one cook to send request <br>";
            isError = true;
        }

        if (lat.length == 0 || lang.length == 0) {
            errorMessage = errorMessage + "!! Please enter your location in user location block <br>";
            isError = true;
        }
       
        var curretTime = GetUTCNumber(new Date().addHours(4));
        var requesttime = $('#datetimepicker').data('datetimepicker').getLocalDate();

        if (GetUTCNumber(requesttime) < curretTime) {
            errorMessage = errorMessage + "!! delivery time should be aleast 4 hours than current time  <br>";
            isError = true;
        } else {
            requesttime = requesttime.toUTCString();
        }

        if (isError) {
            $("#divSaveRequestNotification").attr("style", "block").addClass("alert-error").removeClass("alert-success");
            $("#divSaveRequestNotification").html(errorMessage);
            return false;
        }

        objCode = new Object();
        //objCode.ID = 0;
        objCode.AddRessLine1 = $("#UserAddressAddressLine1").val();
        objCode.AddRessLine2 = $("#UserAddressAddressLine2").val();
        objCode.PinCode = $("#UserAddressAddressPostalCode").val();
        objCode.City = $("#CityTextBox").val();
        objCode.State = $("#StateTextBox").val();
        objCode.LandMark = $("#TextAdditionalInformation").val();
        objCode.Country = "";
        //objCode.AdHocRequestId = 0;

        userAddressEnity.push(objCode);


        var selectedFoodtype = "";


        if ($("#VegRequestType").is(':checked')) {
            selectedFoodtype = "veg";
        }

        if ($("#NonVegRequestType").is(':checked')) {
            selectedFoodtype = "nonveg";
        }

        var requestTasteId = $("#TasteDropDownList").select2("val");
        var requestSideDishes = $('input[name="hidden-tagsSideDishes"]').val();
        var requestAvoideIngredients = $('input[name="hidden-tagsIngredientToAvoide"]').val();


        var requestCost = $("#RequestCostTextBox").val();
        var textAdditionalInformation = $("#TextAdditionalInformation").val();

        var postData = "{selectedUserId:'" + selectedUsers +
                            "',dishName:'" + dishName +
                            "',tasteId:'" + requestTasteId +
                            "',deliveryTime:'" + requesttime +
                            "',sideDishes:'" + requestSideDishes +
                            "',ingredientsToavoide:'" + requestAvoideIngredients +
                             "',cost :'" + requestCost +
                             "',textAdditionalInformation:'" + textAdditionalInformation +
                             "',foodType:'" + selectedFoodtype +
                             "',RequestPickupLocation:" + JSON.stringify(userAddressEnity) +
                             ",deliveryMode:'" + deliveryType +
                             "',peopleCount:'" + peopleCount +
                             "'}";

        $.ajax({
            type: "POST",
            url: "Listings.aspx/CreateAdhocRequest",
            data: postData,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            beforeSend: function () {
                //Mask page
                showProgress();
            },
            complete: function () {
                //remove Mask
                hideProgress();

            },
            success: function (msg) {
                alert("success");
            },
            error: function (msg) {
                debugger;
                alert("fail");

            }
        });

        //public static int CreateAdhocRequest(string selectedUserId, string dishName, string tasteId, string deliveryTime, string sideDishes, string ingredientsToavoide)

    }


    function SeachUser() {
        var searchKeyWord;

        searchKeyWord = $("#txtSearch").val();

        var postData = "{searchKeyWord:'" + searchKeyWord +
                            "',lat:'" + lat +
                            "',lang:'" + lang +
                            "',distance:'" + distance +
                             "'}";

        $.ajax({
            type: "POST",
            url: "Listings.aspx/SearchUsersResult",
            data: postData,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            beforeSend: function () {
                //Mask page
                showProgress();
            },
            complete: function () {
                //remove Mask
                hideProgress();
            },
            success: function (msg) {
                $("#UserRequest").html(msg.d.ListingSearchUserControl);

                $('#datetimepicker').datetimepicker({
                    language: 'en',
                    pick12HourFormat: true
                });

                var selectedTasteValue = [];

                $("[id*=TasteCheckBoxList] input:checked").each(function () {
                    selectedTasteValue.push($(this).val());
                });

                //                var selectedTasteValues = selectedTasteValue.join(',');
                //                alert(selectedTasteValues);

                if (selectedTasteValue.length > 0) {
                    $("#TasteDropDownList").select2().select2('val', selectedTasteValue);
                } else {
                    $("#TasteDropDownList").select2();
                }


                $("#RequestCostTextBox").val(maxCost);

                $("#FoodTypeCheckBoxList_0").is(':checked') ? $('#VegRequestType').prop('checked', true) : $('#VegRequestType').prop('checked', false);
                $("#FoodTypeCheckBoxList_1").is(':checked') ? $('#NonVegRequestType').prop('checked', true) : $('#NonVegRequestType').prop('checked', false);

                $(".tm-inputSideDishes").tagsManager();
                $(".tm-inputAvoidingredients").tagsManager();


                if ($("#isUserLoggedIn").val() == "true") {
                    $("#ButtonNotifySelectedUsers").val("Notify selected users");
                    $("#ButtonNotifyAllUsers").val("Notify all users");
                } else {
                    $("#ButtonNotifySelectedUsers").val("Login to notify selected users");
                    $("#ButtonNotifyAllUsers").val("Login to notify all users");
                }

            }
        });
    }


    function FilterSearchResults(filtertype) {
        //alert(isUserListingTab);
        if (isUserListingTab) {
            var selectedTasteValues = "";
            var selectedFoodtype = "";
            var seletedRecipeType = "";
            var searchKeyWord;


            $("[id*=TasteCheckBoxList] input:checked").each(function () {
                selectedTasteValues = $(this).val() + "," + selectedTasteValues;
            });

            $("[id*=RecipeTypeCheckBoxList] input:checked").each(function () {
                seletedRecipeType = $(this).val() + "," + seletedRecipeType;
            });

            $("[id*=FoodTypeCheckBoxList] input:checked").each(function () {
                selectedFoodtype = $(this).val() + "," + selectedFoodtype;
            });

            if (mincost.length > 0) {
                if (maxCost.length == 0) {
                    maxCost = "1000";
                }
            }

            if (maxCost.length > 0) {
                if (mincost.length == 0) {
                    mincost = "0";
                }
            }



            searchKeyWord = $("#txtSearch").val();
            var postData = "{searchKeyWord:'" + searchKeyWord +
                            "',tasteId:'" + selectedTasteValues +
                            "',lat:'" + lat +
                            "',lang:'" + lang +
                            "',distance:'" + distance +
                            "',foodType:'" + selectedFoodtype +
                            "',recipeType:'" + seletedRecipeType +
                            "',costRange:'" + mincost + "-" + maxCost +
                            "',ratingRange:'" + minRating + "-" + maxRating +
                            "',filtertype:'" + filtertype + "'}";

            $.ajax({
                type: "POST",
                url: "Listings.aspx/UpdateSearchListingResult",
                data: postData,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    //Mask page
                    showProgress();
                },

                complete: function () {
                    //remove Mask
                    hideProgress();

                },
                error: function (msg) {

                },
                success: function (msg) {

                    $("#resultsCountDiv").html(msg.d.TotalResults < 1 ? 'No listings found in your area' : msg.d.TotalResults + " result(s)");

                    $("#listingsDiv").html(msg.d.ListingUserControlHTML);


                    if (filtertype == "foodType") {
                        $("#TasteCheckBoxListDiv").html(msg.d.TasteUserControlHTML);
                        $("#RecipeTypeDiv").html(msg.d.FoodRecipeTypeUserControlHTML);
                    }

                    if (filtertype == "taste") {
                        $("#FoodTypeCheckBoxListDiv").html(msg.d.FoodTypeUserControlHTML);
                        $("#RecipeTypeDiv").html(msg.d.FoodRecipeTypeUserControlHTML);
                    }

                    if (filtertype == "cost") {
                        $("#TasteCheckBoxListDiv").html(msg.d.TasteUserControlHTML);
                        $("#FoodTypeCheckBoxListDiv").html(msg.d.FoodTypeUserControlHTML);
                        $("#RecipeTypeDiv").html(msg.d.FoodRecipeTypeUserControlHTML);
                    }

                    if (filtertype == "distance") {
                        $("#TasteCheckBoxListDiv").html(msg.d.TasteUserControlHTML);
                        $("#FoodTypeCheckBoxListDiv").html(msg.d.FoodTypeUserControlHTML);
                        $("#RecipeTypeDiv").html(msg.d.FoodRecipeTypeUserControlHTML);
                    }

                    if (filtertype == "rating") {
                        $("#TasteCheckBoxListDiv").html(msg.d.TasteUserControlHTML);
                        $("#FoodTypeCheckBoxListDiv").html(msg.d.FoodTypeUserControlHTML);
                        $("#RecipeTypeDiv").html(msg.d.FoodRecipeTypeUserControlHTML);
                    }

                    if (filtertype == "none") {
                        $("#TasteCheckBoxListDiv").html(msg.d.TasteUserControlHTML);
                        $("#FoodTypeCheckBoxListDiv").html(msg.d.FoodTypeUserControlHTML);
                        $("#RecipeTypeDiv").html(msg.d.FoodRecipeTypeUserControlHTML);
                    }

                    if (filtertype == "recipeType") {
                        $("#TasteCheckBoxListDiv").html(msg.d.TasteUserControlHTML);
                        $("#FoodTypeCheckBoxListDiv").html(msg.d.FoodTypeUserControlHTML);

                    }
                }
            });
        } else {
            UpdateUserRequestTab();
        }

    }

    function UpdateUserRequestTab() {
        //alert("hi");

        $('#datetimepicker').datetimepicker({
            language: 'en',
            pick12HourFormat: true
        });

        var selectedTasteValue = [];

        $("[id*=TasteCheckBoxList] input:checked").each(function () {
            selectedTasteValue.push($(this).val());
        });

        //                var selectedTasteValues = selectedTasteValue.join(',');
        //                alert(selectedTasteValues);

        $("#TasteDropDownList").select2().select2('val', selectedTasteValue);
        $("#RequestCostTextBox").val(maxCost);

        $("#FoodTypeCheckBoxList_0").is(':checked') ? $('#VegRequestType').prop('checked', true) : $('#VegRequestType').prop('checked', false);
        $("#FoodTypeCheckBoxList_1").is(':checked') ? $('#NonVegRequestType').prop('checked', true) : $('#NonVegRequestType').prop('checked', false);

        $(".tm-inputSideDishes").tagsManager();
        $(".tm-inputAvoidingredients").tagsManager();
    }

    $('#divTop a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
        if ($(this).attr("href") == "#UserRequest") {
            isUserListingTab = false;
            SeachUser();
        } else {
            isUserListingTab = true;
            FilterSearchResults("none");
        }

        //alert(isUserListingTab);

    });

    function divContent_click(sender) {

        var divSender = $(sender);
        var divContent = divSender.parent().find(".contentDiv");
        divContent.toggle();
        var imageSpan = divSender.find("span");


        if (imageSpan.hasClass('icon-chevron-down')) {
            imageSpan.removeClass('icon-chevron-down').addClass('icon-chevron-left');

        } else if (imageSpan.hasClass('icon-chevron-left')) {
            imageSpan.removeClass('icon-chevron-left').addClass('icon-chevron-down'); ;
        } else {
            imageSpan.addClass('icon-chevron-down');
        }
    }
     
</script>

</html>
<script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
