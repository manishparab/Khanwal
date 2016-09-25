using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanawalApplication.Entity;
using System.Web.Services;
using KhanawalApplication.Business;

namespace KhanawalApplication
{
    public partial class ListingUserControl : System.Web.UI.UserControl
    {
        public List<SearchListing> SearchListings
        {
            set
            {
                this.ListingsListview.DataSource = value;
                this.ListingsListview.DataBind();
                if ( ListingsListview.Controls[0].Controls[0].FindControl("div_search_result_empty") !=  null)
                {
                    (ListingsListview.Controls[0].Controls[0].FindControl("div_search_result_empty") as Panel).Visible = !ManageListingLink;
                    (ListingsListview.Controls[0].Controls[0].FindControl("div_search_empty") as Panel).Visible = ManageListingLink; 

                }
                
            }
        }
        public bool ManageListingLink { get; set; }

     

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
               
            }
           
        }

       

      
    }
}