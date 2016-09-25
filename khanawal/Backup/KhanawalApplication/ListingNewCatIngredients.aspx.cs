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
    public partial class ListingNewCatIngredients : ParentPage
    {
        public static int ListingId;
        protected void Page_Load(object sender, EventArgs e)
        {
            ListingId = Request.QueryString["ID"] != null ? int.Parse(Request.QueryString["ID"]) : -1;
            if (!IsPostBack)
            {
                if (ListingId > 0)
                {
                    LoadDropDownLists(ListingId);
                    this.SetNavigation(ListingId.ToString());
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

        private void LoadDropDownLists(int listingId)
        {
            ListingService service =  new ListingService();
            var listing = service.GetListingById(listingId);

            this.HiddenFieldMainIngredients.Value = listing.MainIngredient;
            this.HiddenFieldSubIngredients.Value = listing.Ingredients;


            this.LoadTaste(listing.TasteID);
            this.LoadRecipeType(listing.RecipeTypeID);
            this.LoadCusineType(listing.CuisineTypeID);
            //this.LoadIngredients(listing.MainIngredientID, listingId);
            
        }

     

     
        private void LoadCusineType(int? cusineTypeId)
        {
            CusineService service = new CusineService();
            CuisineTypeDropDownList.DataSource = service.GetCuisine();
            CuisineTypeDropDownList.DataTextField = "Name";
            CuisineTypeDropDownList.DataValueField = "ID";
            CuisineTypeDropDownList.DataBind();
            CuisineTypeDropDownList.Items.Insert(0, new ListItem("--Select Cusine Type--", "0"));

            if (cusineTypeId.HasValue)
            {
                CuisineTypeDropDownList.SelectedValue = cusineTypeId.Value.ToString();
            }
            else
            {
                CuisineTypeDropDownList.Items[0].Selected = true;
            }
            
        }

        private void LoadRecipeType(int? recipeTypeId)
        {
            RecipeService service = new RecipeService();
            RecipetypeDropDownList.DataSource = service.GetRecipeType();
            RecipetypeDropDownList.DataTextField = "Name";
            RecipetypeDropDownList.DataValueField = "ID";
            RecipetypeDropDownList.DataBind();
            RecipetypeDropDownList.Items.Insert(0, new ListItem("--Select Recipe Type--", "0"));

            if (recipeTypeId.HasValue)
            {
                RecipetypeDropDownList.SelectedValue = recipeTypeId.Value.ToString();
            }
            else
            {
                RecipetypeDropDownList.Items[0].Selected = true;
            }

        }

        private void LoadDishType(bool? dishType)
        {
            
        }

        private void LoadTaste(int? tasteId)
        {
            TasteService service = new TasteService();
            TasteDropDownList.DataSource = service.GetTastes();
            TasteDropDownList.DataTextField = "Name";
            TasteDropDownList.DataValueField = "ID";
            TasteDropDownList.DataBind();
            TasteDropDownList.Items.Insert(0, new ListItem("--Select Taste--", "0"));

            if (tasteId.HasValue)
            {
                FunctionsErrorLog.LogMessage(tasteId.Value.ToString());
                TasteDropDownList.SelectedValue = tasteId.Value.ToString();
            }
            else
            {
                FunctionsErrorLog.LogMessage("0 selected");
                TasteDropDownList.ClearSelection();
                TasteDropDownList.Items[0].Selected = true;
            }

        }

        [WebMethod] 
        public static void SaveCategoryAndIngredients(string tasteId, string recipeTypeId, string cusineTypeId,
                                                      string mainIngredient, string subIngredients)
        {
            //int listingId = HttpContext.Current.Request.QueryString["Id"] != null ? int.Parse(HttpContext.Current.Request.QueryString["Id"]) : -1;

            IngredientsService ingredientsService = new IngredientsService();
            ListingService listingService = new ListingService();

            listingService.UpdateListingCategory(ListingId,
                                                 Convert.ToInt32(tasteId),
                                                 Convert.ToInt32(recipeTypeId),
                                                 Convert.ToInt32(cusineTypeId), mainIngredient,subIngredients);


           
        }

      
    }
}