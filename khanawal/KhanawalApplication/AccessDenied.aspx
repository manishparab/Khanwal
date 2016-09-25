<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccessDenied.aspx.cs" Inherits="KhanawalApplication.AccessDenied" %>

<%@ Register Src="TopNavigationUserControl.ascx" TagName="TopNavigationUserControl"
    TagPrefix="ucTopNavigation" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <!--[if lt IE 9]>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?v=3&sensor=true"></script>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/Custom.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server" class="form-class">
    <ucTopNavigation:TopNavigationUserControl ID="TopNavigationUserControl1" runat="server" />
    <div class="container" style="margin-top: 60px;">
        <div id="blockTitle" class="navbar-inner" align="center">
            <h4>
                Access Denied
            </h4>
        </div>
        <div class="alert alert-error" style="margin-top: 25px">
            You dont have access to page you are trying access.Go back to site <a href="Home.aspx">
                Khanawal</a>
        </div>
    </div>
    <!-- Modal -->
     
    </form>
</body>
</html>
<script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
