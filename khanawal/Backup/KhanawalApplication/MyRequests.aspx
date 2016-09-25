<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyRequests.aspx.cs" Inherits="KhanawalApplication.MyRequests" %>

<%@ Register TagPrefix="ucTopNavigation" TagName="TopNavigationUserControl" Src="~/TopNavigationUserControl.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script src="js/vendor/bootstrap.min.js"></script>
    <script src="js/vendor/modernizr-2.6.1-respond-1.1.0.min.js"></script>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/Custom.css" rel="stylesheet" type="text/css" />
    <link href="themes/default/default.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <ucTopNavigation:TopNavigationUserControl ReloadPage="True" IsAuthenticated="True"
        ID="TopNavigationUserControl1" runat="server" />
    <div class="container" style="margin-top: 60px">
        <div style="width: 200px" class="well pull-left">
            <ul class="nav nav-list">
                <li><a href="DashBoard.aspx">Dashboard</a></li>
                <li><a href="Inbox.aspx">Inbox</a></li>
                <li><a href="MYListings.aspx">My Dishes</a></li>
                <li class="active"><a href="#">My Requests</a></li>
                <li><a href="UpdateCalendar.aspx">My Calendar</a></li>
            </ul>
        </div>
        <div class="span9 pull-left">
            <div id="myRequests">
                <div class="navbar-inner">
                    <h5>
                        <asp:Literal runat="server" ID="resultLiteral"></asp:Literal>
                        My Request</h5>
                </div>
                <ul class="unstyled">
                    <asp:ListView ID="MyRequestsListview" runat="server">
                        <ItemTemplate>
                            <li>
                                <div class="listing">
                                    <img style="width: 50px; height: 50px" alt="<%# Eval("Title") %>" src="<%# Eval("DisplayPicUrl") %>" />
                                    <p>
                                        <a href="ListingDetails.aspx?ID=<%# Eval("ListingId") %>">
                                            <%# Eval("Title")%>
                                        </a>
                                        <br />
                                        <%# Eval("RequestedDate", "{0:dd/MM/yyyy}")%>
                                    </p>
                                </div>
                                <div class="data">
                                    <%# Eval("RequestedServings")%>
                                    person(s)
                                </div>
                                <div class="data">
                                    <%# Eval("Cost")%>
                                    Rs
                                </div>
                                <div class="data">
                                    <a href="InboxThread.aspx?ID=<%# Eval("mainMessageId") %>">
                                        <%# Eval("Status")%>
                                    </a>
                                </div>
                            </li>
                        </ItemTemplate>
                        <EmptyDataTemplate>
                            <li>
                                <h5>
                                    No Requests</h5>
                            </li>
                        </EmptyDataTemplate>
                    </asp:ListView>
                </ul>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
<script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
