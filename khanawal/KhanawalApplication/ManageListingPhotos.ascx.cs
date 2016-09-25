using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanawalApplication.Business;

namespace KhanawalApplication
{
    public partial class ManageListingPhotos : System.Web.UI.UserControl
    {
        public List<ListingPicture> ListingPictures { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindListingPictures();
            }
        }

        private void BindListingPictures()
        {
            if (ListingPictures != null)
            {
                this.ListingPicturesListView.DataSource = ListingPictures;
                this.ListingPicturesListView.DataBind();
            }
        }
    }
}