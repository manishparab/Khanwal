using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using KhanawalApplication;
using KhanawalApplication.Entity;

namespace KhanawalApplication.Business
{
    /// <summary>
    /// Summary description for MessageThread
    /// </summary>
    public class MessageThreadService
    {
        private KhanaWalEntities context;
        public MessageThreadService()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public int MarkThreadAsRead(bool isUserListingOwner, int mainMessageId)
        {
            context = new KhanaWalEntities();
            if (isUserListingOwner)
            {
                context.MessageThreads.Where(a => a.MainMessageID == mainMessageId).ToList().ForEach(f => f.MessageReadListingOwner = true);
            }
            else
            {
                context.MessageThreads.Where(a => a.MainMessageID == mainMessageId).ToList().ForEach(f => f.MessageReadRequestor = true);
            }

            return context.SaveChanges();
        }

        //TODO : need to add is soft isdeleted coloum to the list
        public List<InboxMessages> GetInboxForCurrentUsers(User currentUser)
        {
            //User currentUser = (User)HttpContext.Current.Session["currentUser"];

            context = new KhanaWalEntities();

            List<InboxMessages> newMailsInboxForCurrentUsers = null;

            //ToDO : optimize into one query : completed : need to check
            var mainMessages = context.MainMessages.Include(Common.DbTables.MessageThreads)
                                      .Include(Common.DbTables.ListingRequest + "." + Common.DbTables.Listing)
                                      .Include(Common.DbTables.MessageThreads + ".User")
                                      .Include(Common.DbTables.MessageThreads + ".User1")
                                      .Where(
                                          a =>
                                          !a.IsDeleted &&
                                          a.MessageThreads.Any(
                                              b =>
                                              b.FromUserID == currentUser.UserID || b.ToUserID == currentUser.UserID))
                                      .ToList();

            if (mainMessages.Any())
            {
                bool isCurrentUserListingOwner = mainMessages.First().ListingRequest.Listing.UserID == currentUser.UserID;


                var inboxMessages = mainMessages.Select(a => new InboxMessages
                {
                    InboxMainMessage = a,
                    MessageDate = a.MessageThreads.First(b=>b.IsFirstMessage).MessageDate,
                    InboxMessageThread = a.MessageThreads.First(b => b.IsFirstMessage),
                    UserDisplayPictureUrl = GetUserDisplayImageUrl(a.MessageThreads.First(b => b.IsFirstMessage)),
                    UserName = GetImageUserName(a.MessageThreads.First(b => b.IsFirstMessage)),
                    MarkedAsRead = isCurrentUserListingOwner ? a.MessageThreads.Any(m => !m.MessageReadListingOwner) :
                                                               a.MessageThreads.Any(m => !m.MessageReadRequestor)
                });

                newMailsInboxForCurrentUsers = inboxMessages.OrderByDescending(c=>c.MessageDate).ToList();
            }


            return newMailsInboxForCurrentUsers;
        }


        //TODO : need to add is soft isdeleted coloum to the list
        public List<InboxMessages> GetNewMailsInboxForCurrentUsers(User currentUser)
        {
            //User currentUser = (User)HttpContext.Current.Session["currentUser"];

            context = new KhanaWalEntities();

            List<InboxMessages> newMailsInboxForCurrentUsers = null;

            //ToDO : optimize into one query : completed : need to check
            var mainMessages = context.MainMessages.Include(Common.DbTables.MessageThreads)
                                .Include(Common.DbTables.ListingRequest + "." + Common.DbTables.Listing)
                                .Include(Common.DbTables.MessageThreads + ".User")
                                .Include(Common.DbTables.MessageThreads + ".User1")
                                .Where(a => !a.IsDeleted && a.MessageThreads.Any(b => b.FromUserID == currentUser.UserID || b.ToUserID == currentUser.UserID))
                                .OrderByDescending(o => o.MessageThreads.Max(m => m.MessageDate)).ToList();

            if (mainMessages.Any())
            {
                bool isCurrentUserListingOwner = mainMessages.First().ListingRequest.Listing.UserID == currentUser.UserID;


                var inboxMessages = mainMessages.Select(a => new InboxMessages
                    {
                        InboxMainMessage = a,
                        InboxMessageThread = a.MessageThreads.First(b => b.IsFirstMessage),
                        UserDisplayPictureUrl = GetUserDisplayImageUrl(a.MessageThreads.First(b => b.IsFirstMessage)),
                        UserName = GetImageUserName(a.MessageThreads.First(b => b.IsFirstMessage)),
                        MarkedAsRead =
                            isCurrentUserListingOwner
                                ? a.MessageThreads.Any(m => !m.MessageReadListingOwner)
                                : a.MessageThreads.Any(m => !m.MessageReadRequestor)
                    });

                newMailsInboxForCurrentUsers = inboxMessages.ToList();
            }

            return newMailsInboxForCurrentUsers;
        }

