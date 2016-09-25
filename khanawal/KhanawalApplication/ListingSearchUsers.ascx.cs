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
    public partial class ListingSearchUsers : System.Web.UI.UserControl
    {

        public List<SearchUserListing> SearchUserListing
        {
            set
            {
                this.ListingsListview.DataSource = value;
                this.ListingsListview.DataBind();
            }
        }

        private void LoadListingTaste()
        {
            var service = new TasteService();
            TasteDropDownList.DataSource = service.GetTastes();
            TasteDropDownList.DataTextField = "Name";
            TasteDropDownList.DataValueField = "ID";
            TasteDropDownList.DataBind();

            //TasteDropDownList.Items.Insert(0, new ListItem("--Select Taste--", "0"));
        }

       
       
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.LoadListingTaste();
            }
        }
    }
}