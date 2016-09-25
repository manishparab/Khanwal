<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RequestsUserControl.ascx.cs"
    Inherits="KhanawalApplication.RequestsUserControl" %>
<style type="text/css">
    .Requestuser
    {
        float: left;
        width: 200px;
    }
    .message_details_requests
    {
        float: left;
        width: 300px;
    }
</style>
<div id="inbox">
    <div class="navbar-inner">
        <h5>
            <asp:Literal runat="server" ID="resultLiteralTitle"></asp:Literal>
            Open request 
            </h5>
    </div>
    <ul class="unstyled">
        <asp:ListView ID="RequestsListview" runat="server">
            <ItemTemplate>
                <li>
                    <div class="Requestuser">
                        <div style="float: left">
                            <img alt="<%# Eval("User.ImageUrl") %>" src="<%# Eval("User.ImageUrl") %>" />
                        </div>
                        <div style="float: left; margin-left: 5px">
                            <%# Eval("User.first_name")%>
                            <%# Eval("User.last_name")%>
                        </div>
                        <br />
                    </div>
                    <div class="message_details_requests">
                        <a  href="AdhocRequestDetails.aspx?ID=<%#Eval("Id")%>">
                            <%# Eval("Title")%>
                            for
                            <%# Eval("PersonCount")%>
                            at
                            <%# Eval("DeliveryTime")%>
                        </a>
                        <br />
                        Time Remaining :
                        <%# Math.Floor((Convert.ToDateTime(Eval("DeliveryTime")) - DateTime.Now).TotalDays) > 0 ? Math.Floor((Convert.ToDateTime(Eval("DeliveryTime")) - DateTime.Now).TotalDays) + " days" : string.Empty%>
                        <%# (Convert.ToDateTime(Eval("DeliveryTime")) - DateTime.Now).ToString(@"hh\:mm\:ss")%>
                    </div>
                    <div>
                        <a class="btn btn-primary" href="AdhocRequestDetails.aspx?ID=<%#Eval("Id")%>">View
                            Details </a>
                    </div>
                </li>
            </ItemTemplate>
            <EmptyDataTemplate>
                <li>
                    <div class="alert alert-error">
                        No Open requests
                    </div>
                </li>
            </EmptyDataTemplate>
        </asp:ListView>
    </ul>
</div>
