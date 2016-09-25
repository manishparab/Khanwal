using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanawalApplication.Entity;

namespace KhanawalApplication
{
    public partial class FoodTypeUserControl : System.Web.UI.UserControl
    {
        public List<SearchListing> searchListings { get; set; }
        public bool Update { get; set; }
        public string[] SelectedIDs { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Update)
                {
                    UpdateFoodType();
                }
            }
        }

        private void UpdateFoodType()
        {
            foreach (ListItem item in this.FoodTypeCheckBoxList.Items)
            {
                if (SelectedIDs != null)
                {
                    item.Selected = SelectedIDs.Count(a => a == item.Value) > 0;
                }
                int count = searchListings.Count(a => a.Listing.VegOrNonVeg == int.Parse(item.Value) > 0);
                item.Text = count > 0 ? item.Text + string.Format(" ({0}) ", count) : item.Text;

                item.Attributes.Add("onclick", "javascript:FilterSearchResults('foodType')");
            }
        }
    }
}