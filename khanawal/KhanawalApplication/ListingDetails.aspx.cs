using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using KhanawalApplication.Business;
using KhanawalApplication.Entity;
using KhanawalApplication.KhanawalEnum;

namespace KhanawalApplication
{
    public partial class ListingDetails : ParentPage
    {
        public int TasteRating { get; set; }
        public int QuantyRating { get; set; }
        public int VfmRating { get; set; }
        public int BehaviorRating { get; set; }
        public int OverAllRating { get; set; }


        public int? ListingId
        {
            get { return Request.QueryString["ID"] != null ? Int32.Parse(Request.QueryString["ID"]) : (int?) null; }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            //ToDo : what to do when ID is empty -- done added Error404
            if (!ListingId.HasValue)
            {
                Error404();
            }
            if (!Page.IsPostBack)
            {
                if (ListingId.HasValue)
                {
                    CheckVisibiltyOfListing(ListingId.Value);
                    PopulateListingInformation(ListingId.Value);
                    ListingIdHiddenField.Value = ListingId.Value.ToString();

                    // it means the user is not logged on
                    // rename buttons to login to order and login to give comments
                    // if the other listings are not present..hide the box
                    // if the similar listings are not present then hide the box
                    // if the side dish are not present then hide the side dish tab
                    // hide review tab if there are no reviews
                    UserLoggedInHiddenField.Value = CurrentUser == null ? "false" : "true";
                }
            }
        }

        private void CheckVisibiltyOfListing(int listingId)
        {
            var service = new ListingService();
            ListingStatus listingStatus = service.GetListingStatusforListingId(listingId);

            if (listingStatus.TitleAndDescription && listingStatus.CategoryAndIngredients &&
                listingStatus.LocationAndPricing && listingStatus.Photos)
            {
                ListingVisibiltyHiddenField.Value = "false";
            }
            else
            {
                ListingVisibiltyHiddenField.Value = "true";
                ManageListingHyperlink.NavigateUrl = "ManageListing.aspx?Id=" + listingId;
            }
        }

        public void SetAllRatings(Listing listing)
        {
            double? tasteAvg = listing.LisitngReviews.Average(a => a.TasteRating);
            if (tasteAvg != null)
                TasteRating = Convert.ToInt16(tasteAvg.Value);
            double? quantityAvg = listing.LisitngReviews.Average(b => b.QuantityRating);
            if (quantityAvg != null)
                QuantyRating = (int) quantityAvg.Value;
            double? vfmAvg = listing.LisitngReviews.Average(c => c.VFMRating);
            if (vfmAvg != null)
                VfmRating = (int) vfmAvg.Value;
            double? behaviorAverage = listing.LisitngReviews.Average(c => c.ServiceBehaviorRating);
            if (behaviorAverage != null)
                BehaviorRating = (int) behaviorAverage.Value;

            OverAllRating = (TasteRating + QuantyRating + VfmRating + BehaviorRating)/4;
        }

        private void BindListingCommentListView(Listing listing)
        {
            List<LisitngReview> reviews = listing.LisitngReviews.ToList();
            ListingCommentListView.DataSource = reviews;
            ListingCommentListView.DataBind();
            ReviewTabHiddenField.Value = reviews.Any() ? "true" : "false";
        }

        private void PopulateListingInformation(int listingId)
        {
            var service = new ListingService();
            Listing listing = service.GetListingById(listingId);
            BindListingPicturesSliders(listing.ListingPictures.ToList());
            FillListingDescriptionAndDetails(listing);
            FillSideListings(listing);
            BindOtherLisiting(listing.UserID);
            BindSimiliarlisting(listing);
            ListingOrderDate.Text = DateTime.Now.ToString("dd/MM/yyyy");
            userProfileHyperlink.HRef = "UserProfile.aspx?ID=" + listing.UserID;
            bindCalendar(listing.UserID.Value);
            BindListingCommentListView(listing);
            SetAllRatings(listing);
            BindBriefUserInformation(listing);
            BindIngredients(listing);
            CreateSEO(listing);

        }

