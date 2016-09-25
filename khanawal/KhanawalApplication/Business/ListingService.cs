using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using KhanawalApplication;
using KhanawalApplication.Entity;

namespace KhanawalApplication.Business
{
    /// <summary>
    /// Summary description for NewListing
    /// </summary>
    public class ListingService
    {
        private KhanaWalEntities context;
       

        public bool SaveListing(Listing objListing)
        {
            context = new KhanaWalEntities();

            Listing listing = new Listing();

            context.Listings.AddObject(objListing);

            return context.SaveChanges() > 0;

        }

        public List<Listing> GetListing(string keyWord)
        {
            context = new KhanaWalEntities();
            return context.Listings.Where(a => a.Title.ToLower().Contains(keyWord.ToLower()) || a.Description.ToLower().Contains(keyWord.ToLower())).ToList();
        }



        public Image ResizeByWidth(Image Img, int NewWidth)
        {
            float PercentW = ((float)Img.Width / (float)NewWidth);

            Bitmap bmp = new Bitmap(NewWidth, (int)(Img.Height / PercentW));
            Graphics g = Graphics.FromImage(bmp);

            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
            g.DrawImage(Img, 0, 0, bmp.Width, bmp.Height);

            g.Dispose();

            return bmp;


        }

        public Listing AddListing(Listing listing)
        {
            context = new KhanaWalEntities();
            listing.ModifiedDate = DateTime.Now;
            context.Listings.AddObject(listing);
            context.SaveChanges();
            return listing;
        }

        public int DeleteListingPicture(int listingPictureId)
        {
            context =  new KhanaWalEntities();
            var listingPicture = context.ListingPictures.Where(a => a.ID == listingPictureId).ToList();
            if (listingPicture.Any())
            {
                int listingId = listingPicture.First().ListingID;
                var listing = context.Listings.First(a => a.ID == listingId);
                listing.ModifiedDate = DateTime.Now;
                context.ListingPictures.DeleteObject(listingPicture.First());
            }

            return  context.SaveChanges();
        }

        
        public int DeleteListingPicture(string listingPath, int listingPictureId)
        {
            var filePath = listingPath;
            int returnValue=0;

            if (File.Exists(filePath))
            {
                File.Delete(filePath);
            }


            if (listingPictureId > 0)
            {
                returnValue = this.DeleteListingPicture(listingPictureId);

            }

            return returnValue;
        }



        public int AddListingPicture(int listingId, string filePath, string fileUrlPath)
        {
            const int imageWidth = 1600;
            const int imageHeight = 700;

            context = new KhanaWalEntities();

            //FunctionsErrorLog.LogMessage(listingId + " " + filePath + " " + fileUrlPath);

            bool fitForSlider = false;
            Image image =  null;
            ListingPicture listingPicture = null;
            try
            {
                image = Image.FromFile(filePath);
                //if (image.Width >= imageWidth && image.Height >= imageHeight)
                //{
                //    var modifiedImage = ResizeByWidth(image, imageWidth);
                //    if (modifiedImage != null)
                //    {
                //        fitForSlider = true;
                //    } 
                      
                //}

                

                if (image.Width >= imageWidth)
                {
                    fitForSlider = true;
                }
                listingPicture =  new ListingPicture() { DisplayImageUrl = fileUrlPath, ListingID = listingId, ImageResolution = image.Width + "x" + image.Height, FitForMainDisplaySlider = fitForSlider };
                context.ListingPictures.AddObject(listingPicture);
                context.SaveChanges();
            }
            finally
            {
                if (image != null)
                {
                    image.Dispose();    
                }
                
            }

            return listingPicture.ID;

        }

