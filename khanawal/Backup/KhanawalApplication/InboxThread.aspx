<%@ Page Language="C#" AutoEventWireup="true" Inherits="KhanawalApplication.InboxThread"
    CodeBehind="InboxThread.aspx.cs" %>
    
<%@ Register Src="InboxMessageThreadUserControl.ascx" TagName="InboxMessageThreadUserControl"
    TagPrefix="uc1" %>
<%@ Register TagPrefix="ucTopNavigation" TagName="TopNavigationUserControl" Src="~/TopNavigationUserControl.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script>        window.jQuery || document.write('<script src="js/vendor/jquery-1.8.2.min.js"><\/script>')</script>
    <script src="js/vendor/bootstrap.min.js"></script>
    <script src="js/vendor/modernizr-2.6.1-respond-1.1.0.min.js"></script>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/Custom.css" rel="stylesheet" type="text/css" />
    <link href="themes/default/default.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .Message_header
        {
            height: 50px;
            background-image: -moz-linear-gradient(top, #FEFEFE, #E8E8E8);
            background-image: -ms-linear-gradient(top, #FEFEFE, #E8E8E8);
            background-image: -webkit-linear-gradient(top, #FEFEFE, #E8E8E8);
            background-image: -o-linear-gradient(top, #FEFEFE, #E8E8E8);
            background-image: linear-gradient(top, #FEFEFE, #E8E8E8);
            margin: 0 0 0px 0;
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#fffefefe', endColorstr='#ffe8e8e8', GradientType=0);
            position: relative;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <ucTopNavigation:TopNavigationUserControl IsAuthenticated="True" ReloadPage="True" ID="TopNavigationUserControl1" runat="server" />
    <div class="container" style="margin-top: 60px">
        <div id="blockTitle" class="navbar-inner" align="left">
            <h4>
                <a href="DashBoard.aspx">DashBoard</a> > <a href="Inbox.aspx">Inbox</a></h4>
        </div>
        <br />
        <div class="span12">
            <div class="span9">
                <div id="inbox_Message_Thread">
                    <uc1:InboxMessageThreadUserControl ID="InboxMessageThreadUserControl" runat="server" />
                </div>
                <div class="control-group">
                    <div id="DivStatus" class="">
                    </div>
                </div>
            </div>
        </div>
    </div>
   
    </form>
</body>
<script type="text/javascript">

    function confirmRequest(buttonObject) {
        $(buttonObject).button('loading');
        var fromUserIdHidden = $(buttonObject).parent().parent().find("#FromUserIdHidden").val();
        var toUserIdHidden = $(buttonObject).parent().parent().find("#ToUserIdHidden").val();
        var mainMessageIdHidden = $(buttonObject).parent().parent().find("#MainMessageIdHidden").val();

        var postData = "{mainMessageIdHidden:" + mainMessageIdHidden + ",toUserIdHidden:" + toUserIdHidden + ",fromUserIdHidden:" + fromUserIdHidden + "}";
        $.ajax({
            type: "POST",
            url: "InboxThread.aspx/ConfirmRequest",
            data: postData,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
                if (msg.d.length > 0) {
                  
                        window.location = 'Inbox.aspx';
                        $(buttonObject).button('complete');
                }
            },
            error: function (msg) {
                $(buttonObject).button('complete');
                $("#DivStatus").fadeIn('slow').removeClass("alert-success").addClass("alert alert-error").text("Error occured, please try again").delay(5000).fadeOut();
            }
        });

        return false;
    }

    function sendReply(buttonObject) {
        $(buttonObject).button('loading');
        var fromUserIdHidden = $(buttonObject).parent().parent().find("#FromUserIdHidden").val();
        var toUserIdHidden = $(buttonObject).parent().parent().find("#ToUserIdHidden").val();
        var mainMessageIdHidden = $(buttonObject).parent().parent().find("#MainMessageIdHidden").val();
        var userMessage = $(buttonObject).parent().find("#ReplyMessage").val();

        var postData = "{mainMessageIdHidden:" + mainMessageIdHidden + ",userMessage:'" + userMessage + "',toUserIdHidden:" + toUserIdHidden + ",fromUserIdHidden:" + fromUserIdHidden + "}";
        $.ajax({
            type: "POST",
            url: "InboxThread.aspx/SendReply",
            data: postData,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
                if (msg.d.length > 0) {
                    window.location = 'Inbox.aspx';
                }
                $(buttonObject).button('complete');
            },
            error: function (msg) {
                $(buttonObject).button('complete');
                $("#DivStatus").fadeIn('slow').removeClass("alert-success").addClass("alert alert-error").text("Error occured, please try again").delay(5000).fadeOut();
            }
        });

    }
</script>
</html>
<script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
