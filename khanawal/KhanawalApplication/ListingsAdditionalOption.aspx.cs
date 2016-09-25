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
    public partial class ListingsAdditionalOption : ParentPage
    {
        public static int _listingId;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (ListingId.HasValue)
                {
                    _listingId = ListingId.Value;
                    InitialiseForm(ListingId.Value);
                    this.SetNavigation(_listingId.ToString());
                }
                
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
        private void InitialiseForm(int listingId)
        {
            LoadCanellation();
            LoadSideListings();

           ListingService service =  new ListingService();
           var listing = service.GetListingById(listingId, "SideListingMappings");

            if (listing != null)
            {
                this.CancellationDropDownList.SelectedValue = listing.CancellationType.ToString();
                this.SideDishcheckbox.Checked = listing.SideDishProvided;
                this.SideDishNocheckbox.Checked = !this.SideDishcheckbox.Checked;
                this.HDfreeCheckbox.Checked = listing.FreeHomedelivery.HasValue && listing.FreeHomedelivery.Value;
                this.HomedeliveryCheckbox.Checked = listing.HomeDelivery;
                this.HomedeliveryNoCheckbox.Checked = !this.HomedeliveryCheckbox.Checked;
                this.AdditionalHDChargesTextBox.Text = listing.HomedeliveryCharges.HasValue
                                                           ? listing.HomedeliveryCharges.Value.ToString()
                                                           : string.Empty;

                this.HiddenFieldSideListing.Value = listing.SideListings;
                var sideListingMappings = listing.SideListingMappings;
                var sideListingInitialValue = string.Join(",", sideListingMappings.Select(a => a.SideListingID));
                SideListingsHiddenFieldInitial.Value = sideListingInitialValue;


            }

        }

        public int? ListingId
        {
            get { return Request.QueryString["ID"] != null ? Int32.Parse(Request.QueryString["ID"].ToString()) : (int?)null; }
        }


        private void LoadCanellation()
        {
            CancellationService service = new CancellationService();
            CancellationDropDownList.DataSource = service.CancellationTypes;
            CancellationDropDownList.DataValueField = "key";
            CancellationDropDownList.DataTextField = "Value";
            CancellationDropDownList.DataBind();
            CancellationDropDownList.Items.Insert(0, new ListItem("--Select--", ""));
        }

        [WebMethod]
        public static int SaveListingAdditionalOption(string sideDishProvided,string sidelistingsNames , string homeDelivery, string freeHomeDelivery , int homeDeliveryCharges, int cancellationId)
        {
            ListingService service =  new ListingService();
            //service.EnsureSideListings(sidelistingsNames, _listingId);
            var _homeDelivery = homeDelivery == "true";
            var _freeHomeDelivery = freeHomeDelivery == "true";
            var _homeDeliveryCharges = homeDeliveryCharges;
            return service.UpdateAdditionalOptions(_homeDelivery, _freeHomeDelivery, _homeDeliveryCharges, cancellationId, _listingId, sidelistingsNames);
        }

        private void LoadSideListings()
        {
           
        }
    }
}