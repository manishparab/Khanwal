<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TopNavigationUserControl.ascx.cs"
    Inherits="KhanawalApplication.TopNavigationUserControl" %>
<script type="text/javascript" src="js/FaceBookAuthentication.js"></script>
<script type="text/javascript">
    // very simple to use!
    $(document).ready(function () {
        $('.js-activated').dropdownHover().dropdown();
    });
</script>
<asp:HiddenField runat="server" ClientIDMode="Static" ID="HiddenFieldPageUserName" />
<asp:HiddenField runat="server" ClientIDMode="Static" ID="HiddenFieldReloadPage" />
<asp:HiddenField runat="server" ClientIDMode="Static" ID="HiddenFieldIsUserAutheticated" />
<div class="navbar navbar-fixed-top" id="DivTopNavigationContainer">
    <div class="navbar-inner">
        <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"><span
            class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
        </a><a class="brand classBold" href="/Home.aspx">Khanawal</a>
        <div class="nav-collapse collapse">
            <ul class="nav">
                <li class="dropdown"><a class="dropdown-toggle js-activated" style="font-weight: bold"
                    href="#">Browse Dishes <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a tabindex="-1" href="Listings.aspx?order=MP">Most Popular</a></li>
                        <li><a tabindex="-1" href="Listings.aspx?order=Near">Near to you</a></li>
                        <li><a tabindex="-1" href="Listings.aspx">All Dishes</a></li>
                    </ul>
                </li>
            </ul>
            <ul class="nav">
                <li class="dropdown"><a class="dropdown-toggle js-activated" style="font-weight: bold"
                    href="#">How-To<b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a tabindex="-1" href="How-To-Earn-Money.aspx">How-to Sell Dish to earn</a></li>
                        <li><a tabindex="-1" href="How-It-Works.aspx">How-to Request your dish</a></li>
                    </ul>
                </li>
            </ul>
            <ul class="nav">
                <li class="dropdown"><a class="dropdown-toggle js-activated" style="font-weight: bold"
                    href="#">About<b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a tabindex="-1" href="About-Khanawal.aspx">About Site</a></li>
                        <li><a tabindex="-1" href="AboutMe.aspx">About Me</a></li>
                    </ul>
                </li>
            </ul>
            <a class="btn btn-primary pull-right" style="margin-left: 20px" href="ListingNew.aspx">
                Add Your Dish</a> <a class="btn btn-primary pull-right" style="margin-left: 20px"
                    href="Listings.aspx?UserRequest=1">Request a dish</a>
            <ul class="nav pull-right" runat="server" id="InboxUl" visible="False">
                <li class="dropdown"><a style="font-weight: bold" class="dropdown-toggle" href="inbox.aspx">
                    Inbox </a></li>
            </ul>
            <ul class="nav pull-right" runat="server" id="currentUserUl" visible="False">
                <li class="dropdown"><a class="dropdown-toggle js-activated" style="font-weight: bold"
                    href="#">
                    <asp:Literal runat="server" ID="currentUserName"></asp:Literal>
                    <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a id="A1" runat="server" tabindex="-1" href="DashBoard.aspx">Dash Board</a></li>
                        <li><a id="A5" runat="server" tabindex="-1" href="Inbox.aspx">Inbox</a></li>
                        <li><a id="A2" runat="server" tabindex="-1" href="AutheticationRedirection.aspx?IsLogout=1">
                            Log Out</a></li>
                    </ul>
                </li>
            </ul>
            <ul class="nav pull-right" runat="server" id="Ul1" visible="False">
                <li class="dropdown"><a class="dropdown-toggle js-activated" style="font-weight: bold"
                    href="#">
                    <asp:Literal runat="server" ID="Literal1"></asp:Literal>
                    <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a id="A3" runat="server" tabindex="-1" href="#">Dash Board</a></li>
                        <li><a id="A4" runat="server" tabindex="-1" href="AutheticationRedirection.aspx?IsLogout=1">
                            Log Out</a></li>
                    </ul>
                </li>
            </ul>
            <ul class="nav pull-right" runat="server" id="SignUpUl">
                <li class="dropdown"><a class="dropdown-toggle js-activated" style="font-weight: bold"
                    href="#">Sign-Up<b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a id="A6" onclick="AuthenticateUser();" runat="server" tabindex="-1" href="#">Sign Up
                            With FaceBook</a></li>
                    </ul>
                </li>
            </ul>
            <ul class="nav pull-right" runat="server" id="LoginUl">
                <li class="dropdown"><a class="dropdown-toggle js-activated" style="font-weight: bold"
                    href="#">Login<b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a id="FaceBookRedirectUrl" onclick="AuthenticateUser();" runat="server" tabindex="-1"
                            href="#">Login with FaceBook</a></li>
                        <li style="display: none"><a id="TwitterRedirectUrl" runat="server" tabindex="-1"
                            href="#">Twitter</a></li>
                    </ul>
                </li>
            </ul>
        </div>
        <!-- .nav-collapse -->
    </div>
    <!-- .navbav-inner -->
</div>
<div id="DivLoginModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="LoginModalLabel"
    aria-hidden="true" data-keyboard="false" data-backdrop="static">
    <div class="modal-header">
        <h3 id="H1">
            Please login to continue</h3>
    </div>
    <div class="modal-body">
        <input type="button" value="Login" class="btn btn-primary" onclick=" AuthenticateUser()" />
        <input type="button" value="Cancel" class="btn btn-primary" onclick="redirectToHomePage()" />
    </div>
</div>

<script>

    function redirectToHomePage() {
        window.location.href = "Home.aspx";
    }

    function ShowAuthentication(isAuthenticated) {
        if (isAuthenticated == "0") {
            $("#DivLoginModal").modal();
        }
    }

    function AuthenticateUser() {
        FB.login(function (response) {
            if (response.authResponse) {
                GetUserData();
                $("#DivLoginModal").modal('hide');
            }
        }, { scope: 'email,user_location,user_birthday,publish_stream,user_about_me' });

    }
    (function (i, s, o, g, r, a, m) {
        i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
            (i[r].q = i[r].q || []).push(arguments)
        }, i[r].l = 1 * new Date(); a = s.createElement(o),
        m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
    })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

    ga('create', 'UA-42466418-1', 'khanawal.com');
    ga('send', 'pageview');


</script>
