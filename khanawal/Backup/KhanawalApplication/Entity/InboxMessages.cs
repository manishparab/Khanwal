using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace KhanawalApplication.Entity
{
    public class InboxMessages
    {
        public MainMessage InboxMainMessage { get; set; }
        public MessageThread InboxMessageThread { get; set; }
        public string UserDisplayPictureUrl { get; set; }
        public string UserName { get; set; }
        public bool MarkedAsRead { get; set; }
        public DateTime MessageDate { get; set; }
    }
}