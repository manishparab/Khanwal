using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using KhanawalApplication;

namespace KhanawalApplication.Business
{
    public class ListingCommentsRatingService
    {
        private KhanaWalEntities _context;
        public List<LisitngReview> GetListingReviewsForListing(int listingId)
        {
            _context =  new KhanaWalEntities();
            List<LisitngReview> lisitngReviews = new List<LisitngReview>();
            return _context.LisitngReviews.Where(a => a.ListingID == listingId).ToList();
        }

        public int UpdateListingReviews(int listingId, int tasteRating, int quantityRating, int vfmRating, int serviceBehaviorRating , int userId)
        {
            var review =  new LisitngReview
                {
                    ListingID = listingId,
                    TasteRating = tasteRating,
                    QuantityRating = quantityRating,
                    VFMRating = vfmRating,
                    ServiceBehaviorRating = serviceBehaviorRating,
                    UserID = userId
                };
            return review.ID;
        }
    }
}