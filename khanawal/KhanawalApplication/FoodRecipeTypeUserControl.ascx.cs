﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanawalApplication.Business;
using KhanawalApplication.Entity;

namespace KhanawalApplication
{
    public partial class FoodRecipeTypeUserControl : System.Web.UI.UserControl
    {

        public List<SearchListing> searchListings { get; set; }
        public bool Update { get; set; }
        public string[] SelectedIDs { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.LoadTaste();
            }
        }

        private void LoadTaste()
        {
            var service = new RecipeService();
            RecipeTypeCheckBoxList.DataSource = service.GetRecipeType();
            RecipeTypeCheckBoxList.DataTextField = "Name";
            RecipeTypeCheckBoxList.DataValueField = "ID";
            RecipeTypeCheckBoxList.DataBind();

            if (Update)
            {
                UpdateRecipe();
            }
        }

        private void UpdateRecipe()
        {
            foreach (ListItem item in this.RecipeTypeCheckBoxList.Items)
            {
                if (SelectedIDs != null)
                {
                    item.Selected = SelectedIDs.Count(a => a == item.Value) > 0;
                }
                int count = searchListings.Where(a => a.Listing.RecipeTypeID.ToString() == item.Value).Count();
                item.Text = count > 0 ? item.Text + string.Format(" ({0}) ", count) : item.Text;

                item.Attributes.Add("onclick", "javascript:FilterSearchResults('recipeType')");
            }
        }

    }

}