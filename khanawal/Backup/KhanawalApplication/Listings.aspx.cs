using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanawalApplication.Business;
using KhanawalApplication.Entity;

namespace KhanawalApplication
{
    public partial class Listings : ParentPage
    {
        private static List<SearchListing> _searchListing;
        private string _searchKeyWord = string.Empty;
        private string _orderBy = string.Empty;
        private static string _receipeTypeId = string.Empty;


        protected void Page_Load(object sender, EventArgs e)
        {
            _searchKeyWord = Request.QueryString["k"];
            _orderBy = Request.QueryString["order"];
            _receipeTypeId = Request.QueryString["recipeId"];
            isUserLoggedIn.Value = CurrentUser != null ? "true" : "false";
            if (!IsPostBack)
            {
                LoadRecipeType();
                txtSearch.Text = _searchKeyWord;
                BindListing(_searchKeyWord);
                LoadTaste();
                UpdateTaste();
                UpdateFoodType();

            }
        }

        [WebMethod]
        public static string CheckIfUserHasAddress()
        {
            string returnVal;
            if (CurrentUser != null)
            {
                returnVal = CurrentUser.AddressLang.HasValue && CurrentUser.AddressLat.HasValue
                                ? CurrentUser.Address
                                : "-1";
            }
            else
            {
                returnVal = string.Empty;
            }
            return returnVal;
        }


        private static string GetUserControlHTML<T>(T userControl, Page page) where T : UserControl
        {
            var writer = new StringWriter();

            page.Controls.Clear();

            page.Controls.Add(userControl);

            writer = new StringWriter();

            HttpContext.Current.Server.Execute(page, writer, false);

            string output = writer.ToString().Replace("\r", string.Empty).Replace("\n", string.Empty);

            writer.Close();

            return output;
        }


        [WebMethod]
        public static SearchResultForRendering SearchUsersResult(string searchKeyWord, string lat, string lang, string distance)
        {
            var service = new UserService();
            Page page = new ProxyPage();
            var searchResultForRendering = new SearchResultForRendering();
            double lat1;
            double lang1;
            int distance1;

            double? _lat1 = null;
            double? _lang1 = null;
            int? _distance = null;
            string orderBy = string.Empty;

            if (double.TryParse(lat, out lat1) && double.TryParse(lang, out lang1))
            {
                _lat1 = lat1;
                _lang1 = lang1;
            }

            if (int.TryParse(distance, out distance1))
            {
                _distance = distance1;
            }

            var listingUser = service.SearchUserListing(searchKeyWord, _lat1, _lang1, _distance);

            var ctl = (ListingSearchUsers)page.LoadControl("~/ListingSearchUsers.ascx");
            ctl.SearchUserListing = listingUser;
            searchResultForRendering.ListingSearchUserControl = GetUserControlHTML(ctl, page);

            return searchResultForRendering;

        }

        [WebMethod]
        public static int CreateAdhocRequest(string selectedUserId, string dishName, string tasteId, string deliveryTime, string sideDishes, string ingredientsToavoide, string cost, string textAdditionalInformation, string foodType, List<AdHocRequestPickupLocation> RequestPickupLocation, string deliveryMode, string peopleCount)
        {
            AdhocUserServiceRequestService service = new AdhocUserServiceRequestService();
            List<AdHocRequestTasteMapping> adHocRequestTasteMapping = new List<AdHocRequestTasteMapping>();
            AdHocRequestPickupLocation adHocRequestPickupLocation = null;
            bool? isVeg = null;
            float? price = null;
            float _price = 0;
            int? pplCount = null;
            int _pplCount = 0;
            bool? _deliveryMode = null;

            int retval = 0;
            List<int> selectedUsers = new List<int>();
            if (selectedUserId != "All")
            {
                selectedUsers = selectedUserId.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).Select(a => Convert.ToInt32(a)).ToList();
            }

            if (!string.IsNullOrEmpty(foodType))
            {
                if (foodType == "veg")
                {
                    isVeg = true;
                }
                else
                {
                    isVeg = false;
                }
            }

            if (!string.IsNullOrEmpty(peopleCount))
            {
                if (int.TryParse(peopleCount, out _pplCount))
                {
                    pplCount = _pplCount;
                }
            }