        private void CreateSEO(Listing listing)
        {
            this.Page.Title = string.Format("{0} for {1} Rs", listing.Title, listing.Cost.ToString());
            //this.Page.MetaDescription = string.Format(
            //    "Order {0} for {1} Rs at khanawal.com, Login to place order for {0}", listing.Title,
            //    listing.Cost.ToString());
            this.Page.MetaDescription = string.Format("{0} is made from {1} and {2} and , short recipe or description of {0} is as follows {3}", listing.Title , listing.MainIngredient , listing.Ingredients, listing.Description);
            this.Page.MetaKeywords = string.Format("Online food, Order food,{0} recipe, indian food, {1} {2}",
                                                   listing.Title, listing.MainIngredient, listing.Ingredients);
            HtmlMeta tagurl = new HtmlMeta();
            tagurl.Attributes.Add("property", "og:url");
            tagurl.Content = string.Format("http://www.khanawal.com/ListingDetails.aspx?Id={0}", listing.ID);
            Page.Header.Controls.Add(tagurl);

            HtmlMeta tagimg = new HtmlMeta();
            tagimg.Attributes.Add("property", "og:img");
            tagimg.Content = listing.ListingPictures.Count > 0 ? string.Format("Khanawal.com/{0}", listing.ListingPictures.First().DisplayImageUrl) : string.Empty;
            Page.Header.Controls.Add(tagimg);
        }

        private void BindIngredients(Listing listing)
        {
            this.HiddenFieldMainIngredients.Value = listing.MainIngredient;
            this.HiddenFieldSubIngredients.Value = listing.Ingredients;
        }

        private void BindBriefUserInformation(Listing listing)
        {
            var service = new ListingService();
            UserNameLiteral.Text = listing.User.first_name;
            ListingUserImage.ImageUrl = string.Format("{0}?type=large", listing.User.ImageUrl);
            List<ListingRequest> confirmedRequests = listing.ListingRequests.Where(a => a.IsConfirmed).ToList();
            if (confirmedRequests.Any())
            {
                LiteralDishServed.Text = confirmedRequests.Count().ToString();
                LiteralDishServed.Visible = true;
            }
            else
            {
                DishServedLi.Visible = false;
            }

            Listing famousListing = service.FindFamousListingForUser(listing.UserID.Value);

            if (famousListing == null)
            {
                FamousDishLi.Visible = false;
            }
            else
            {
                FamousDishLi.Visible = true;
                FamousDishLiteral.Text = famousListing.Title;
            }
        }


        [WebMethod]
        public static int AddListingRequest(int listingId, string requestedDate, int requestedServings, string message)
        {
            FunctionsErrorLog.LogMessage("Method called");

            int userId = 0;
            User user;
            MailService mailService;
            var listingService = new ListingService();
            ;
            DateTime _requestedDate;
            ListingRequest requestlisting = null;
            MessageThreadService messageThreadService;

            DateTime.TryParseExact(requestedDate, "dd/MM/yyyy",
                                   CultureInfo.InvariantCulture,
                                   DateTimeStyles.None,
                                   out _requestedDate);

            try
            {
                user = (User) HttpContext.Current.Session[Common.CurrentSession.CurrentUser];

                if (user != null)
                {
                    userId = user.UserID;
                }
                else
                {
                    FunctionsErrorLog.LogMessage("user null");
                }


                if (listingId > 0 && userId > 0)
                {
                    FunctionsErrorLog.LogMessage("AddListingRequest");

                    requestlisting = listingService.AddListingRequest(listingId, userId, _requestedDate,
                                                                      requestedServings, message);

                    if (requestlisting != null)
                    {
                        if (requestlisting.ID > 0)
                        {
                            FunctionsErrorLog.LogMessage(requestlisting.ID.ToString());

                            // send request mail to the user
                            mailService = new MailService();
                            Listing listing = listingService.GetListingById(listingId, Common.DbTables.User);

                            //FunctionsErrorLog.LogMessage("GetListingById");

                            //FunctionsErrorLog.LogMessage("SendMail");

                            //create mail thread
                            messageThreadService = new MessageThreadService();
                            int mainMessageThreadId = messageThreadService.CreateMainMessageThread(requestlisting,
                                                                                                   listing);


                            //send mail to the listing owner
                            mailService.SendMail(ListingMails.RequestForListing, listing, requestlisting,
                                                 mainMessageThreadId.ToString());
                        }
                    }
                }
            }
            catch (Exception exception)
            {
                FunctionsErrorLog.LogMessage(exception.Message + exception.StackTrace);
            }

            return requestlisting != null ? requestlisting.ID : 0;
        }


        private void bindCalendar(int userId)
        {
            var service = new UserCalendarService();
            userCalenderListview.DataSource = service.GetUserCalendarForCurrentMonth(userId);
            userCalenderListview.DataBind();
        }

