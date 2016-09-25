using System;
using System.Web.UI.WebControls;
using KhanawalApplication.Business;
using KhanawalApplication.Entity;

namespace KhanawalApplication
{
    public partial class Inbox : ParentPage
    {
        protected void Page_Load(object sender, EventArgs e)
        { 
            //AuthenticateUser();
            if (!Page.IsPostBack)
            {
                if (Session[Common.CurrentSession.CurrentUser] != null)
                {
                    BindInbox();
                }
                //
            }
        }

        private void BindInbox()
        {
            MessageThreadService service = new MessageThreadService();
            var mainMessages = service.GetInboxForCurrentUsers(CurrentUser);
            this.InboxListview.DataSource = mainMessages;
            this.InboxListview.DataBind();
        }
        protected void InboxListview_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            // write a logic to get the message threads
            // take the lastest one
            // if its for the current user and check the read flag
            // and if not read then make it bold.
        }
    }
}