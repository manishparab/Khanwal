<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="InboxMessageThreadUserControl.ascx.cs"
    Inherits="KhanawalApplication.InboxMessageThreadUserControl" %>
<ul class="unstyled">
    <asp:ListView runat="server" ID="MessageThreadListview" OnItemDataBound="MessageThreadListview_ItemDataBound">
        <ItemTemplate>
            <li>
                <div style="clear: both">
                    <div class="thumbnailPic">
                        <asp:Literal runat="server" ID="rightSideUserLiteral"></asp:Literal>
                    </div>
                    <div class="Inbox_Message">
                        <div class="Message_header" style="text-align: center">
                            <asp:Literal runat="server" ID="ActorUserNameLiteral"></asp:Literal>
                            <asp:Literal runat="server" ID="ActionLiteral"></asp:Literal>
                            <a href="#">
                                <%# Eval("ListingName")%></a>
                            <br />
                            on
                            <%# Eval("InboxThreadListingRequest.RequestedDate","{0:dd MMM yyyy}")%>
                            for
                            <%# Eval("InboxThreadListingRequest.RequestedServings")%>
                            people(s)
                            <asp:Literal runat="server" ID="ArrowLiteral"></asp:Literal>
                        </div>
                        <div>
                            <input type="hidden" id="FromUserIdHidden" value="<%# Eval("FromUserId")%>" />
                            <input type="hidden" id="ToUserIdHidden" value="<%# Eval("ToUserId")%>" />
                            <input type="hidden" id="MainMessageIdHidden" value="<%# Eval("MainMessageId")%>" />
                            <p class="message">
                                <%# Eval("InboxThreadMessage.UserMessage")%>
                            </p>
                            <div class="alert alert-block" runat="server" id="divReply" style='margin-bottom: 0px'>
                                <asp:Button Text="Confirm" data-loading-text="Please Wait.." data-complete-text="Confirm"  Visible="False" runat="server" OnClientClick="return confirmRequest(this)" ID="ConfirmButton" CssClass="btn btn-primary" />
                                <input type="button" name="ReplyButton" id="ReplyButton" value="Send Reply" onclick="ShowReplyDiv(this);"
                                    class="btn btn-primary" />
                            </div>
                            <div id="ReplyDiv" style="display: none; margin: 10px 10px 10px 10px">
                                <textarea rows="10" cols="20" id="ReplyMessage" style="width: 450px"></textarea>
                                <br />
                                <input type="button" data-loading-text="Please Wait.." data-complete-text="Send now" id="ReplySendButton" onclick="sendReply(this);" name="ReplySendButton"
                                    value="Send now" class="btn btn-primary" />
                            </div>
                        </div>
                    </div>
                    <div class="thumbnailPic">
                        <asp:Literal runat="server" ID="LeftSideUserLiteral"></asp:Literal>
                    </div>
                </div>
            </li>
        </ItemTemplate>
    </asp:ListView>
</ul>
<script type="text/javascript">

    function ShowReplyDiv(buttonObject) {
        $(buttonObject).parent().parent().find("#ReplyDiv").toggle();
    }

    
</script>
