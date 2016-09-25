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
    public partial class ListingNewLocationPricing : ParentPage
    {
        public static int _listingId;
        protected void Page_Load(object sender, EventArgs e)
        {
            //AuthenticateUser();
            if (!IsPostBack)
            {
                if (Session[Common.CurrentSession.CurrentUser] != null)
                {
                    if (ListingId.HasValue)
                    {
                        BindLocationAndPricing(ListingId.Value);
                        _listingId = ListingId.Value;

                        BindCity();
                        BindState();
                        this.SetNavigation(_listingId.ToString());
                    }
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

        private void BindCity()
        {
            CityService service = new CityService();
            this.UserCityDropDownList.DataSource = service.GetCities(); ;
            this.UserCityDropDownList.ClearSelection();
            this.UserCityDropDownList.DataBind();
            this.UserCityDropDownList.Items.Insert(0, new ListItem("-- Select City --", ""));
        }

        private void BindState()
        {
            StateService service = new StateService();
            this.UserStateDropDownList.DataSource = service.GetStates();
            this.UserStateDropDownList.DataBind();
            this.UserStateDropDownList.Items.Insert(0, new ListItem("-- Select State --", ""));
        }

        public int? ListingId
        {
            get { return Request.QueryString["ID"] != null ? Int32.Parse(Request.QueryString["ID"].ToString()) : (int?)null; }
        }

        [WebMethod]
        public static void SaveLocationAndPricing(string lattitude, string longitude, string postalCode, string addressLine1,
                                          string addressLine2, string cityId, string stateId, string isPostalStyleSelected, string cost, string homeAddressAsPickUpLocation)
        {
            var service =  new ListingService();
            var _lat = string.IsNullOrEmpty(lattitude) ? (float?)null : float.Parse(lattitude);
            var _long = string.IsNullOrEmpty(longitude) ? (float?)null : float.Parse(longitude);
            var _cityId = string.IsNullOrEmpty(cityId) ? (int?) null : int.Parse(cityId);
            var _stateId = string.IsNullOrEmpty(stateId) ? (int?)null : int.Parse(stateId);
            var _isPostalStyleSelected = isPostalStyleSelected == "postal";
            var _cost = string.IsNullOrEmpty(cost) ? (double?) null : double.Parse(cost);
            var _homeAddressAsPickUpLocation = Convert.ToInt16(homeAddressAsPickUpLocation) > 0;
            service.UpdatePricingAndLocation(_listingId, _lat, _long,postalCode, addressLine1, addressLine2, _cityId, _stateId,
                                             _isPostalStyleSelected, _cost, _homeAddressAsPickUpLocation);
        }

        private void BindLocationAndPricing(int listingId)
        {
            ListingService service =  new ListingService();

            Listing listing= service.GetListingById(listingId, "User");
            this.PickUplocationCheckBox.Checked = listing.HomeAddressAsPickUpLocation;
            this.PickUplocationNoCheckBox.Checked = !listing.HomeAddressAsPickUpLocation;

            if (listing !=  null)
            {
                if (listing.User != null)
                {
                    this.CostTextBox.Text = listing.Cost.ToString();
                    User user = listing.User;
                    bool isPostalStyleSelected = true;
                    if (listing.IsPostalStyleSeleted.HasValue)
                    {
                        isPostalStyleSelected = listing.IsPostalStyleSeleted.Value;
                        if (isPostalStyleSelected)
                        {
                            this.AddressStyleHiddenField.Value = "postal";
                            this.UserAddressAddressLine1.Text = listing.AddressLine1;
                            this.UserAddressAddressLine2.Text = listing.AddressLine2;
                            this.UserAddressAddressPostalCode.Text = listing.PostalCode;

                            if (listing.UserCity.HasValue)
                            {
                                this.UserCityDropDownList.SelectedValue = listing.UserCity.ToString();
                            }
                            if (listing.UserState.HasValue)
                            {
                                this.UserStateDropDownList.SelectedValue = listing.UserState.ToString();
                            }

                        }
                        else
                        {
                            if (listing.AddressLat.HasValue && listing.AddressLang.HasValue)
                            {
                                this.AddressStyleHiddenField.Value = "map";
                                this.latHiddenField.Value = listing.AddressLat.ToString();
                                this.lngHiddenField.Value = listing.AddressLang.ToString();
                            }
                            else
                            {
                                this.UserAddressAddressLine1.Text = string.Empty;
                                this.UserAddressAddressLine2.Text = string.Empty;
                                this.UserCityDropDownList.ClearSelection();
                                this.UserStateDropDownList.ClearSelection();
                            }

                        }
                    }
                    else
                    {
                        isPostalStyleSelected = user.IsPostalStyleSeleted.HasValue && user.IsPostalStyleSeleted.Value;
                        if (isPostalStyleSelected)
                        {
                            this.AddressStyleHiddenField.Value = "postal";
                            this.UserAddressAddressLine1.Text = user.AddressLine1;
                            this.UserAddressAddressLine2.Text = user.AddressLine2;

                            this.UserCityDropDownList.SelectedValue = user.UserCity.HasValue ? user.UserCity.ToString() : string.Empty;
                            this.UserStateDropDownList.SelectedValue = user.UserState.HasValue ? user.UserState.ToString() : string.Empty;

                        }
                        else
                        {
                            if (user.AddressLat.HasValue && user.AddressLang.HasValue)
                            {
                                this.AddressStyleHiddenField.Value = "map";
                                this.latHiddenField.Value = user.AddressLat.ToString();
                                this.lngHiddenField.Value = user.AddressLang.ToString();
                            }
                            else
                            {
                                this.UserAddressAddressLine1.Text = string.Empty;
                                this.UserAddressAddressLine2.Text = string.Empty;
                                this.UserCityDropDownList.ClearSelection();
                                this.UserStateDropDownList.ClearSelection();
                            }

                        }    
                    }
                    
                }
            }

        }
    }
}