        // This is old function which we need to remove
        public void AddListingImages(List<FileInfo> fileInfos, int listingId)
        {
            context = new KhanaWalEntities();

            string serverRelativeFolderPath = @"Capture/Images/" + listingId + "/";
            string serverRelativeFolderPathModifiedForSlider = @"Capture/Images/" + listingId + "/Slider/";
            string mapPath = HttpContext.Current.Server.MapPath(serverRelativeFolderPath);
            string mapPathModified = HttpContext.Current.Server.MapPath(serverRelativeFolderPathModifiedForSlider);
            int imageWidth = 1600;
            int imageHeight = 700;
            string imagePath = string.Empty;

            if (fileInfos.Count > 0)
            {
                if (!Directory.Exists(mapPath))
                {
                    Directory.CreateDirectory(mapPath);
                }
            }
            foreach (var fileInfo in fileInfos)
            {
                bool fitForSlider = false;
                var image = Image.FromFile(fileInfo.FullName);


                if (image.Width >= imageWidth && image.Height >= imageHeight)
                {
                    if (!Directory.Exists(mapPathModified))
                    {
                        Directory.CreateDirectory(mapPathModified);
                        var modifiedImage = ResizeByWidth(image, imageWidth);
                        if (modifiedImage != null)
                        {
                            modifiedImage.Save(mapPathModified + fileInfo.Name);
                            image.Save(mapPath + fileInfo.Name);
                            imagePath = serverRelativeFolderPathModifiedForSlider + fileInfo.Name;
                            fitForSlider = true;
                        }
                    }
                }
                else
                {
                    image.Save(mapPath + fileInfo.Name);
                    imagePath = serverRelativeFolderPath + fileInfo.Name;
                }
                context.ListingPictures.AddObject(new ListingPicture() { DisplayImageUrl = imagePath, ListingID = listingId, ImageResolution = image.Width + "x" + image.Height, FitForMainDisplaySlider = fitForSlider });
                image.Dispose();
            }

            context.SaveChanges();

            if (fileInfos.Count > 0)
            {
                DirectoryInfo parentDirectory = fileInfos[0].Directory;
                if (parentDirectory != null)
                {
                    parentDirectory.Delete(true);
                }
            }
        }

        public List<Listing> GetListings(int? skipNumber)
        {
            context = new KhanaWalEntities();

            List<Listing> listings = new List<Listing>();


            if (skipNumber.HasValue)
            {
                listings = context.Listings.Include("ListingPictures").Where(a => a.Validated == true && a.ListingPictures.Count > 0).Skip(skipNumber.Value).ToList();
            }
            else
            {
                listings = context.Listings.Include("ListingPictures").Where(a => a.Validated == true && a.ListingPictures.Count > 0).ToList();
            }

            return listings;
        }

        public Listing GetListingById(int listingId)
        {
            context = new KhanaWalEntities();
            return context.Listings.Include("ListingPictures").Include("LisitngReviews.User").Include("LisitngReviews").Include("RecipeType").Include("SideListingMappings.SideListing").Include("ListingIngredients.Ingredient").Include("ListingRequests").FirstOrDefault(a => a.ID == listingId);
        }

        public Listing FindFamousListingForUser(int userId)
        {
            // Find the dish which were served most.
            context = new KhanaWalEntities();
            var userListings = context.Listings.Include("ListingRequests").Where(a => a.UserID == userId).OrderBy(c=>c.Title).ToList();
            Listing famousListing = null;
            if (userListings.Any())
            {
                var mostFamousReq =
                    userListings.Where(c => c.ListingRequests.Any(d => d.IsConfirmed))
                                .OrderByDescending(a => a.ListingRequests.Count).ThenBy(f=>f.Title);

                if (mostFamousReq.Any())
                {
                    famousListing = mostFamousReq.First();
                }
                else
                {
                    famousListing = userListings.First();
                }

            }

            return famousListing;
        }


