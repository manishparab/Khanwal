using System;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI.WebControls;
using KhanawalApplication;
using KhanawalApplication.Business;
using KhanawalApplication.Entity;

namespace KhanawalApplication
{
    public partial class NewListing : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadDropDownLists();
            }
        }

        private void LoadDropDownLists()
        {
            this.LoadTaste();
            this.LoadRecipeType();
            this.LoadCusineType();
            this.LoadCanellation();
            this.LoadSideListings();
            this.LoadSubIngredients();
        }

        private void LoadSubIngredients()
        {
            // Code to bind subingredients
            IngredientsService service = new IngredientsService();
            var ingredintCollection =  service.GetSubIngredients();
            this.SubIngredientDropDownList.DataSource = ingredintCollection;
            this.SubIngredientDropDownList.DataBind();

            foreach (var subIngredient in ingredintCollection)
            {
                SubIngredientDropDownList.Items.FindByValue(subIngredient.ID.ToString()).
                    Attributes.Add("data-Desc", subIngredient.Description);
                SubIngredientDropDownList.Items.FindByValue(subIngredient.ID.ToString()).
                    Attributes.Add("data-Descfull", string.IsNullOrEmpty(subIngredient.Description) ? string.Empty : 
                                                                                                                       subIngredient.Description.Length > 100 ? subIngredient.Description.Substring(0, 99) + ".." : subIngredient.Description);            

            }
        }

        private void LoadSideListings()
        {
            SideListingService service =  new SideListingService();
            var sidelistingCollection =  service.GetSideListings();
            this.SideDishDropDownList.DataSource = sidelistingCollection;
            this.SideDishDropDownList.DataBind();

            foreach (var sideListing in sidelistingCollection)
            {
                SideDishDropDownList.Items.FindByValue(sideListing.ID.ToString()).Attributes.Add("data-Desc" ,sideListing.Description);
                SideDishDropDownList.Items.FindByValue(sideListing.ID.ToString()).Attributes.Add("data-Descfull", sideListing.Description.Length > 100 ? sideListing.Description.Substring(0, 99) + ".." : sideListing.Description);            
            }
        }

        private ListItem getListItemWithAttributes(SideListing listing, ListItem item)
        {
    
            item.Attributes.Add("data-desc",listing.Description);
            return item;
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

        private void LoadCusineType()
        {
            CusineService service = new CusineService();
            CuisineTypeDropDownList.DataSource = service.GetCuisine();
            CuisineTypeDropDownList.DataTextField = "Name";
            CuisineTypeDropDownList.DataValueField = "ID";
            CuisineTypeDropDownList.DataBind();
            CuisineTypeDropDownList.Items.Insert(0, new ListItem("--Select--", ""));
        }

        private void LoadRecipeType()
        {
            RecipeService service = new RecipeService();
            RecipetypeDropDownList.DataSource = service.GetRecipeType();
            RecipetypeDropDownList.DataTextField = "Name";
            RecipetypeDropDownList.DataValueField = "ID";
            RecipetypeDropDownList.DataBind();
            RecipetypeDropDownList.Items.Insert(0, new ListItem("--Select--", ""));
        }

        private void LoadTaste()
        {
            TasteService service = new TasteService();
            TasteDropDownList.DataSource = service.GetTastes();
            TasteDropDownList.DataTextField = "Name";
            TasteDropDownList.DataValueField = "ID";
            TasteDropDownList.DataBind();
            TasteDropDownList.Items.Insert(0, new ListItem("--Select--", ""));
        }

        [WebMethod]
        private static int AddNewListing(string listingName, string listingDescription)
        {
            SideListingService service =  new SideListingService();
            return service.AddSideListing(new SideListing() { Name = listingName , Description = listingDescription});
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            Listing listing = new Listing();
            MainIngredient mainIngredient = new MainIngredient();
            UserService userService = new UserService();
            ListingService listingService = new ListingService();
            IngredientsService ingredientsService =  new IngredientsService();
            int userId = 1;

            listing.Title = this.DishNameTextBox.Text.Trim();
            listing.VegOrNonVeg = this.DishTypeDropDownList.SelectedValue == "Veg";
            listing.TasteID = Convert.ToInt32(this.TasteDropDownList.SelectedValue);
            listing.RecipeTypeID = Convert.ToInt32(this.RecipetypeDropDownList.SelectedValue);
            listing.CuisineTypeID = Convert.ToInt32(this.CuisineTypeDropDownList.SelectedValue);
            string mainIngredientString = this.MainIngredientTextBox.Text.Trim();
            //listing.MainIngredientID = mainIngredient.EnsureEngredient(mainIngredientString);
            listing.Servings = Convert.ToInt32(this.PeopleDropDownList.SelectedValue);
            listing.Description = this.DishDescriptionTextBox.Text.Trim();
            listing.Cost = Convert.ToDouble(this.CostTextBox.Text.Trim());
            listing.HomeDelivery = HomedeliveryCheckbox.Checked;
        
            if (HomedeliveryCheckbox.Checked)
            {
                listing.FreeHomedelivery = HDfreeCheckbox.Checked;

                //TODO: need to apply required filter when its active
                listing.HomedeliveryCharges = Convert.ToInt32(AdditionalHDChargesTextBox.Text.Trim());
            }

            listing.SideDishProvided = SideDishcheckbox.Checked;

            listing.HomeAddressAsPickUpLocation = PickUplocationCheckBox.Checked;

            if (listing.HomeAddressAsPickUpLocation)
            {
                AddressLatLang addressLatLang = userService.GetUserAddressLangLat(userId);
                listing.AddressLang = addressLatLang.Lang;
                listing.AddressLat = addressLatLang.Lat;
                listing.Address = addressLatLang.Address;
            }
            else
            {
                listing.AddressLang = Convert.ToDouble(lngHiddenField.Value);
                listing.AddressLat = Convert.ToDouble(latHiddenField.Value);
                listing.Address = AddressHiddenField.Value;
            }

            listing.UserID = userId;
            listing.CurrencyTypeID = 1;
       
            listing.ConformaitonMessageRequired = ConfirmAvailability.Checked;
            listing.CancellationType = Convert.ToInt32(CancellationDropDownList.SelectedValue);
            listingService.SaveListing(listing);


            //TODO : main ingerdient mapping 
            //ingredientsService.EnsureMainIngredint(listing.ID, listing.MainIngredientID.Value);

            //ToDO : all ingredients mapping with main listing
            if (string.IsNullOrEmpty(SubIngredientsHiddenField.Value))
            {
                var subIngredients = SideListingHidden.Value;
                if (subIngredients.Length > 0)
                {
                    subIngredients = subIngredients.Remove(subIngredients.Length - 1, 1);
                }

                //ingredientsService.EnsureIngredients(subIngredients, listing.ID, false);

            }

            // TODO : need to add side lisitings after the listing is saved.
            if (listing.SideDishProvided)
            {
                var sideListings = SideListingHidden.Value;
                if (sideListings.Length > 0)
                {
                    sideListings = sideListings.Remove(sideListings.Length - 1, 1);
                }
                listingService.EnsureSideListings(sideListings, listing.ID);
            }

            //TODO : add images listing from HiddenFieldListingImages


            //listing.MainIngredientID = Convert.ToInt32();

            string serverRelativeFolderPathWeb = @"Capture/Images/temp/" + HttpContext.Current.Session.SessionID.ToString(CultureInfo.InvariantCulture) + "/";
            DirectoryInfo dirInfo = new DirectoryInfo(Server.MapPath(serverRelativeFolderPathWeb));
        
            FileInfo[] fileInfoArr = dirInfo.GetFiles();

            if (!string.IsNullOrEmpty(HiddenFieldListingImages.Value))
            {
                string[] hiddenFieldListingImages = HiddenFieldListingImages.Value.Split(new char[] {','},
                                                                                         StringSplitOptions.
                                                                                             RemoveEmptyEntries);
                var imagesUploaded =
                    fileInfoArr.Where(a => hiddenFieldListingImages.Any(c => c.ToLower().Trim() == a.Name.ToLower().Trim()));

                listingService.AddListingImages(fileInfoArr.ToList(), listing.ID);

            }

        }
    }
}