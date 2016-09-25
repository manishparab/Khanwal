using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanawalApplication.Business;

namespace KhanawalApplication
{
    public partial class UserListings : System.Web.UI.UserControl
    {
        public int UserId { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.BindListings();
            }
        }

        public void BindListings()
        {

            ListingService service = new ListingService();
            // find the user ID for the current Listing

            List<Listing> listingsByUserId = service.GetListingsByUserId(UserId);
            var otherListings = listingsByUserId.Where(a => a.ListingPictures.Count > 0).Select(
                f => new { imageurl = f.ListingPictures.First().DisplayImageUrl, listing = f });
            UserListingsListView.DataSource = otherListings;
            UserListingsListView.DataBind();

        }
    }
}