        public bool CheckUserPermission(int userId, int listingId)
        {
            bool returnValue = false;
            context = new KhanaWalEntities();
            returnValue = context.Listings.Any(a => a.UserID == userId && a.ID == listingId);
            return returnValue;
        }

        
        public int UpdatePricingAndLocation(int listingId, float? lattitude, float? longitude, string postalCode, string addressLine1,
                                          string addressLine2, int? cityId, int? stateId, bool isPostalStyleSelected, double? cost, bool homeAddressAsPickUpLocation)
        {
            context = new KhanaWalEntities();
            var listing = context.Listings.First(a => a.ID == listingId);
            //FunctionsErrorLog.LogMessage(lattitude.ToString() + " " + longitude.ToString() + " " + listingId);
            if (listing != null)
            {
                listing.IsPostalStyleSeleted = isPostalStyleSelected;
                listing.AddressLat = lattitude;
                listing.AddressLang = longitude;
                listing.PostalCode = postalCode;
                listing.AddressLine1 = addressLine1;
                listing.AddressLine2 = addressLine2;
                listing.UserCity = cityId;
                listing.UserState = stateId;
                listing.Cost = cost;
                listing.HomeAddressAsPickUpLocation = homeAddressAsPickUpLocation;
                listing.ModifiedDate = DateTime.Now;
            }

            return context.SaveChanges();
        }

        public Listing GetListingById(int listingId, string includeProperty)
        {
            context = new KhanaWalEntities();
            return context.Listings.Include(includeProperty).Where(c => c.ID == listingId).FirstOrDefault();
        }

        public List<Listing> GetListingsByUserId(int userId)
        {
            context = new KhanaWalEntities();
            return context.Listings.Include("ListingPictures").Where(a => a.Validated && a.UserID == userId).ToList();
        }

        public List<Listing> GetOtherListingsByUser(int userId, int listingId)
        {
            context = new KhanaWalEntities();
            var listings = GetListingsByUserId(userId);
            return  listings.Where(a=>a.ID != listingId).ToList();
        }

        public List<Listing> GetSimilarListingByName(string listingName, int listingId)
        {
            context = new KhanaWalEntities();
            var listingNames = listingName.Split(null);
            List<Listing> listings = context.Listings.Include("ListingPictures").Where(a => a.Validated && a.ID != listingId && listingNames.Any(f => a.Title.ToLower().Contains(f.ToLower()))).ToList();
            return listings.Distinct().ToList();
        }


        public List<LisitngReview> GetListingReviewsForListing(int listingId)
        {
            context = new KhanaWalEntities();
            List<LisitngReview> lisitngReviews = new List<LisitngReview>();
            return context.LisitngReviews.Where(a => a.ListingID == listingId).ToList();
        }

        public int AddListingReview(string userReview, int listingId, int tasteRating, int quantityRating, int vfmRating, int serviceBehaviorRating, int userId)
        {
            var review = new LisitngReview
            {
                Review = userReview,
                ListingID = listingId,
                TasteRating = tasteRating,
                QuantityRating = quantityRating,
                VFMRating = vfmRating,
                ServiceBehaviorRating = serviceBehaviorRating,
                UserID = userId,
            };
            context = new KhanaWalEntities();
            context.LisitngReviews.AddObject(review);
            context.SaveChanges();
            return review.ID;
        }

       

        public ListingRequest AddListingRequest(int listingId, int requestorId, DateTime requestedDate, int requestedServings, string message)
        {
            //FunctionsErrorLog.LogMessage(string.Format("listingId {0},requestorId{1},requestedDate{2},requestedServings{3},message{4}", listingId, requestorId, requestedDate, requestedServings,message));
            // userID is for the person who has made request
            context = new KhanaWalEntities();
            ListingRequest request = new ListingRequest();
            request.ListingID = listingId;
            request.UserID = requestorId;
            request.RequestedDate = requestedDate;
            request.RequestedServings = requestedServings;
            request.Message = message;
            context.ListingRequests.AddObject(request);
            context.SaveChanges();
            context.Dispose();
            return request;
        }