        private void BindOtherLisiting(int? userId)
        {
            if (userId.HasValue)
            {
                var service = new ListingService();

                // find the user ID for the current Listing

                List<Listing> listingsByUserId = service.GetListingsByUserId(userId.Value);
                var otherListings = listingsByUserId.Where(a => a.ListingPictures.Count > 0).Select(
                    f => new {imageurl = f.ListingPictures.First().DisplayImageUrl, listing = f});
                OtherListingListView.DataSource = otherListings;
                OtherListingListView.DataBind();

                OtherListingHiddenField.Value = otherListings.Any() ? "true" : "false";
            }
        }

        private void FillSideListings(Listing listing)
        {
            var service = new SideListingService();
            IEnumerable<SideListingMapping> sidelistings = listing.SideListingMappings.ToList().Where(a => a.Validated);
            SideDishListView.DataSource = sidelistings;
            SideDishListView.DataBind();

            SideListingTabHiddenField.Value = sidelistings.Any() ? "true" : "false";
        }

        private void BindSimiliarlisting(Listing listing)
        {
            var service = new ListingService();
            List<Listing> similarListingByName = service.GetSimilarListingByName(listing.Title, listing.ID);
            var similarListing = similarListingByName.Where(a => a.ListingPictures.Count > 0).Select(
                f => new {imageurl = f.ListingPictures.First().DisplayImageUrl, listing = f});
            SimilarListingListView.DataSource = similarListing;
            SimilarListingListView.DataBind();

            SimilarlistingHiddenField.Value = similarListing.Any() ? "true" : "false";
        }


        private void BindListingPicturesSliders(List<ListingPicture> pictures)
        {
            ListingPicturesSliders.DataSource = pictures;
            ListingPicturesSliders.DataBind();
        }

        [WebMethod]
        public static int NewReviewForListing(int listingId, string userReview, int ratingTaste, int ratingQunatity,
                                              int ratingServiceBehavour, int ratingValueForMoney)
        {
            var service = new ListingService();
            return service.AddListingReview(userReview, listingId, ratingTaste, ratingQunatity, ratingValueForMoney,
                                            ratingServiceBehavour,
                                            ((User) HttpContext.Current.Session[Common.CurrentSession.CurrentUser])
                                                .UserID);
        }


        private void FillListingDescriptionAndDetails(Listing listing)
        {
            var cancellationService = new CancellationService();

            this.HyperlinkRecipe.Text = string.Format("Recipe for {0}", listing.Title);
            ListingDescriptionLitral.Text = listing.Description;
            ListingRecipeTypeLiteral.Text = listing.RecipeType != null ? listing.RecipeType.Name : string.Empty;
            ListingMainIngredientLiteral.Text = listing.MainIngredient;
            ListingTasteLiteral.Text = listing.Taste != null ? listing.Taste.Name : string.Empty;
            //TODO
            //ListingIngredientsLiteral.Text = "";
            ListingServingsLiteral.Text = listing.Servings.ToString();
            //TODO: check if the cost is specified in the decimal format
            ListingPriceLiteral.Text = listing.Cost.ToString();
            ListingHomeDeliveryLiteral.Text = listing.HomeDelivery ? "Yes" : "No";
            if (listing.CancellationType != null)
            {
                ListingCancellationPolicyLiteral.Text =
                    cancellationService.CancellationTypes.First(c => c.Key == listing.CancellationType).Value;
            }
            ListingCostLiteral.Text = listing.Cost.ToString();
            ListingTitleLiteral.Text = listing.Title;

            if (listing.AddressLat.HasValue && listing.AddressLang.HasValue)
            {
                // if lat and long is not present[this will happen when the user has selected the postal style]
                string latlang = listing.AddressLat + "," + listing.AddressLang;
                Page.ClientScript.RegisterArrayDeclaration("latlang", latlang);
            }
        }

        protected void userCalenderListview_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                var statusUpperLabel = e.Item.FindControl("StatusLabelUpperHalf") as Label;
                var statusLowerLabel = e.Item.FindControl("StatusLabelLowerHalf") as Label;

                var calendarDatelitral = e.Item.FindControl("CalendarDatelitral") as Literal;
                string currentDate = calendarDatelitral.Text;
                string message = "";

                if (statusUpperLabel.Text == "UserAvailable" || statusLowerLabel.Text == "UserAvailable")
                {
                    if (statusUpperLabel.Text == "UserBusy")
                    {
                        message = "first half i.e in morning";
                    }

                    if (statusLowerLabel.Text == "UserBusy")
                    {
                        message = "first half i.e in evening";
                    }

                    calendarDatelitral.Text =
                        string.Format(
                            "<a Title='{1}' onClick=\"SetDateRequestListing({0}, '{1}')\" href='javascript:void(0)'>{0}</a>",
                            currentDate, message);
                }
            }
        }
    }
}