<%@ Page Language="C#" AutoEventWireup="true" Inherits="KhanawalApplication.Inbox"
    CodeBehind="Inbox.aspx.cs" %>


<%@ Register Src="TopNavigationUserControl.ascx" TagName="TopNavigationUserControl"
    TagPrefix="ucTopNavigation" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Inbox</title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script src="js/vendor/bootstrap.min.js"></script>
    <script src="js/vendor/modernizr-2.6.1-respond-1.1.0.min.js"></script>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/Custom.css" rel="stylesheet" type="text/css" />
    <link href="themes/default/default.css" rel="stylesheet" type="text/css" />
    <!--[if lt IE 9]>
    <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
  <![endif]-->
</head>
<body>
    <form id="form1" runat="server">
    <ucTopNavigation:TopNavigationUserControl IsAuthenticated="True" ReloadPage="True"
        ID="TopNavigationUserControl1" runat="server" />
    <div class="container">
        <div style="width: 200px; margin-top: 60px" class="well pull-left">
            <ul class="nav nav-list">
                <li><a href="DashBoard.aspx">Dashboard</a></li>
                <li class="active"><a href="#">Inbox</a></li>
                <li><a href="MYListings.aspx">My Dishes</a></li>
                <li><a href="MyRequests.aspx">My Requests</a></li>
                <li><a href="UpdateCalendar.aspx">My Calendar</a></li>
            </ul>
        </div>
        <div class="pull-left" style="margin-top: 60px">
            <div class="span9">
                <div id="inbox">
                    <div class="navbar-inner">
                        <h5>
                            <asp:Literal runat="server" ID="resultLiteral"></asp:Literal>
                            New Messages</h5>
                    </div>
                    <ul class="unstyled">
                        <asp:ListView ID="InboxListview" runat="server" OnItemDataBound="InboxListview_ItemDataBound">
                            <ItemTemplate>
                                <li>
                                    <div class="user">
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
                                        No new mails</h5>
                                </li>
                            </EmptyDataTemplate>
                        </asp:ListView>
                    </ul>
                </div>
            </div>
        </div>
    </div>
   
    </form>
</body>
</html>
<script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
