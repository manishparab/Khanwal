using System;
using System.Collections.Generic;
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
    public partial class ListingNewPhotos : ParentPage
    {
        private int _listingId;
        public static int ListingId;
        protected void Page_Load(object sender, EventArgs e)
        {
            _listingId = Request.QueryString["ID"] != null ? int.Parse(Request.QueryString["ID"]) : -1;

            if (_listingId > 0)
            {
                fileupload.Action = "FileUploadHander.ashx?Id=" + _listingId.ToString();
                ListingId = _listingId;

                if (!IsPostBack)
                {
                    SliderImagesService service = new SliderImagesService();
                    var listingPictures = service.GetPicturesForListingId(_listingId);
                    this.ListingPhotoCount.Value = listingPictures.Count.ToString();
                    ManageListingPhotoUserControl.ListingPictures = listingPictures;
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



        [WebMethod]
        public static void SaveOrderInDb(List<CodeObject> codeObjects)
        {
            List<ListingPicture> listingPictures = codeObjects.Select(objCode => new ListingPicture()
                {
                    ID = Convert.ToInt32(objCode.Code),
                    DisplayOrder = Convert.ToInt32(objCode.Value)
                }).ToList();

            ListingService service = new ListingService();
            service.SaveListingPicturesOrder(listingPictures, ListingId);
        }

        [WebMethod]
        public static void DeleteListingPicture(string listingId, string listingUrl)
        {
            var filePath = HttpRuntime.AppDomainAppPath + listingUrl;

            if (File.Exists(filePath))
            {
                File.Delete(filePath);
            }

            var pictureListingId = listingId;
            if (!string.IsNullOrEmpty(pictureListingId))
            {
                ListingService service = new ListingService();
                service.DeleteListingPicture(Convert.ToInt32(pictureListingId));
            }
        }

        [WebMethod]
        public static string GetListingPictures()
        {
            Page page = new ProxyPage();
            SliderImagesService service = new SliderImagesService();
            var listingPictures = service.GetPicturesForListingId(ListingId);


            var manageListingPhotos = (ManageListingPhotos)page.LoadControl("~/ManageListingPhotos.ascx");
            manageListingPhotos.ListingPictures = listingPictures;

            return GetUserControlHtml(manageListingPhotos, page);

        }



        private static string GetUserControlHtml<T>(T userControl, Page page) where T : UserControl
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


    }
}