        private string GetPictureUrl(Listing listing)
        {
            string pictureUrl = string.Empty;
            if (listing.ListingPictures.Count > 0)
            {
                pictureUrl = listing.ListingPictures.First().DisplayImageUrl;
            }
            return pictureUrl;
        }
        
       private double GetOverAllRating(Listing listing)
       {
           double overAllRating = 0;
           double? tasteRating=0;
           double? quantityRating=0;
           double? vfmRating=0;
           double? serviceBehaviourRating=0;
           List<LisitngReview> listingReviews = null;

           if (listing.LisitngReviews.Count > 0)
           {
               listingReviews = listing.LisitngReviews.ToList();

               tasteRating = listingReviews.Average(a => a.TasteRating);
               quantityRating = listingReviews.Average(a => a.QuantityRating);
               vfmRating = listingReviews.Average(a => a.VFMRating);
               serviceBehaviourRating = listingReviews.Average(a => a.ServiceBehaviorRating);
               overAllRating = (tasteRating.Value + quantityRating.Value + vfmRating.Value + serviceBehaviourRating.Value)/4;
           }

           return overAllRating;
       }

        public int UpdateListingTitleAndDescription(int listingId, string title, string description, int servings, bool isVeg)
        {
            context = new KhanaWalEntities();
            int returnValue = 0;
            var listings = context.Listings.Where(a => a.ID == listingId);
            if (listings.Any())
            {
                var listing = listings.First();
                listing.Title = title;
                listing.VegOrNonVeg = isVeg;
                listing.Description = description;
                listing.Servings = servings;
                listing.ModifiedDate = DateTime.Now;
                returnValue = context.SaveChanges();
            }

            return returnValue;
        }

        public int UpdateListingCategory(int listingId, int tasteId, int recipeTypeId, int cusineTypeId, string mainIngredient, string subIngredients)
        {
            context = new KhanaWalEntities();
            int returnValue = 0;
            var listings = context.Listings.Where(a => a.ID == listingId);
            if (listings.Any())
            {
                var listing = listings.First();
                listing.TasteID = tasteId;
                listing.RecipeTypeID = recipeTypeId;
                listing.CuisineTypeID = cusineTypeId;
                listing.MainIngredient = mainIngredient;
                listing.Ingredients = subIngredients;
                listing.ModifiedDate = DateTime.Now;
                returnValue = context.SaveChanges();
            }

            return returnValue;
        }

        private double GetDistance(double? lat1, double? lang1, double? lat2, double? lang2)
        {
            Haversine haversine = new Haversine();
            double distance = 0;
            if (lat1.HasValue && lat2.HasValue && lang1.HasValue && lang2.HasValue)
            {
                Position pos1 = new Position() { Latitude = lat1.Value, Longitude = lang1.Value };
                Position pos2 = new Position() { Latitude = lat2.Value, Longitude = lang2.Value };
                distance =  haversine.Distance(pos1, pos2, DistanceType.Kilometers);
            }

            return distance;
        }

        public List<SearchListing> SearchListing(string searchKeyWord, Double? lat2, double? lang2, int? distance)
        {
             
            context = new KhanaWalEntities();
            var listingsSearch =  new List<SearchListing>();
            if (!string.IsNullOrEmpty(searchKeyWord))
            {
                listingsSearch = context.ListingSearch(searchKeyWord).Select(a => new SearchListing { Listing = a, Distance = GetDistance(a.AddressLat,a.AddressLang,lat2,lang2), ReviewCount = a.LisitngReviews.Count(r => !string.IsNullOrEmpty(r.Review)), ImageUrl = GetPictureUrl(a), IsValidated = a.Validated, OverAllRating = GetOverAllRating(a) }).Where(b => !string.IsNullOrEmpty(b.ImageUrl) && b.IsValidated).ToList();
            }
            else
            {
                listingsSearch = context.Listings.Include("ListingPictures").Include("LisitngReviews").AsEnumerable().Select(a => new SearchListing { Listing = a, Distance = GetDistance(a.AddressLat, a.AddressLang, lat2, lang2), ReviewCount = a.LisitngReviews.Count(r => !string.IsNullOrEmpty(r.Review)), ImageUrl = GetPictureUrl(a), IsValidated = a.Validated, OverAllRating = GetOverAllRating(a) }).Where(b => !string.IsNullOrEmpty(b.ImageUrl) && b.IsValidated).ToList();
            }

            if (distance.HasValue && lat2.HasValue && lang2.HasValue)
            {
                listingsSearch = listingsSearch.Where(a => a.Distance < distance && a.Distance > 0).ToList();

            }
            return listingsSearch;
        }

