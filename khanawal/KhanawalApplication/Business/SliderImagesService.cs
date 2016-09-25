using System.Collections.Generic;
using System.Linq;
using KhanawalApplication;

namespace KhanawalApplication.Business
{
    /// <summary>
    /// Summary description for SliderImagesService
    /// </summary>
    public class SliderImagesService
    {
        private KhanaWalEntities context;
        public SliderImagesService()
        {
           context =  new KhanaWalEntities();
        }

        public List<ListingPicture>  GetListingPicturesForHeroSlider()
        {
            List<ListingPicture> listingPictures =  new List<ListingPicture>();
            listingPictures = context.ListingPictures.Where(a => a.FitForMainDisplaySlider == true).ToList();
            return listingPictures;
           
        }

        public List<ListingPicture> GetPicturesForListingId(int listingId)
        {
            List<ListingPicture> listingPictures = new List<ListingPicture>();
            //TODO : if the listing has hero image then would it look nice if we returned it in slider
            listingPictures =
                context.ListingPictures.Where(a => a.ListingID == listingId)
                       .OrderBy(a => a.DisplayOrder)
                       .ThenBy(b => b.ID)
                       .ToList();
            return listingPictures;
        }
    }
}
