<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="How-To-Earn-Money.aspx.cs"
    Inherits="KhanawalApplication.How_To_Earn_Money" %>

<%@ Register TagPrefix="ucTopNavigation" TagName="TopNavigationUserControl" Src="~/TopNavigationUserControl.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
               Cooks Have 2 ways to earn money
            </h4>
        </div>
       
        <h2>
            Way 1
        </h2>
        <div id="Div3">
            <div class="step-item">
                <p class="pull-left">
                    <img src="img/HowItWorks/icon-search.png" alt="Search" />
                </p>
                <h3>
                    1.Register
                </h3>
                <p>
                    Register to khanawal, set up your basic profile information like your location.
                </p>
            </div>
            <div class="step-item step-even">
                <p class="pull-left">
                    <img src="img/HowItWorks/icon-search.png" alt="Search" />
                </p>
                <h3>
                    2.Create new Dish(es)
                </h3>
                <p>
                    Post your dishes which every one will love and remember the taste , dont forget
                    to add beautiful pictures of your dishes.your dish will appear in site and users search.
                </p>
            </div>
            <div class="step-item">
                <p class="pull-left">
                    <img src="img/HowItWorks/icon-search.png" alt="Search" />
                </p>
                <h3>
                    3.Confirm dish request
                </h3>
                <p>
                    lot of users will send you request for a dish(es), you can communicate with users and send user acceptance for dish request.
                </p>
            </div>
            <div class="step-item step-even">
                <p class="pull-left">
                    <img src="img/HowItWorks/icon-search.png" alt="Search" />
                </p>
                <h3>
                    4. Prepare a dish
                </h3>
                <p>
                    Cook a dish for which you have got request.
                </p>
            </div>
            <div class="step-item step-Last">
                <p class="pull-left">
                    <img src="img/HowItWorks/icon-search.png" alt="Search" />
                </p>
                <h3>
                    5. Deliver
                </h3>
                <p>
                    Deliver the dish at your door step/requestors door step. Dont forget to take your
                    cash $$$.
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
                      Registered users will request their fav dish, he can customize his request based on his choices [time, money, ingredients..ect]
                </p>
            </div>
            <div class="step-item step-even">
                <p class="pull-left">
                    <img src="img/HowItWorks/icon-search.png" alt="Search" />
                </p>
                <h3>
                    2. you will get notified.
                </h3>
                <p>
                    All/Selected cooks in users area will get notified about user's request.
                </p>
            </div>
            <div class="step-item">
                <p class="pull-left">
                    <img src="img/HowItWorks/icon-search.png" alt="Search" />
                </p>
                <h3>
                    3. Send acknowledgement
                </h3>
                <p>
                   Send acknowledge about requested dish with your availability and cost and preparation time.
                </p>
            </div>
             <div class="step-item step-even">
                <p class="pull-left">
                    <img src="img/HowItWorks/icon-search.png" alt="Search" />
                </p>
                <h3>
                    3. Prepare a dish
                </h3>
                <p>
                    if User likes your quotation about dish, you will get notified, prepare dish in such way that user never forgets taste.
                </p>
            </div>
            <div class="step-item step-Last">
                <p class="pull-left">
                    <img src="img/HowItWorks/icon-search.png" alt="Search" />
                </p>
                <h3>
                    4. Deliver
                </h3>
                <p>
                    Deliver the dish at your door step/requestors door step. Dont forget to take your
                    cash $$$.
                </p>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
<script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>