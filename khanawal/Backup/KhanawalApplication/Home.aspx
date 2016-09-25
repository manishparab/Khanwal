<%@ Page Language="C#" AutoEventWireup="true" Inherits="KhanawalApplication.Home"
    CodeBehind="Home.aspx.cs" %>

<%@ Register Src="SubListing.ascx" TagName="SubListing" TagPrefix="uc1" %>
<%@ Register Src="TopNavigationUserControl.ascx" TagName="TopNavigationUserControl"
    TagPrefix="ucTopNavigation" %>
<%@ Register Src="DishTypesUserControl.ascx" TagName="DishTypesUserControl" TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Order Home made food ,Indian food ,chiken biryani, cake , indian snacks , pizza
        , prawn dishes, butter chicken, breakfast, dinner, indian Recipes, Sell food
    </title>
    <meta content="khanawal(khanawal.com) is online place providing home made yummy food, low fat food, sea food, healthy dishes and pure vagetarian dishes. The food is home cooked in home which makes it healthy and tasty .it is an alternative to tiffin service and restaurants.people can eat from food like seafood, Chiken to pure vegetarian food."
        name="Description" />
    <meta property="og:description" content="Khanawal: Order awesome home cooked food online. Eat tasty, healthy and home made food. Choose from a variety of dishes like Indian, Chinese, Mughlai, Punjabi & Italian." />
    <meta name="keywords" content="Order Home made food ,Indian food ,chiken biryani, cake , indian snacks , pizza , prawn dishes, butter chicken, breakfast, dinner, indian Recipes" />
    <meta name="author" content="khanawal.com" />
    <meta property="og:image" content="http://khanawal.com/Capture/Images/HomePage/HomeCooked_India_food.jpg">
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script src="js/vendor/bootstrap.min.js"></script>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/Custom.css" rel="stylesheet" type="text/css" />
    <link href="themes/default/default.css" rel="stylesheet" type="text/css" />
    <!--[if lt IE 9]>
    <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <link href="css/datepicker.css" rel="stylesheet" type="text/css" />
    <link href="css/nivo-slider.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.nivo.slider.js" type="text/javascript"></script>
    <script src="js/bootstrap-datepicker.js" type="text/javascript"></script>
    <link href="css/select2/select2.css" rel="stylesheet" type="text/css" />
    <script src="js/select2.min.js" type="text/javascript"></script>
    <script src="//j.maxmind.com/js/apis/geoip2/v2.0/geoip2.js" type="text/javascript"></script>
    <script src="https://maps.googleapis.com/maps/api/js?sensor=false&libraries=places"></script>
    <style>
        body
        {
            padding-top: 60px;
        }
        
        div.wrapper
        {
            position: relative;
        }
        
        .theme-default .nivoSlider img
        {
            height: 650px !important;
        }
        .input-append, .input-prepend
        {
            margin-bottom: 0px;
        }
        .ddlWidth
        {
            width: 150px;
            background-color: #FFF;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <ucTopNavigation:TopNavigationUserControl ID="TopNavigationUserControl1" runat="server" />
    <div id="wrapper">
        <a href="http://dev7studios.com" id="dev7link" title="Go to dev7studios">dev7studios</a>
        <div class="slider-wrapper theme-default">
            <div id="slider" class="nivoSlider">
                <asp:Repeater runat="server" ID="HeroImagesSliderRepeater">
                    <ItemTemplate>
                        <img src="<%# Eval("DisplayImageUrl") %>" alt="Alternate Text" />
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div id="htmlcaption" class="nivo-html-caption">
                <strong>This</strong> is an example of a <em>HTML</em> caption with <a href="#">a link</a>.
            </div>
        </div>
    </div>
    <div class="container">
        <div id="staticContentText">
            Taste authentic home cooking around the globe.
        </div>
        <div id="staticContent">
            <div class="input-prepend input-append" style="float: left">
                <div style="float: left; margin-left: 1px; margin-right: 1px;">
                    <span class="add-on" style="float:right"><i class="icon-map-marker"></i></span>
                    <asp:TextBox runat="server" placeholder="Area near to you" ID="TextBoxLocation" ClientIDMode="Static"
                        Width="250px"></asp:TextBox>
                </div>
                <div style="float: left; margin-left: 5px; margin-right: 10px;">
                    <select id="ddlFoodType" class="ddlWidth">
                        <option value="0">Food Type</option>
                        <option value="1">BreakFast</option>
                        <option value="11">snacks</option>
                        <option value="7">lunch & Dinner</option>
                        <option value="10">Soups</option>
                        <option value="5">Desert</option>
                        <option value="9">biryani & pulao</option>
                    </select>
                </div>
                <div style="float: left;">
                    <span class="add-on" style="float:right"><i class="icon-search"></i></span>
                    <asp:TextBox runat="server" placeholder="Dish you want to eat" ID="SearchTextBox"
                        ClientIDMode="Static" Width="250px"></asp:TextBox>
                </div>
                <div style="float: left; margin-left: 5px">
                    <input type="button" id="searchButton" onclick="naviagteToListing()" value="Search"
                        class="btn btn-primary" />
                </div>
            </div>
        </div>
        <div style="text-align: center; font-size: 20px; font-weight: bold; margin-top: 20px">
            Not sure what to eat, then click on your favorite dish below.
        </div>
        <!-- Example row of columns -->
        <uc1:SubListing ID="SubListingUserControl" runat="server" />
    </div>
    <script type="text/javascript">

        $(document).ready(function () {

            $(document).keypress(function (e) {

                if (e.which == 13) {
                    e.preventDefault();
                    // enter pressed
                    var searchKeyWord = $("#SearchTextBox").val();
                    window.location.href = "/Listings.aspx?K=" + searchKeyWord + "&" ;
                }
            });
        });

        $(window).load(function () {
            $('#slider').nivoSlider(
                {
                    effect: 'fade',
                    pauseTime: 6000, // How long each slide will show
                    directionNav: false, // Next & Prev navigation
                    controlNav: true, // 1,2,3... navigation
                    controlNavThumbs: false, // Use thumbnails for Control Nav
                    pauseOnHover: false // Stop animation while hovering
                }
            );

            $("#dp3").datepicker({
                format: 'dd-mm-yyyy'
            });


            var onSuccess = function (location) {
                codeLatLng(location.location.latitude, location.location.longitude);
            };

            var onError = function (error) {
            };

            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function (position) {
                    codeLatLng(position.coords.latitude, position.coords.longitude);
                }, function (error) {
                    geoip2.city(onSuccess, onError);
                }, { timeout: 5000 });
            } else {
                geoip2.city(onSuccess, onError);
            }

            var pac_input = document.getElementById('TextBoxLocation');
            var autocomplete = new google.maps.places.Autocomplete(pac_input);


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
                                var simulated_downarrow = $.Event("keydown", { keyCode: 40, which: 40 })
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


        });


        function codeLatLng(lattitude, longitude) {
            var geocoder = new google.maps.Geocoder();
            var latlng = new google.maps.LatLng(lattitude, longitude);
            geocoder.geocode({ 'latLng': latlng }, function(results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    if (results[1]) {
                        $("#TextBoxLocation").val(results[0].formatted_address);
                    }
                }
            });
        }

        function naviagteToListing() {
            var searchKeyWord = $("#SearchTextBox").val();
            document.location.href = "/Listings.aspx?K=" + searchKeyWord;
        }

       
    </script>
    <script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
    </form>
</body>
</html>
