<%@ Page Language="C#" ClientIDMode="Static" AutoEventWireup="true" CodeBehind="EditProfileSocialPreferance.aspx.cs"
    Inherits="KhanawalApplication.EditProfileSocialPreferance" %>
    
<%@ Register TagPrefix="ucTopNavigation" TagName="TopNavigationUserControl" Src="~/TopNavigationUserControl.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script src="js/vendor/bootstrap.min.js"></script>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/Custom.css" rel="stylesheet" type="text/css" />
    <!--[if lt IE 9]>
    <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
  <![endif]-->
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
                <li class="active"><a href="EditProfileSocialPreferance.aspx" runat="server" id="SocialPreferancelink">
                    <i class="icon-wrench"></i><b>Social Preferances</b></a></li>
                <li><a href="EditProfileContact.aspx" runat="server" id="EditProfileHyperlink"><i
                    class="icon-envelope"></i><b>Contact</b></a></li>
            </ul>
        </div>
        <div class="pull-left" style="margin-top: 10px; margin-left: 10px; width: 720px">
            <div class="control-group">
                <label class="control-label" for="DisplayPicture">
                    Display Picture</label>
                <div class="controls">
                    <asp:Image runat="server" ID="UserImage" ImageUrl="img/icons/Unknown.jpeg" />
                    <div class="form-helpers">
                        your picture, this picture will appear as display picture
                    </div>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="LastNameTextBox">
                    Post your listing on facebook
                </label>
                <div class="controls">
                    <asp:CheckBox runat="server" ID="PostListingOnFaceBookCheckbox" Checked="True" />
                    Allow facebook posting
                    <div class="form-helpers">
                        recommeded , As your listing is validated , we will post it on your facebook, so
                        many people can see your dish and it increses your chance of getting more request
                        inturn earn more money
                    </div>
                </div>
            </div>
            <div class="control-group">
                <div id="DivStatus">
                    
                </div>
            </div>
            <div class="control-group">
                <label class="control-label" for="SaveUserProfileButton">
                </label>
                <div class="controls">
                    <input id="btnSave" type="button" data-loading-text="Please Wait.." data-complete-text="Save" value="Save" class="btn btn-primary" onclick="UpdateSocialPrefarances()"/>
                    
                </div>
            </div>
        </div>
    </div>
   
    </form>
</body>
</html>
<script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
<script type="text/javascript">
    function UpdateSocialPrefarances() {

        $("#btnSave").button('loading');
        var postListingOnFaceBook = "0";
        if ($('#isAgeSelected').is(':checked')) {
            postListingOnFaceBook = "1";
        }
        var postData = "{postListingOnFaceBook:'" + postListingOnFaceBook + "'}";
        $.ajax({
            type: "POST",
            url: "EditProfileSocialPreferance.aspx/SaveUserProfile",
            data: postData,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
                $("#btnSave").button('complete');
                $("#DivStatus").fadeIn('slow').removeClass("alert-error").addClass("alert alert-success").text("Lisiting details updated successfully").delay(5000).fadeOut();
            },
            error: function (msg) {
                $("#btnSave").button('complete');
                $("#DivStatus").fadeIn('slow').removeClass("alert-success").addClass("alert alert-error").text("Error occured, please try again").delay(5000).fadeOut();
            }
        });
    }
</script>