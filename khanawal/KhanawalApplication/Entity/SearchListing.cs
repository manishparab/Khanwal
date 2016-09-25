
using KhanawalApplication;
using KhanawalApplication.Business;

namespace KhanawalApplication.Entity
{
    /// <summary>
    /// Summary description for SearchListing
    /// </summary>
    public class SearchListing
    {
        public string ImageUrl { get; set; }
        public Listing Listing { get; set; }
        public int ReviewCount { get; set; }
        public bool IsValidated { get; set; }
        public double OverAllRating { get; set; }
        public double Distance { get; set; }
        public ListingStatus ListingStatus { get; set; }

        public SearchListing()
        {
            //
            // TODO: Add constructor logic here
            //
        }
    }

    public class SearchUserListing
    {
        public double Distance { get; set; }
        public User User { get;set; }
    }

    public class SearchResultForRendering
    {
        public string TasteUserControlHTML { get; set; }
        public string FoodTypeUserControlHTML { get; set; }
        public string FoodRecipeTypeUserControlHTML { get; set; }
        public string ListingUserControlHTML { get; set; }
        public string ListingSearchUserControl { get; set; }
        public int TotalResults { get; set; }
    }
}