        public string GetUserDisplayImageUrl(MessageThread messageThread)
        {
            //bool isCurrentUserOwner = messageThread.ToUserID == currentUser.UserID;
            //string imageUrl = isCurrentUserOwner ? messageThread.User1.ImageUrl : messageThread.User.ImageUrl;
            //return imageUrl;
            return messageThread.User.ImageUrl;
        }

        public string GetImageUserName(MessageThread messageThread)
        {
            //bool isCurrentUserOwner = messageThread.ToUserID == currentUser.UserID;
            //string userName = isCurrentUserOwner ? messageThread.User1.first_name : messageThread.User.first_name;
            //return userName;
            return messageThread.User.first_name;
        }

        public int CreateMainMessageThread(ListingRequest listingRequest, Listing listing)
        {
            var currentUser = (User)HttpContext.Current.Session["currentUser"];
            int returnValue = 0;
            // after creating main theread we need to create message theread
            context = new KhanaWalEntities();
            var mainMessage = new MainMessage { ListingRequestID = listingRequest.ID };

            context.MainMessages.AddObject(mainMessage);

            if (context.SaveChanges() > 0)
            {
                var messageThread = new MessageThread
                    {
                        IsFirstMessage = true,
                        MainMessageID = mainMessage.ID,
                        UserMessage = listingRequest.Message,
                        MessageDate = DateTime.Now.Date,
                        Message =
                            string.Format("Enquiry about {0} from {1} for {2} people on {3}", listing.Title,
                                          currentUser.first_name, listingRequest.RequestedServings,
                                          listingRequest.RequestedDate.ToString("dd/MM/yyyy")),
                        MessageReadRequestor = false,
                        MessageReadListingOwner = false,
                        FromUserID = currentUser.UserID,
                        ToUserID = listing.User.UserID
                    };
                returnValue = CreateMessageTherad(messageThread);
            }

            return returnValue;
        }

        public MainMessage GetMainMessage(int mainMessageId)
        {
            context = new KhanaWalEntities();
            var mainMessage = context.MainMessages
                               .Include(Common.DbTables.ListingRequest)
                               .Include(Common.DbTables.MessageThreads)
                               .Include(Common.DbTables.MessageThreads + "." + Common.DbTables.User)
                               .Include(Common.DbTables.MessageThreads + "." + Common.DbTables.User1)
                               .First(a => a.ID == mainMessageId);
            return mainMessage;
        }

        public MessageThread GetFirstMessageFromMainMessageId(int mainMessageId)
        {
            context = new KhanaWalEntities();
            MessageThread messageThread = null;
            var messageThreads = context.MessageThreads
                               .Include(Common.DbTables.User)
                               .Include(Common.DbTables.User1)
                                .Where(a => a.MainMessageID == mainMessageId && a.IsFirstMessage);
            if (messageThreads.Any())
            {
                messageThread = messageThreads.First();
            }

            return messageThread;

        }

