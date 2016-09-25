using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace KhanawalApplication.Entity
{
    public class InboxMessageThread
    {
        public MessageThread InboxThreadMessage { get; set; }
        public ListingRequest InboxThreadListingRequest { get; set; }
        public string RequestorName { get; set; }
        public string ListingName { get; set; }
        public string FromUserName { get; set; }
        public int FromUserId { get; set; }
        public int ToUserId { get; set; } 
        public string ToUserName { get; set; }
        public string FromUserDisplayPictureUrl { get; set; }
        public string ToUserDisplayPictureUrl { get; set; }
        public int MainMessageId { get; set; }
        public bool FirstRecord { get; set; }
        public bool IsCurrentUserLisitingOwner { get; set; }
    }
}