            if (!string.IsNullOrEmpty(cost))
            {
                if (float.TryParse(cost, out _price))
                {
                    price = _price;
                }
            }

            DateTime dateTimeDeliveryTime;

            try
            {
                dateTimeDeliveryTime = DateTime.ParseExact(deliveryTime,
                                                                "ddd, dd MMM yyyy HH:mm:ss UTC",
                                                                CultureInfo.CurrentCulture);
            }
            catch (Exception)
            {
                try
                {
                    dateTimeDeliveryTime = DateTime.ParseExact(deliveryTime,
                                                                "ddd, dd MMM yyyy HH:mm:ss GMT",
                                                                CultureInfo.CurrentCulture);
                }
                catch (Exception)
                {
                    
                    throw;
                }
                
            }

            

            

            if (!string.IsNullOrEmpty(tasteId))
            {
                adHocRequestTasteMapping = tasteId.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).Select(a => new AdHocRequestTasteMapping() { TasteID = Convert.ToInt32(a) }).ToList();
            }

            if (!string.IsNullOrEmpty(deliveryMode))
            {
                _deliveryMode = deliveryMode == "HomeDelivery";

                if (!_deliveryMode.Value)
                {
                    if (RequestPickupLocation !=  null)
                    {

                        adHocRequestPickupLocation = RequestPickupLocation.First();
                        
                    }
                }
            }

            retval = service.CreateNewAdhocUserRequest(selectedUsers, dishName, adHocRequestTasteMapping, dateTimeDeliveryTime, sideDishes, ingredientsToavoide, isVeg, price, textAdditionalInformation, CurrentUser.UserID, adHocRequestPickupLocation, _deliveryMode, pplCount);

