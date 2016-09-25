<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Requests.aspx.cs" Inherits="KhanawalApplication.Requests" %>

<%@ Register src="RequestsUserControl.ascx" tagname="RequestsUserControl" tagprefix="uc1" %>
<%@ Register TagPrefix="ucTopNavigation" TagName="TopNavigationUserControl" Src="~/TopNavigationUserControl.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Requests</title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script src="js/vendor/bootstrap.min.js"></script>
    <script src="js/vendor/modernizr-2.6.1-respond-1.1.0.min.js"></script>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/Custom.css" rel="stylesheet" type="text/css" />
 <style>
     .input-Search {
         width: 150px !important;
     }
 </style>
</head>
<body>
    <form id="form1" runat="server">
        <ucTopNavigation:TopNavigationUserControl
        ID="TopNavigationUserControl1" runat="server" />
    <div class="container" style="margin-top: 60px">
        <div style="width: 200px" class="well pull-left">
            <input type="text" id="SearchRequest" class="input-Search" /> 
            <input type="button" name="searchbutton" id="searchbutton" value="Search" class=" btn btn-primary" />
        </div>
        <div class="pull-left">
            <div class="span9">
                <uc1:RequestsUserControl ID="RequestsUserControl1"  runat="server" />
            </div>
        </div>
    </div>
    </form>
</body>
</html>
<script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>