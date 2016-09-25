using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanawalApplication.Business;
using KhanawalApplication.Entity;

namespace KhanawalApplication
{
    public partial class DashBoard : ParentPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           // AuthenticateUser();
            if (!IsPostBack)
            {
                if (Session[Common.CurrentSession.CurrentUser] != null)
                {
                    this.UserNameLiteral.Text = CurrentUser.first_name;
                    this.UserImage.ImageUrl = string.Format("{0}?type=large", CurrentUser.ImageUrl);
                    this.BindInbox();
                }
            }
        }


        private void BindInbox()
        {
            MessageThreadService service = new MessageThreadService();
            var mainMessages = service.GetNewMailsInboxForCurrentUsers(CurrentUser);
            this.InboxListview.DataSource = mainMessages;
            this.InboxListview.DataBind();
        }
    }
}