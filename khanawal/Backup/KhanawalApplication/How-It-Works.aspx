<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="How-It-Works.aspx.cs" Inherits="KhanawalApplication.How_It_Works" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register TagPrefix="ucTopNavigation" TagName="TopNavigationUserControl" Src="~/TopNavigationUserControl.ascx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>How it Works</title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script src="js/vendor/bootstrap.min.js"></script>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/Custom.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .form-helpers
        {
            margin-top: 6px;
            margin-bottom: 4px;
            line-height: 16px;
            color: #c8c8c8;
        }
        .step-item
        {
            background: url(img/HowItWorks/step-arrow-odd.png) 445px 40px no-repeat;
            min-height: 115px;
            padding: 5px 520px 0 50px;
        }
        .step-even
        {
            background: url(img/HowItWorks/step-arrow-even.png) 160px 32px no-repeat;
            padding: 5px 50px 0 520px;
        }
        
        .step-Last
        {
            background: none !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <ucTopNavigation:TopNavigationUserControl ID="TopNavigationUserControl1" runat="server" />
    <div class="container" style="margin-top: 60px">
        <div id="blockTitle" class="navbar-inner">
            <h4>
                Guest Or Registered User Has 2 ways to enjoy their fav food
            </h4>
        </div>
        <h2>
            way 1
        </h2>
        <div id="step-Process">
            <div class="step-item">
                <p class="pull-left">
                    <img src="img/HowItWorks/icon-search.png" alt="Search" />
                </p>
                <h3>
                    1. Dish Discovery
                </h3>
                <p>
                    All users can search thier fav dishes , all the results will be filtered according
                    to users current location.
                </p>
            </div>
            <div class="step-item step-even">
                <p class="pull-left">
                    <img src="img/HowItWorks/icon-search.png" alt="Search" />
                </p>
                <h3>
                    2. View Details for dish
                </h3>
                <p>
                    From the search result users can select to view details like price, reviews, pickup
                    location of dish they want to eat.
                </p>
            </div>
            <div class="step-item">
                <p class="pull-left">
                    <img src="img/HowItWorks/icon-search.png" alt="Search" />
                </p>
                <h3>
                    3. Book a Dish
                </h3>
                <p>
                    From Details page they can book dish.
                </p>
            </div>
            <div class="step-item step-even step-Last">
                <p class="pull-left">
                    <img src="img/HowItWorks/icon-search.png" alt="Search" />
                </p>
                <h3>
                    4. Eat
                </h3>
                <p>
                    Upon confirmation from cook, Get/Pick-up your dish and Enjoy your fav dish.
                </p>
            </div>
        </div>
        <h2>
            way 2
        </h2>
        <div id="Div1">
            <div class="step-item">
                <p class="pull-left">
                    <img src="img/HowItWorks/icon-search.png" alt="Search" />
                </p>
                <h3>
                    1. Dish Request
                </h3>
                <p>
                    Registered users can request their fav dish, he can customize his request based
                    on his choices [time, money, ingredients..ect]
                </p>
            </div>
            <div class="step-item step-even">
                <p class="pull-left">
                    <img src="img/HowItWorks/icon-search.png" alt="Search" />
                </p>
                <h3>
                    2. Cooks are notified.
                </h3>
                <p>
                    All/Selected cooks in users area gets notification about user's request, they acknowledge
                    about dish with there availability and cost.
                </p>
            </div>
            <div class="step-item">
                <p class="pull-left">
                    <img src="img/HowItWorks/icon-search.png" alt="Search" />
                </p>
                <h3>
                    3. Select a cook
                </h3>
                <p>
                    Upon cook's acknowledgment user can select the cook which he feels is best.
                </p>
            </div>
            <div class="step-item step-even step-Last">
                <p class="pull-left">
                    <img src="img/HowItWorks/icon-search.png" alt="Search" />
                </p>
                <h3>
                    4. Eat
                </h3>
                <p>
                    Upon notification from cook, Get/Pick-up your dish and Enjoy your fav dish.
                </p>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
<script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