        private bool CheckIfListingAddressIsCompleted(Listing listing)
        {
            if (listing.IsPostalStyleSeleted != null && listing.IsPostalStyleSeleted.Value)
            {
                return listing.UserState.HasValue ||
                       listing.UserCity.HasValue ||
                       !string.IsNullOrEmpty(listing.AddressLine1) ||
                       !string.IsNullOrEmpty(listing.AddressLine2);

            }
            else
            {
                return listing.AddressLang.HasValue && listing.AddressLat.HasValue;
            }

        }

        public ListingStatus GetListingStatusforListing(Listing listing)
        {
                // veg and nog veg will always have some value.
                //Todo : not sure what needs to be done when ther is no side listing
               var status = new ListingStatus
                {
                    TitleAndDescription = !string.IsNullOrEmpty(listing.Title) &&
                                          !string.IsNullOrEmpty(listing.Description) && listing.Servings > 0,
                    CategoryAndIngredients = listing.TasteID > 0 && listing.RecipeTypeID > 0 &&
                                             listing.CuisineTypeID > 0 && listing.MainIngredient != null,
                    //&& listing.SideListingMappings.Count > 0,
                    Photos = listing.ListingPictures.Count > 0,
                    LocationAndPricing = CheckIfListingAddressIsCompleted(listing) && listing.Cost > 0,
                };

                status.ValidstionStatus = status.TitleAndDescription && status.CategoryAndIngredients && status.Photos &&
                                          status.LocationAndPricing;
            return status;
        }

        public ListingStatus GetListingStatusforListingId(int listingId)
        {
            context = new KhanaWalEntities();
            ListingStatus status = null;
            var listings = context.Listings.Where(a => a.ID == listingId).ToList();
            if (listings.Any())
            {
                var listing = listings.First();
                // veg and nog veg will always have some value.
                //Todo : not sure what needs to be done when ther is no side listing
                status = new ListingStatus
                    {
                        TitleAndDescription = !string.IsNullOrEmpty(listing.Title) &&
                                              !string.IsNullOrEmpty(listing.Description) && listing.Servings > 0,
                        CategoryAndIngredients = listing.TasteID > 0 && listing.RecipeTypeID > 0 &&
                                                 listing.CuisineTypeID > 0 && listing.MainIngredient != null,
                                                 //&& listing.SideListingMappings.Count > 0,
                        Photos = listing.ListingPictures.Count > 0,
                        LocationAndPricing = CheckIfListingAddressIsCompleted(listing) && listing.Cost > 0,
                    };

                status.ValidstionStatus = status.TitleAndDescription && status.CategoryAndIngredients && status.Photos &&
                                          status.LocationAndPricing;

            }

            return status;
        }

        public List<SearchListing> GetListingsForCurrentUser(int listingOwnerId)
        {
            context = new KhanaWalEntities();
            var listingSearch = context.Listings.Where(l => l.UserID == listingOwnerId).ToList();
            var listingSearchNew = listingSearch.Select(a => new SearchListing { Listing = a, ReviewCount = a.LisitngReviews.Count(r => !string.IsNullOrEmpty(r.Review)), ImageUrl = GetPictureUrl(a), ListingStatus  = GetListingStatusforListing(a)}).ToList();
            return listingSearchNew;
        }