        public int ConfirmedReply(int mainMessageId, int toUserId, int fromUserId)
        {
            MessageThread messageThread = new MessageThread();

            messageThread.ListingAccepted = true;
            messageThread.FromUserID = fromUserId;
            messageThread.ToUserID = toUserId;
            messageThread.MainMessageID = mainMessageId;
            messageThread.MessageDate = DateTime.Now.Date;
            messageThread.MessageReadListingOwner = false;
            messageThread.MessageReadRequestor = false;

            context = new KhanaWalEntities();
            context.MessageThreads.AddObject(messageThread);
            context.SaveChanges();

            var mainMessage = context.MainMessages.Include(Common.DbTables.ListingRequest).Where(a => a.ID == mainMessageId);
            mainMessage.First().ListingRequest.RequestAccepted = true;
            mainMessage.First().ListingRequest.IsConfirmed = true;
            return context.SaveChanges();
        }

        public int SendReply(string userMessage, int fromUserId, int toUserId, int mainMessageId, int currentUserId)
        {
            MessageThread messageThread = new MessageThread();

            //List<InboxMessageThread> inboxMessageThreads = null;

            messageThread.UserMessage = userMessage;
            messageThread.FromUserID = fromUserId;
            messageThread.ToUserID = toUserId;
            messageThread.MainMessageID = mainMessageId;
            messageThread.MessageDate = DateTime.Now.Date;

            context = new KhanaWalEntities();
            context.MessageThreads.AddObject(messageThread);

            return context.SaveChanges();

            //if (context.SaveChanges() > 0)
            //{
            //    inboxMessageThreads = GetMessagesFromMainMessageId(mainMessageId,currentUserId);
            //}

            //return inboxMessageThreads;
        }

        public List<InboxMessageThread> GetMessagesFromMainMessageId(int mainMessageId, int currentUserId)
        {
            context = new KhanaWalEntities();
            var mainMessage = context.MainMessages
                               .Include(Common.DbTables.ListingRequest)
                               .Include(Common.DbTables.MessageThreads)
                               .Include(Common.DbTables.MessageThreads + "." + Common.DbTables.User)
                               .Include(Common.DbTables.MessageThreads + "." + Common.DbTables.User1)
                               .Include(Common.DbTables.ListingRequest + "." + Common.DbTables.User)
                               .Include(Common.DbTables.ListingRequest + "." + Common.DbTables.Listing)
                               .First(a => a.ID == mainMessageId);

            ListingRequest listingRequest = mainMessage.ListingRequest;

            var messageThreads = mainMessage.MessageThreads.Select(a => new InboxMessageThread()
            {
                InboxThreadMessage = a,
                InboxThreadListingRequest = listingRequest,
                RequestorName = string.Format("{0} {1}", listingRequest.User.first_name, listingRequest.User.last_name),
                ListingName = listingRequest.Listing.Title,
                FromUserName = string.Format("{0} {1}", a.User.first_name, a.User.last_name),
                FromUserId = a.User.UserID,
                ToUserId = a.User1.UserID,
                ToUserName = string.Format("{0} {1}", a.User1.first_name, a.User1.last_name),
                FromUserDisplayPictureUrl = a.User.ImageUrl,
                ToUserDisplayPictureUrl = a.User1.ImageUrl,
                MainMessageId = mainMessage.ID
            }).OrderByDescending(o => o.InboxThreadMessage.ID).ToList();
            messageThreads.First().IsCurrentUserLisitingOwner =
                messageThreads.First().InboxThreadListingRequest.Listing.UserID == currentUserId;

            messageThreads.First().FirstRecord = true;

            // find if the request is confirmed

            var confirmedMessage = messageThreads.Where(a => a.InboxThreadListingRequest.IsConfirmed).ToList();
            if (confirmedMessage.Any())
            {
                int corfirmedMessageId = confirmedMessage.First().InboxThreadListingRequest.ID;
                var confirmedMessages = messageThreads.Where(a => a.InboxThreadListingRequest.ID > corfirmedMessageId);
                foreach (var inboxMessageThread in confirmedMessages)
                    inboxMessageThread.InboxThreadListingRequest.RequestAccepted = true;
            }

            return messageThreads;
        }

        private int CreateMessageTherad(MessageThread messageThread)
        {
            context = new KhanaWalEntities();
            context.MessageThreads.AddObject(messageThread);
            context.SaveChanges();
            return messageThread.MainMessageID;
        }

    }
}