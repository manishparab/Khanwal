using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using KhanawalApplication.Business;
using KhanawalApplication.Entity;
using System.Linq;
using KhanawalApplication.KhanawalEnum;

namespace KhanawalApplication
{
    public partial class InboxThread : ParentPage
    {
        private static int _mainMessageId;
        private const string RequestStringMainMessageId = "ID";

        protected void Page_Load(object sender, EventArgs e)
        {
            //AuthenticateUser();
            if (Session[Common.CurrentSession.CurrentUser] != null)
            {
                if (Request.QueryString[RequestStringMainMessageId] != null)
                {
                    _mainMessageId = int.Parse(Request.QueryString[RequestStringMainMessageId]);
                    BindMessageThread(_mainMessageId);

                }
            }
            // read the messages and depending on the ID apply the class to the items
        }

        [WebMethod]
        public static string ConfirmRequest(int mainMessageIdHidden, int toUserIdHidden, int fromUserIdHidden)
        {
            User user = ((User)HttpContext.Current.Session[Common.CurrentSession.CurrentUser]);
            MessageThreadService service =  new MessageThreadService();

            if (user.UserID != fromUserIdHidden)
            {
                toUserIdHidden = fromUserIdHidden;
                fromUserIdHidden = user.UserID;
            }

            int returnValue = service.ConfirmedReply(mainMessageIdHidden, toUserIdHidden, fromUserIdHidden);


            var messageThread = service.GetFirstMessageFromMainMessageId(mainMessageIdHidden);

            if (messageThread != null)
            {
                string subject = messageThread.Message;
                User fromUser = null, toUser = null;

                if (messageThread.User.UserID == user.UserID)
                {
                    fromUser = messageThread.User;
                    toUser = messageThread.User1;
                }
                else
                {
                    fromUser = messageThread.User1;
                    toUser = messageThread.User;
                    
                }
                MailService mailService = new MailService();

                mailService.SendMailListingRequestConfirmation(fromUser, toUser, subject, _mainMessageId.ToString());

            }

            return returnValue.ToString();
        }

        [WebMethod]
        public static string SendReply(int mainMessageIdHidden, string userMessage, int toUserIdHidden, int fromUserIdHidden)
        {
            MessageThreadService service =  new MessageThreadService();
            MailService mailService =  new MailService();

            // Tricky part
            //the current logged in user is always fromUserIdHidden
            User user = ((User)HttpContext.Current.Session[Common.CurrentSession.CurrentUser]);

            if (user.UserID != fromUserIdHidden)
            {
                toUserIdHidden = fromUserIdHidden;
                fromUserIdHidden = user.UserID;
            }

            int returnValue = service.SendReply(userMessage, fromUserIdHidden,toUserIdHidden, mainMessageIdHidden, user.UserID);

            // find the Message Title
            // send the mail to touserID

            var messageThread = service.GetFirstMessageFromMainMessageId(mainMessageIdHidden);
            if (messageThread!=null)
            {
                string subject = messageThread.Message;
                User fromUser =  null, toUser = null;
                if (messageThread.User.UserID == user.UserID)
                {
                    fromUser = messageThread.User;
                    toUser = messageThread.User1;
                }
                else
                {
                     fromUser = messageThread.User1;
                    toUser = messageThread.User;
                }
                mailService.SendMailListingRequestCommunication(fromUser, toUser, subject, userMessage, _mainMessageId.ToString());

            }

            //mailService.SendMail(ListingMails.RequestCommnication, )

            //ProxyPage page =  new ProxyPage();

            //var foodTypeUserControl = (InboxMessageThreadUserControl)page.LoadControl("~/InboxMessageThreadUserControl.ascx");
            //foodTypeUserControl.InboxMessageThreads = messages;

            //return GetUserControlHtml(foodTypeUserControl, page);

            return returnValue.ToString();

        }

        private static string GetUserControlHtml<T>(T userControl, Page page) where T : UserControl
        {
            page.Controls.Clear();

            page.Controls.Add(userControl);

            var writer = new StringWriter();

            HttpContext.Current.Server.Execute(page, writer, false);

            string output = writer.ToString().Replace("\r", string.Empty).Replace("\n", string.Empty);

            writer.Close();

            return output;
        }

        private void BindMessageThread(int mainMessageId)
        {
            var service =  new MessageThreadService();
            var messageThread = service.GetMessagesFromMainMessageId(mainMessageId, CurrentUser.UserID);
            
            InboxMessageThreadUserControl.InboxMessageThreads = messageThread;
            InboxMessageThreadUserControl.DataBind();
            service.MarkThreadAsRead(messageThread.First().IsCurrentUserLisitingOwner, mainMessageId);
           
        }
    }
}