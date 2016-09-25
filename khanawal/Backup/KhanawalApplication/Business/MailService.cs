using System;
using System.Net;
using System.Web;
using System.Net.Mail;
using System.Configuration;
using KhanawalApplication;
using KhanawalApplication.IO;
using KhanawalApplication.KhanawalEnum;

namespace KhanawalApplication.Business
{
    /// <summary>
    /// Summary description for MailService
    /// </summary>
    public class MailService
    {
        
        public MailService()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public bool SendMailListingRequestCommunication(User fromUser,User toUser, string subject, string body, string threadId)
        {
            string mailContent = Common.ReadFileFromDisk(HttpContext.Current.Server.MapPath("Templates/Email/ListingRequestCommunication.htm"));
            mailContent = mailContent.Replace("[[user]]", toUser.first_name);
            mailContent = mailContent.Replace("[[fromUser]]", fromUser.first_name);
            mailContent = mailContent.Replace("[[userMessage]]", body);
            mailContent = mailContent.Replace("[[threadId]]", threadId);
            return SendMail(toUser.email, subject, mailContent);
        }

        public bool SendMailListingRequestConfirmation(User fromUser, User toUser, string subject, string threadId)
         {
             string mailContent = Common.ReadFileFromDisk(HttpContext.Current.Server.MapPath("Templates/Email/ListingRequestConfirmation.htm"));
             mailContent = mailContent.Replace("[[user]]", toUser.first_name);
             mailContent = mailContent.Replace("[[fromUser]]", fromUser.first_name);
             mailContent = mailContent.Replace("[[subject]]", subject);
             mailContent = mailContent.Replace("[[threadId]]", threadId);
             return SendMail(toUser.email, fromUser.email, subject, mailContent);
         }

        public bool SendWelcomeMail(User toUser, string subject)
        {
            string mailContent = Common.ReadFileFromDisk(HttpContext.Current.Server.MapPath("Templates/Email/NewUserWelcomeMail.htm"));
            mailContent = mailContent.Replace("[[user]]", toUser.first_name);         
            return SendMail(toUser.email, subject, mailContent);
        }

        public bool SendMail(ListingMails mailType, Listing listing, ListingRequest listingRequest, string threadId)
        {
            User user = (User)HttpContext.Current.Session[Entity.Common.CurrentSession.CurrentUser];
            string mailContent = String.Empty;
            string subject = string.Empty;

            //TODO :can be optimized by reading values from form
            KhanaWalEntities context =  new KhanaWalEntities();
            //listing = context.Listings.Include(Entity.Common.DbTables.User).Where(a => a.ID == listing.ID).First();

            
            switch (mailType)
            {
                case ListingMails.RequestForListing:
                    mailContent = Common.ReadFileFromDisk(HttpContext.Current.Server.MapPath("Templates/Email/RequestForListingForRecipient.htm"));
                    mailContent = mailContent.Replace("[[user]]", listing.User.first_name);
                    mailContent = mailContent.Replace("[[currentuser]]", (user.first_name + " " + user.last_name));
                    mailContent = mailContent.Replace("[[requestTitleHyperlink]]", listing.Title);
                    mailContent = mailContent.Replace("[[requestDate]]", listingRequest.RequestedDate.ToString("dd/MM/yyyy"));
                    mailContent = mailContent.Replace("[[usercount]]", listingRequest.RequestedServings.ToString());
                    mailContent = mailContent.Replace("[[totalcost]]", (listingRequest.RequestedServings * listing.Cost).ToString() + " Rs" );
                    mailContent = mailContent.Replace("[[threadId]]", threadId);
                    subject = string.Format("ENQUIRY ABOUT {0} from {1}", listing.Title, user.first_name);
                    break;
                case ListingMails.RequestApproved:
                    break;
                case  ListingMails.RequestRejected:
                    break;
                case ListingMails.RequestCommnication:
                     
                    break;
                default:
                    break;
            }
            return SendMail(listing.User.email, subject, mailContent);
        }

        public bool SendMail(string mailTo, string subject, string body)
        {
            string adminCopy = "FoodAdmin@khanawal.com";
            string mailFrom = ConfigurationManager.AppSettings["mailUserName"];
            //mailTo = "manish.parab@hotmail.com";
            var client = new SmtpClient(ConfigurationManager.AppSettings["SMTPServer"])
            {
                Credentials = new NetworkCredential(ConfigurationManager.AppSettings["mailUserName"], ConfigurationManager.AppSettings["mailAccountPassword"])
                //EnableSsl = true
            };
            MailMessage mm = new MailMessage(mailFrom, mailTo, subject, body) {IsBodyHtml = true};
            MailAddress copyAdmin = new MailAddress(adminCopy);

            mm.Bcc.Add(copyAdmin);
            client.Send(mm);
            return default(bool);
        }

        public bool SendMail(string mailTo, string cc, string subject, string body)
        {
            //mailTo = "manish.parab@hotmail.com";
            string adminCopy = "FoodAdmin@khanawal.com";

            string mailFrom = ConfigurationManager.AppSettings["mailUserName"];

            var client = new SmtpClient(ConfigurationManager.AppSettings["SMTPServer"])
            {
                Credentials = new NetworkCredential(ConfigurationManager.AppSettings["mailUserName"], ConfigurationManager.AppSettings["mailAccountPassword"])
                //EnableSsl = true
            };


            //MailMessage mm = new MailMessage("donotreply@domain.com", "destination@domain.com", "subject here", "my body");
            MailMessage mm = new MailMessage(mailFrom, mailTo, subject, body) { IsBodyHtml = true };

            MailAddress copy = new MailAddress(cc);

            mm.CC.Add(copy);

            MailAddress copyAdmin = new MailAddress(adminCopy);

            mm.Bcc.Add(copyAdmin);


            client.Send(mm);

            return default(bool);
        }
    }
}