            return retval;
        }

        [WebMethod]
        public static SearchResultForRendering UpdateSearchListingResult(string searchKeyWord, string tasteId, string lat, string lang, string distance, string foodType, string recipeType, string costRange, string ratingRange, string filtertype)
        {
            Page page = new ProxyPage();
            var service = new ListingService();
            string[] tasteIDs = null;
            string[] recipeTypes = null;
            string[] foodTypes = null;
            SearchResultForRendering searchResultForRendering = new SearchResultForRendering();
            // Filter the result according to the tasteId's
            double lat1;
            double lang1;
            int distance1;

            double? _lat1 = null;
            double? _lang1 = null;
            int? _distance = null;
            string orderBy = string.Empty;
            string receipeType = string.Empty;

            if (double.TryParse(lat, out lat1) && double.TryParse(lang, out lang1))
            {
                _lat1 = lat1;
                _lang1 = lang1;
            }

            if (int.TryParse(distance, out distance1))
            {
                _distance = distance1;
            }

            if (HttpContext.Current.Request.QueryString["order"] != null)
            {
                orderBy = HttpContext.Current.Request.QueryString["order"];
            }


            _searchListing = service.SearchListing(searchKeyWord, _lat1, _lang1, _distance);

            if (!string.IsNullOrEmpty(orderBy))
            {
                if (orderBy.ToLower() == "mp")
                {
                    _searchListing = _searchListing.OrderByDescending(a => a.OverAllRating).ToList();
                }
                else if (orderBy.ToLower() == "near")
                {
                    _searchListing = _searchListing.OrderBy(a => a.Distance).ToList();
                }

            }

            //if (!string.IsNullOrEmpty(receipeType))
            //{
            //    _searchListing = _searchListing.Where(a => a.Listing.CuisineTypeID == int.Parse(receipeType)).ToList();
            //}

            if (!string.IsNullOrEmpty(tasteId))
            {
                tasteId = tasteId.Remove(tasteId.Length - 1);
                tasteIDs = tasteId.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                _searchListing = _searchListing.Where(a => tasteIDs.Any(b => b == a.Listing.TasteID.ToString())).ToList();
            }







            // filter the result according to the foodType
            if (!string.IsNullOrEmpty(foodType))
            {
                foodType = foodType.Remove(foodType.Length - 1);
                foodTypes = foodType.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

                if (foodTypes.Count() < 2)
                {
                    foodType = foodTypes[0];
                    _searchListing = foodType == "1" ? _searchListing.Where(a => a.Listing.VegOrNonVeg).ToList() :
                                                    _searchListing.Where(a => !a.Listing.VegOrNonVeg).ToList();
                }
            }

            if (costRange.Length > 0)
            {
                //filter the result for cost range
                string[] priceRange = costRange.Split(new[] { '-' }, StringSplitOptions.RemoveEmptyEntries);
                if (priceRange.Any())
                {
                    _searchListing = _searchListing.Where(a => a.Listing.Cost >= int.Parse(priceRange[0]) && a.Listing.Cost <= int.Parse(priceRange[1])).ToList();
                }
            }

            if (ratingRange.Length > 0)
            {
                //filter the result for rating range
                string[] _ratingRange = ratingRange.Split(new[] { '-' }, StringSplitOptions.RemoveEmptyEntries);
                if (_ratingRange.Any())
                {
                    _searchListing = _searchListing.Where(a => a.OverAllRating >= int.Parse(_ratingRange[0]) && a.OverAllRating <= int.Parse(_ratingRange[1])).ToList();
                }
            }

            if (!string.IsNullOrEmpty(recipeType))
            {
                receipeType = recipeType.Remove(recipeType.Length - 1);
                recipeTypes = receipeType.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

                var foodRecipeTypeUserControl = (FoodRecipeTypeUserControl)page.LoadControl("~/FoodRecipeTypeUserControl.ascx");
                foodRecipeTypeUserControl.searchListings = _searchListing;
                foodRecipeTypeUserControl.Update = true;
                foodRecipeTypeUserControl.SelectedIDs = recipeTypes;
                searchResultForRendering.FoodRecipeTypeUserControlHTML = GetUserControlHTML(foodRecipeTypeUserControl, page);

                _searchListing = _searchListing.Where(a => recipeTypes.Any(b => b == a.Listing.RecipeTypeID.ToString())).ToList();
            }
            else
            {
                var foodRecipeTypeUserControl = (FoodRecipeTypeUserControl)page.LoadControl("~/FoodRecipeTypeUserControl.ascx");
                foodRecipeTypeUserControl.searchListings = _searchListing;
                foodRecipeTypeUserControl.Update = true;
                foodRecipeTypeUserControl.SelectedIDs = recipeTypes;
                searchResultForRendering.FoodRecipeTypeUserControlHTML = GetUserControlHTML(foodRecipeTypeUserControl, page);

            }


            var foodTypeUserControl = (FoodTypeUserControl)page.LoadControl("~/FoodTypeUserControl.ascx");
            foodTypeUserControl.searchListings = _searchListing;
            foodTypeUserControl.Update = true;
            foodTypeUserControl.SelectedIDs = foodTypes;
            searchResultForRendering.FoodTypeUserControlHTML = GetUserControlHTML(foodTypeUserControl, page);



            var foodTasteUserControl = (FoodTasteUserControl)page.LoadControl("~/FoodTasteUserControl.ascx");
            foodTasteUserControl.searchListings = _searchListing;
            foodTasteUserControl.SelectedIDs = tasteIDs;
            foodTasteUserControl.Update = true;
            searchResultForRendering.TasteUserControlHTML = GetUserControlHTML(foodTasteUserControl, page);


            var ctl = (ListingUserControl)page.LoadControl("~/ListingUserControl.ascx");
            ctl.SearchListings = _searchListing;
            searchResultForRendering.ListingUserControlHTML = GetUserControlHTML(ctl, page);

            //if (!string.IsNullOrEmpty(_receipeTypeId) && !string.IsNullOrEmpty(recipeType) && filtertype == "recipeType")
            //{
            //    receipeType = recipeType.Remove(recipeType.Length - 1);
            //    recipeTypes = receipeType.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

            //    var foodRecipeTypeUserControl = (FoodRecipeTypeUserControl)page.LoadControl("~/FoodRecipeTypeUserControl.ascx");
            //    foodRecipeTypeUserControl.searchListings = _searchListing;
            //    foodRecipeTypeUserControl.Update = true;
            //    foodRecipeTypeUserControl.SelectedIDs = recipeTypes;
            //    searchResultForRendering.FoodRecipeTypeUserControlHTML = GetUserControlHTML(foodRecipeTypeUserControl, page);

            //    if (!string.IsNullOrEmpty(recipeType))
            //    {
            //        _searchListing = _searchListing.Where(a => recipeTypes.Any(b => b == a.Listing.RecipeTypeID.ToString())).ToList();
            //    }
            //}
            //else
            //{



            //}

            searchResultForRendering.TotalResults = _searchListing.Count;

            //switch (filtertype)
            //{
            //    case "taste":
            //        break;
            //    case "foodType":
            //        break;
            //    default:
            //        break;
            //}
            return searchResultForRendering;
        }

        private void UpdateTaste()
        {
            foreach (ListItem item in this.RecipeTypeCheckBoxList.Items)
            {
                int count = _searchListing.Count(a => a.Listing.RecipeTypeID.ToString() == item.Value);
                item.Text = count > 0 ? item.Text + string.Format(" ({0}) ", count) : item.Text;
            }
        }

        private void UpdateRecipeType()
        {
            foreach (ListItem item in this.RecipeTypeCheckBoxList.Items)
            {
                int count = _searchListing.Where(a => a.Listing.TasteID.ToString() == item.Value).Count();
                item.Text = count > 0 ? item.Text + string.Format(" ({0}) ", count) : item.Text;
            }
        }

        private void UpdateFoodType()
        {
            foreach (ListItem item in this.FoodTypeCheckBoxList.Items)
            {
                int count = _searchListing.Count(a => a.Listing.VegOrNonVeg == int.Parse(item.Value) > 0);
                item.Text = count > 0 ? item.Text + string.Format(" ({0}) ", count) : item.Text;
            }
        }


        private void LoadRecipeType()
        {
            var service = new RecipeService();
            RecipeTypeCheckBoxList.DataSource = service.GetRecipeType();
            RecipeTypeCheckBoxList.DataTextField = "Name";
            RecipeTypeCheckBoxList.DataValueField = "ID";
            RecipeTypeCheckBoxList.DataBind();
        }

        private void LoadRecipeType(int recipeType)
        {
            var service = new RecipeService();
            RecipeTypeCheckBoxList.DataSource = service.GetRecipeType();
            RecipeTypeCheckBoxList.DataTextField = "Name";
            RecipeTypeCheckBoxList.DataValueField = "ID";
            RecipeTypeCheckBoxList.DataBind();

            RecipeTypeCheckBoxList.Items.FindByValue(recipeType.ToString()).Selected = true;
        }
        //
        private void LoadTaste()
        {
            var service = new TasteService();
            TasteCheckBoxList.DataSource = service.GetTastes();
            TasteCheckBoxList.DataTextField = "Name";
            TasteCheckBoxList.DataValueField = "ID";
            TasteCheckBoxList.DataBind();
        }




        private void BindListing(string searchKeyWord)
        {
            var service = new ListingService();
            _searchListing = service.SearchListing(searchKeyWord, null, null, null);
            if (!string.IsNullOrEmpty(_orderBy))
            {
                if (_orderBy == "MP")
                {
                    _searchListing = _searchListing.OrderByDescending(a => a.OverAllRating).ToList();
                }
                else if (_orderBy == "Near")
                {
                    _searchListing = _searchListing.OrderBy(a => a.Distance).ToList();
                }

            }
            UpdateRecipeType();
            if (!string.IsNullOrEmpty(_receipeTypeId))
            {
                _searchListing =
                    _searchListing.Where(a => a.Listing.RecipeTypeID == int.Parse(_receipeTypeId)).ToList();
                this.RecipeTypeCheckBoxList.Items.FindByValue(_receipeTypeId).Selected = true;
                RecipeTypeHiddenField.Value = "1";
            }

            if (_searchListing.Count > 0)
            {
                resultLiteral.Text = string.Format(_searchListing.Count.ToString() + " Results");
            }
            else
            {
                resultLiteral.Text = "No Dishes found in your area";
            }

            ListingUserControl.SearchListings = _searchListing;


        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {


        }
    }
}