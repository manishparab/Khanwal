<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="About-Khanawal.aspx.cs"
    Inherits="KhanawalApplication.About_Khanawal" %>

<%@ Register TagPrefix="ucTopNavigation" TagName="TopNavigationUserControl" Src="~/TopNavigationUserControl.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>About</title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script src="js/vendor/bootstrap.min.js"></script>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/Custom.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <ucTopNavigation:TopNavigationUserControl ID="TopNavigationUserControl1" runat="server" />
    <div>
        <div class="container" style="margin-top: 60px">
            <div id="blockTitle" class="navbar-inner">
                <h3>
                    About Khanawal
                </h3>
            </div>
            <div class="well">
               Khanawal.com is made for housewifes/ cooks who love to cook and love to eat various
                    home made dishes
                    <br /><br />
                    We all know , home made food is the best food on this earth,
                    <br /><br />
                    when we are away from home land , the thing which we miss most is home cooked food.
                    <br /><br />
                    Also we long for dishes we used to enjoy at friends house, khanawal.com is prepared
                    fullfill all foodies needs.
                    <br /><br />
                    There are no fees for registration, selling or buying home made food, there are
                    no google ad's too..
                    <br /><br />
                    I really want to thanks twitter bootstarp for providing beautiful free CSS , also
                    This website uses <a href="http://www.maxmind.com/en/javascript">GeoIP2 JavaScript from
                        MaxMind</a>. 
            </div>
        </div>
    </div>
    </form>
</body>
</html>
<script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
