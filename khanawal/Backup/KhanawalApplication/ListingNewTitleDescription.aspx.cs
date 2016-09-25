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
    public partial class ListingNewTitleDescription : ParentPage
    {
        public static int _listingId;
        protected void Page_Load(object sender, EventArgs e)
        {
            //AuthenticateUser();

            _listingId = Request.QueryString["ID"] != null ? int.Parse(Request.QueryString["ID"]) : -1;
            if (!IsPostBack)
            {
                if (Session[Common.CurrentSession.CurrentUser] != null)
                {
                    if (_listingId > 0)
                    {
                        BindListing(_listingId);
                        SetNavigation(_listingId.ToString());
                    }
                }
            }

        }

        private void BindListing(int listingid)
        {
            ListingService service =  new ListingService();
            var listing =  service.GetListingById(listingid);
            if (listing != null)
            {
                this.DishNameTextBox.Text = listing.Title;
                this.DishDescriptionTextBox.Text = listing.Description;
                this.PeopleDropDownList.SelectedValue = listing.Servings.ToString();
                this.DishTypeDropDownList.SelectedValue = listing.VegOrNonVeg ? "Veg" : "NonVeg";
            }
        }

        private void SetNavigation(string listingId)
        {
            ManageListingHyperlink.HRef = ManageListingHyperlink.HRef + "?Id=" + listingId;
            NameAndDescriptionHyperlink.HRef = NameAndDescriptionHyperlink.HRef + "?Id=" + listingId;
            ListingCatAndIngredientsHyperlink.HRef = ListingCatAndIngredientsHyperlink.HRef + "?Id=" + listingId;
            ListingPhotosHyperlink.HRef = ListingPhotosHyperlink.HRef + "?Id=" + listingId;
            ListingLocationAndPricingHyperlink.HRef = ListingLocationAndPricingHyperlink.HRef + "?Id=" + listingId;
            listingAdditionalHyperlink.HRef = listingAdditionalHyperlink.HRef + "?Id=" + listingId;

            ListingService service = new ListingService();
            var listingStatus = service.GetListingStatusforListingId(int.Parse(listingId));

            int completionCount = 0;

            if (!listingStatus.TitleAndDescription)
            {
                completionCount = completionCount + 1;
            }

            if (!listingStatus.LocationAndPricing)
            {
                completionCount = completionCount + 1;
            }

            if (!listingStatus.Photos)
            {
                completionCount = completionCount + 1;
            }

            if (!listingStatus.CategoryAndIngredients)
            {
                completionCount = completionCount + 1;
            }

            this.listingCompletionCount.InnerText = completionCount > 0 ? completionCount.ToString() : "";
            this.listingCompletionCount.Visible = completionCount > 0;

        }

        [WebMethod]
        public static int UpdateListingTitleAndDescription(string dishName, string dishDescription, string peopleCount,
                                                           string dishType)
        {
            //System.Threading.Thread.Sleep(10000);
            ListingService service = new ListingService();
            //int listingId = HttpContext.Current.Request.QueryString["ID"] != null ? int.Parse(HttpContext.Current.Request.QueryString["ID"]) : -1;
            var returnValue = service.UpdateListingTitleAndDescription(_listingId, dishName, dishDescription,
                                  int.Parse(peopleCount), dishType == "Veg");
            return returnValue;
        }


        //protected void btnSave_Click(object sender, EventArgs e)
        //{
        //    ListingService service = new ListingService();
        //    var returnValue = service.UpdateListingTitleAndDescription(_listingId, this.DishNameTextBox.Text.Trim(), this.DishDescriptionTextBox.Text.Trim(),
        //                          int.Parse(PeopleDropDownList.SelectedValue), DishTypeDropDownList.SelectedValue == "Veg");
            
        //}

    }
}