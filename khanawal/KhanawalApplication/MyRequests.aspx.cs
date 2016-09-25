using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanawalApplication.Entity;
using KhanawalApplication.Business;

namespace KhanawalApplication
{
    public partial class MyRequests : ParentPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //AuthenticateUser();

            if (!Page.IsPostBack)
            {
                this.BindMyRequests();
            }

        }


        private void BindMyRequests()
        {
            ListingService service =  new ListingService();
            var myRequests = service.GetListingRequestsForUser(CurrentUser.UserID);

            if (myRequests.Any())
            {
                var myRequestForListView = myRequests.Select(a=> new { DisplayPicUrl = a.Listing.ListingPictures.Count >0 ? a.Listing.ListingPictures.First().DisplayImageUrl : string.Empty,
                                                                       Title = a.Listing.Title,
                                                                       RequestedDate = a.RequestedDate,
                                                                       RequestedServings = a.RequestedServings,
                                                                       Cost = a.Listing.Cost,
                                                                       mainMessageId = a.MainMessages.Count > 0 ? a.MainMessages.First().ID :0,
                                                                       ListingId = a.ListingID,
                                                                       Status = a.RequestAccepted ? "Accepted" : "Waiting for approval"

                });

                this.MyRequestsListview.DataSource = myRequestForListView.OrderBy(a=>a.Status).ThenBy(a=>a.RequestedDate);
                this.MyRequestsListview.DataBind();
            }
        }
    }
}