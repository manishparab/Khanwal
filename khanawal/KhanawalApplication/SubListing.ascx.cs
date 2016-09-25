using System;
using System.Linq;
using KhanawalApplication.Business;

namespace KhanawalApplication
{
    public partial class SubListing : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.BindSubListing();
            }
        }

        private void BindSubListing()
        {
            ListingService service =  new ListingService();
            var listings = service.GetListings(null);
            var listingWithPictures =
                listings.OrderByDescending(a=>a.ModifiedDate).Take(10).Select(l => new {ImageUrl = l.ListingPictures.First().DisplayImageUrl, l.Title, l.Cost, l.ID});
            subListingsListView.DataSource = listingWithPictures.ToList();
            subListingsListView.DataBind();
        }
    }
}