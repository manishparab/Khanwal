using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanawalApplication.Business;
using KhanawalApplication.Entity;

namespace KhanawalApplication
{
    public partial class ManageListing : ParentPage
    {
         
        protected void Page_Load(object sender, EventArgs e)
        {
            //AuthenticateUser();
            if (!IsPostBack)
            {
                if (Session[Common.CurrentSession.CurrentUser] != null)
                {
                    ManageListingVisibility();
                }
            }
        }

        private void ManageListingVisibility()
        {


            int listingComplitionCount = 0;

            int listingId = Request.QueryString["ID"] != null ? int.Parse(Request.QueryString["ID"]) : -1;

            if (listingId > 0)
            {
                ManageListingHyperlink.HRef = ManageListingHyperlink.HRef + "?Id=" + listingId;
                NameAndDescriptionHyperlink.HRef = NameAndDescriptionHyperlink.HRef + "?Id=" + listingId;
                ListingCatAndIngredientsHyperlink.HRef = ListingCatAndIngredientsHyperlink.HRef + "?Id=" + listingId;
                ListingPhotosHyperlink.HRef = ListingPhotosHyperlink.HRef + "?Id=" + listingId;
                ListingLocationAndPricingHyperlink.HRef = ListingLocationAndPricingHyperlink.HRef + "?Id=" + listingId;
                listingAdditionalHyperlink.HRef = listingAdditionalHyperlink.HRef + "?Id=" + listingId;

                LocationAndPricinghyerlink.HRef = "ListingNewLocationPricing.aspx?Id="  + listingId;
                PhotosHyperlink.HRef = "ListingNewPhotos.aspx?Id=" + listingId;
                IngredientsHyperLink.HRef = "ListingNewCatIngredients.aspx?Id=" + listingId;
                TitleAndDescHyperLink.HRef = "ListingNewTitleDescription.aspx?Id=" + listingId;


                ListingService service = new ListingService();
                var listingStatus = service.GetListingStatusforListingId(listingId);

                if (listingStatus.TitleAndDescription)
                {
                    ListingTitleAndDesc.Visible = false;
                }
                else
                {
                    ListingTitleAndDesc.Visible = true;
                    listingComplitionCount = listingComplitionCount + 1;
                }

                if (listingStatus.CategoryAndIngredients)
                {
                    ListingCatAndIngredients.Visible = false;
                }
                else
                {
                    ListingCatAndIngredients.Visible = true;
                    listingComplitionCount = listingComplitionCount + 1;
                }


                if (listingStatus.Photos)
                {
                    ListingPhotos.Visible = false;
                }
                else
                {
                    ListingPhotos.Visible = true;
                    listingComplitionCount = listingComplitionCount + 1;
                }

                if (listingStatus.LocationAndPricing)
                {
                    ListingLocationAndPricing.Visible = false;
                }
                else
                {
                    ListingLocationAndPricing.Visible = true;
                    listingComplitionCount = listingComplitionCount + 1;
                }

                if (listingComplitionCount > 0)
                {
                    listingCompletionCount.InnerText = listingComplitionCount.ToString();
                    this.ListingStatusLiteral.Text = "Complete below steps to make listing visible";
                }
                else
                {
                    this.ListingStatusLiteral.Text = "Listing is completed and visible to user, to edit detail's click on respective section";
                    listingCompletionCount.Visible = false;
                }


            }


        }
    }
}