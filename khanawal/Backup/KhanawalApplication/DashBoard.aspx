<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="DashBoard.aspx.cs"
    Inherits="KhanawalApplication.DashBoard" %>


<%@ Register Src="TopNavigationUserControl.ascx" TagName="TopNavigationUserControl"
    TagPrefix="ucTopNavigation" %>
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
    <form id="form1" runat="server">
    <ucTopNavigation:TopNavigationUserControl ReloadPage="True" IsAuthenticated="True"
        ID="TopNavigationUserControl1" runat="server" />
    <div class="container">
        <div>
            <div style="width: 200px; margin-top: 60px" class="pull-left">
                <div class="well pull-left">
                    <ul class="nav nav-list" style="width:150px">
                        <li class="active"><a href="#">Dashboard</a></li>
                        <li><a href="Inbox.aspx">Inbox</a></li>
                        <li><a href="MYListings.aspx">My Dishes</a></li>
                        <li><a href="MyRequests.aspx">My Requests</a></li>
                        <li><a href="UpdateCalendar.aspx">My Calendar</a></li>
                    </ul>
                </div>
                <div class="pull-left" style="width: 195px; border-width: 2px; padding: 4px; border-color: #D4D4D4;
                    border-style: solid;">
                    <asp:Image runat="server" ID="UserImage" Width="195px" Height="195px" ImageUrl="" />
                    <br />
                    <div class="caption" style="text-align: center">
                        <a href="UserProfile.aspx?ID=<%#Eval("User.UserID")%>">
                            <h3>
                                <asp:Literal runat="server" ID="UserNameLiteral"></asp:Literal>
                            </h3>
                        </a><a href="EditProfile.aspx">Edit Profile</a>
                    </div>
                </div>
            </div>
            <div class="pull-left" style="margin-top: 60px">
                <div class="span9">
                    <div class="pull-left">
                        <div id="inbox" class="pull-left" style="width: 680px; margin-left: 5px">
                            <div class="navbar-inner" style="text-align: center">
                                <h4>
                                    <asp:Literal runat="server" ID="resultLiteral"></asp:Literal>
                                    New Message(s)</h4>
                            </div>
                            <div style="border-style: solid; border-width: 1px; border-color: #D4D4D4; margin-bottom: 5px;">
                                <ul class="unstyled">
                                    <asp:ListView ID="InboxListview" runat="server">
                                        <ItemTemplate>
                                            <li>
                                                <div class="user" style="width: 130px">
                                                    <img style="width: 50px; height: 50px" alt="<%# Eval("UserDisplayPictureUrl") %>"
                                                        src="<%# Eval("UserDisplayPictureUrl") %>" />
                                                    <p>
                                                        <%# Eval("UserName")%>
                                                        <br />
                                                        <%# Eval("InboxMessageThread.MessageDate", "{0:dd/MM/yyyy}")%>
                                                    </p>
                                                </div>
                                                <div class="message_details">
                                                    <a class="<%# (bool)Eval("MarkedAsRead")?"Inbox_Unread":"Inbox_Read"%>" href="InboxThread.aspx?ID=<%# Eval("InboxMainMessage.ID")%>">
                                                        <%# Eval("InboxMessageThread.Message")%>
                                                    </a>
                                                </div>
                                                <div class="status">
                                                    <%# Eval("InboxMessageThread.UserMessage")%>
                                                </div>
                                            </li>
                                        </ItemTemplate>
                                        <EmptyDataTemplate>
                                            <li>
                                                <h5>
                                                    No new message</h5>
                                            </li>
                                        </EmptyDataTemplate>
                                    </asp:ListView>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
   
    </form>
</body>
</html>
<script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
