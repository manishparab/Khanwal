<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditProfileContact.aspx.cs"
    Inherits="KhanawalApplication.EditProfileContact" %>
    
<%@ Register TagPrefix="ucTopNavigation" TagName="TopNavigationUserControl" Src="~/TopNavigationUserControl.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
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
    </style>
</head>
<body>
    <form id="form1" runat="server" class="form-horizontal">
    <ucTopNavigation:TopNavigationUserControl ReloadPage="True" IsAuthenticated="True" ID="TopNavigationUserControl1" runat="server" />
    <div class="container" style="margin-top: 60px">
        <div id="blockTitle" class="navbar-inner" align="left">
            <h4>
                <a href="#">DashBoard</a> > Social Preferances
            </h4>
        </div>
        
        <div style="width: 217px;" class="well pull-left">
            <ul class="nav nav-list">
                <li><a href="EditProfile.aspx" runat="server" id="NameAndDescriptionHyperlink">
                    <i class="icon-user"></i><b>Basic Profile</b></a></li>
                <li><a href="EditProfileSocialPreferance.aspx" runat="server" id="SocialPreferancelink">
                    <i class="icon-wrench"></i><b>Social Preferances</b></a></li>
                <li class="active"><a href="EditProfileContact.aspx" runat="server" id="EditProfileHyperlink"><i
                    class="icon-envelope"></i><b>Contact</b></a></li>
            </ul>
        </div>
        <div class="pull-left" style="margin-top: 10px; margin-left: 10px; width: 720px">
            <div class="control-group">
                <label class="control-label" for="DisplayPicture">
                    Phone
                </label>
                <div class="controls">
                    <asp:CheckBox runat="server" ID="PhoneCheckbox" Checked="True"/> Recive SMS on Phone
                    <div class="form-helpers">
                        We will send reminders as SMS about dish pickup or delivery
                    </div>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="SaveUserProfileButton">
                </label>
                <div class="controls">
                    <asp:Button runat="server" ID="SaveUserProfileButton" Text="Save" 
                        CssClass="btn-primary" onclick="SaveUserProfileButton_Click" />
                </div>
            </div>
        </div>
    </div>
    
    </form>
</body>
</html>
<script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>