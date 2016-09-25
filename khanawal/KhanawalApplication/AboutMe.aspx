<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AboutMe.aspx.cs" Inherits="KhanawalApplication.AboutMe" %>

<%@ Register Src="TopNavigationUserControl.ascx" TagName="TopNavigationUserControl"
    TagPrefix="ucTopNavigation" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>About me </title>
    <meta content="Search  your favourite dish using various filters like distance, food type, food taste, distance.Or you can request your dish from users in your area.khanawal(khanawal.com) is online place providing home made yummy food, low fat food, sea food, healthy dishes and pure vagetarian dishes. The food is home cooked in home which makes it healthy and tasty .it is an alternative to tiffin service and restaurants.people can eat from food like seafood, Chiken to pure vegetarian food."
        name="Description" />
    <meta name="keywords" content="Manish Parab, Search food, Request food, Search Home made dish, Request dish, Order Home made food ,Indian food ,chiken biryani, cake , indian snacks , pizza , prawn dishes, butter chicken, breakfast, dinner, indian Recipes" />
    <meta name="author" content="khanawal.com" />
    <meta property="og:image" content="http://khanawal.com/Capture/Images/HomePage/HomeCooked_India_food.jpg">
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <script src="js/vendor/bootstrap.min.js"></script>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/Custom.css" rel="stylesheet" type="text/css" />
    <link href="themes/default/default.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        body
        {
            padding-top: 60px;
            padding-bottom: 40px;
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
            <div style="border-width: 2px; padding: 4px; border-color: #D4D4D4; border-style: solid;
                max-width: 380px;">
                <h4>Manish Parab</h4>
                <asp:Image ImageUrl="~/img/Me.jpg" runat="server" />
                <br />
                <b>That is me and this picture is clicked by my wife using my fav phone N73 at goa.</b>
                <br />
                <br />
                I'm passionate about technology and research, I have been developing websites from
                past 8 years and mostly in Sharepoint and asp.net.
                <br />
                <br />
                I like traveling with my family and enjoy life as it comes.
                <br />
                <br />
                you can contact me at <a href="mailto:admin@khanawal.com">admin@khanawal.com</a> or <a href="mailto:manish.parab@hotmail.com">
                    manish.parab@hotmail.com</a> . I will be happy to reply.
            </div>
        </div>
    </div>
    </form>
</body>
</html>
<script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
