using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanawalApplication.Business;
using KhanawalApplication.Entity;

namespace KhanawalApplication
{
    public partial class MyListings : ParentPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //AuthenticateUser();
            if (!IsPostBack)
            {
                if (CurrentUser != null)
                {
                    BindMyListing();
                }
              
            }
        }

        [WebMethod]
        public static void UpdateFacePostPostIdForListing(string faceBookPostId, string listingId)
        {
            ListingService service = new ListingService();
            service.UpdateFacePostPostIdForListing(int.Parse(listingId), faceBookPostId);
        }

        private void BindMyListing()
        {
            var service =  new ListingService();
            var listings = service.GetListingsForCurrentUser(CurrentUser.UserID);
            if (listings !=  null)
            {
                this.resultLiteral.Text = string.Format("{0} listings found", listings.Count() > 0 ? listings.Count().ToString() : "No");
            }
            ListingUserControl.SearchListings = listings.ToList();
        }
    }
}