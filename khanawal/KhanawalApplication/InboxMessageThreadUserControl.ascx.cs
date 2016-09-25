using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using KhanawalApplication.Entity;

namespace KhanawalApplication
{
    public partial class InboxMessageThreadUserControl : System.Web.UI.UserControl
    {
        public List<InboxMessageThread> InboxMessageThreads { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindMessageThreads();
            }
        }

        private void BindMessageThreads()
        {
            if (InboxMessageThreads != null)
            {
                MessageThreadListview.DataSource = InboxMessageThreads;
                MessageThreadListview.DataBind();
            }
        }

        protected void MessageThreadListview_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                var inboxMessageThread = e.Item.DataItem as InboxMessageThread;

                //check if the listing is confirmed or not
                var actorUserNameLiteral = e.Item.FindControl("ActorUserNameLiteral") as Literal;
                var actionLiteral = e.Item.FindControl("ActionLiteral") as Literal;
                var confirmButton = e.Item.FindControl("ConfirmButton") as Button;

                if (inboxMessageThread.InboxThreadListingRequest.RequestAccepted)
                {
                    // if the listing is already approved then we need to hide the confirm button
                    actorUserNameLiteral.Text = inboxMessageThread.InboxThreadListingRequest.Listing.User.first_name;
                    actionLiteral.Text = "Approved";
                   
                }
                else
                {
                    actorUserNameLiteral.Text = inboxMessageThread.InboxThreadListingRequest.User.first_name;
                    actionLiteral.Text = "wants";
                }

                //Deside if the user is right side user or left side user
                //1)  find the request listing and find From userId
                //2)  Compare the current message thread From user if they 
                //match then it is left side user or else right side user

                var rightSideUserLiteral = e.Item.FindControl("rightSideUserLiteral") as Literal;
                var leftSideUserLiteral = e.Item.FindControl("LeftSideUserLiteral") as Literal;
                var arrowLiteral = e.Item.FindControl("ArrowLiteral") as Literal;


                if (inboxMessageThread.InboxThreadListingRequest.UserID ==
                    inboxMessageThread.InboxThreadMessage.FromUserID)
                {
                    // The its left side user
                    rightSideUserLiteral.Text = "&nbsp;";
                    leftSideUserLiteral.Text = string.Format("<img style='width: 50px; height: 50px' alt='{0}' src='{1}' />", inboxMessageThread.FromUserName, inboxMessageThread.FromUserDisplayPictureUrl);
                    arrowLiteral.Text = "<div class='arrow_right'></div>";

                }
                else
                {
                    rightSideUserLiteral.Text = string.Format("<img style='width: 50px; height: 50px' alt='{0}' src='{1}' />",
                        inboxMessageThread.FromUserName, inboxMessageThread.FromUserDisplayPictureUrl);
                    leftSideUserLiteral.Text = "&nbsp;";
                    arrowLiteral.Text = "<div class='arrow_left'></div>";
                }


                // if it is not the last message then hide the confirm and reply button
                var divReply = e.Item.FindControl("divReply") as HtmlGenericControl;
                divReply.Visible = inboxMessageThread.FirstRecord;

                // if the user is not listing owner hide the confirm button
                if (divReply.Visible)
                {
                    confirmButton.Visible = inboxMessageThread.IsCurrentUserLisitingOwner && !inboxMessageThread.InboxThreadListingRequest.RequestAccepted;
                }


             


                

            }
        }
    }
}