        public int UpdateAdditionalOptions(bool homeDelivery, bool isFreeHomeDelivery, int homeDeliveryCost,
                                            int cancellationId, int listingId, string sideListings)
        {
            context =  new KhanaWalEntities();
            var listings = context.Listings.Where(l => l.ID == listingId).ToList();
           
            if (listings.Any())
            {
                var listing = listings.First();
                listing.HomeDelivery = homeDelivery;
                listing.SideListings = sideListings;
                listing.FreeHomedelivery = isFreeHomeDelivery;
                listing.HomedeliveryCharges = homeDeliveryCost;
                listing.CancellationType = cancellationId;
                listing.ModifiedDate = DateTime.Now;
            }

           return context.SaveChanges();

        }

        public void EnsureSideListings(string sidelistingsNames, int mainListingId)
        {
            context = new KhanaWalEntities();

            List<string> sidelistings = sidelistingsNames.Split(new char[] { '$' }, StringSplitOptions.RemoveEmptyEntries).ToList();

            // Add To lisiting table with the sidelisting as true and at the same time add it to the the side listings-listing 
            //relation.

            List<SideListing> sideListings = context.SideListings.ToList();
            var sideListingMappings = context.SideListingMappings.Where(l=>l.ListingID == mainListingId).ToList();
            foreach (var sideListingMapping in sideListingMappings)
            {
                context.SideListingMappings.DeleteObject(sideListingMapping);
            }
          
            foreach (string sidelisting in sidelistings)
            {
                var sidelistingValues =
                    sidelisting.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries).ToList();

                var selectedSideListing = sideListings.Where(a => a.Name.ToLower() == sidelistingValues[0].ToLower()).ToList();
                SideListing objSideListing;
                if (!selectedSideListing.Any())
                {
                    objSideListing = new SideListing();
                    objSideListing.Name = sidelistingValues[0];
                    objSideListing.Description = sidelistingValues[2];
                    context.SideListings.AddObject(objSideListing);
                    context.SaveChanges();
                }
                else
                {
                    objSideListing = selectedSideListing.First();
                }

                
                context.SideListingMappings.AddObject(new SideListingMapping() { ListingID = mainListingId, SideListingID = objSideListing.ID });    
                
            }
            context.SaveChanges();

            if (context.SideListingMappings.Any())
            {
                var listings = context.Listings.Where(a => a.ID == mainListingId);

                if (listings.Any())
                {
                    var objlisting = listings.First();
                    objlisting.SideDishProvided = true;
                    context.SaveChanges();
                }
            }
        }

        public int SaveListingPicturesOrder(List<ListingPicture> listingPictures, int listingId)
        {
            context = new KhanaWalEntities();
            var listingPics = context.ListingPictures.Where(a => a.ListingID == listingId).ToList();
            foreach (var listingPicture in listingPics)
            {
                int pictureOrder = 0;
                if (listingPictures.Any(a => a.ID == listingPicture.ID))
                {
                    listingPicture.DisplayOrder = listingPictures.First(a => a.ID == listingPicture.ID).DisplayOrder;
                }
            }

            return context.SaveChanges();

        }

        public int UpdateFacePostPostIdForListing(int listingId, string facebookPostId)
        {
            context = new KhanaWalEntities();
            var listings = context.Listings.Where(a => a.ID == listingId);
            if (listings.Any())
            {
                var listing = listings.First();
                listing.FaceBookPostId = facebookPostId;
            }
           return context.SaveChanges();
        }


        public List<ListingRequest> GetListingRequestsForUser(int userId)
        {
            context =  new KhanaWalEntities();
            return context.ListingRequests.Include("mainmessages").Include("listing").Include("listing.listingpictures")
                                           .Where(a => a.UserID == userId).OrderByDescending(a=>a.RequestAccepted).ThenByDescending(a=>a.RequestedDate).ToList();
        }

    }
}