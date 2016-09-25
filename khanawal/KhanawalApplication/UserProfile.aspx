<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="KhanawalApplication.UserProfile" %>

<%@ Register TagPrefix="ucTopNavigation" TagName="TopNavigationUserControl" Src="~/TopNavigationUserControl.ascx" %>
<%@ Register src="UserListings.ascx" tagname="UserListings" tagprefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script src="js/vendor/bootstrap.min.js"></script>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/Custom.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <ucTopNavigation:TopNavigationUserControl ID="TopNavigationUserControl1" runat="server" />
    <div class="container" style="margin-top: 60px">
        <div class="row">
            <div class="span3">
                <div style="border-width: 2px; padding: 4px; border-color: #D4D4D4; border-style: solid;">
                    <asp:Image runat="server" ID="UserImage" Width="220px" Height="220px" ImageUrl="https://graph.facebook.com/manish.parab.31/picture?type=large" />
                    <br />
                    <div class="caption" style="text-align: center">
                        <h2>
                            <asp:Literal Text="" runat="server" ID="UserNameLiteral"></asp:Literal>
                        </h2>
                    </div>
                </div>
            </div>
            <div class="span9">
                <div class="navbar-inner" style="text-align: center">
                    <h4>
                        About Me
                    </h4>
                </div>
                <div style="border-style: solid; border-width: 1px; border-color: #D4D4D4; margin-bottom: 5px;">
                    <div style="margin: 10px">
                         <asp:Literal Text="" runat="server" ID="UserDescriptionLiteral"></asp:Literal>
                    </div>
                </div>
                 <div class="navbar-inner" style="text-align: center">
                    <h4>
                       My Dishes
                    </h4>
                </div>
                <div style="border-style: solid; border-width: 1px; border-color: #D4D4D4; margin-bottom: 5px;">
                    <div style="margin: 10px">
                        <uc1:UserListings ID="UserListings" runat="server" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
<script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
