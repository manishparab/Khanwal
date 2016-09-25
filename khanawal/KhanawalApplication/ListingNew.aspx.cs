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
    public partial class ListingNew : ParentPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            if (!IsPostBack)
            {
                //if (Session[Common.CurrentSession.AddListingWatingForAuthentication] !=  null)
                //{
                //    ListingService service =  new ListingService();

                //    // user is authenticated
                //    User user = CurrentUser;

                //    //listing which is saved in session
                //    Listing listing = (Listing)Session[Common.CurrentSession.ListingInitial];
                //    listing.UserID = user.UserID;

                //    listing = service.AddListing(listing);

                //    if (listing.ID > 0)
                //    {
                //        Session.Remove(Common.CurrentSession.ListingInitial);
                //        Session.Remove(Common.CurrentSession.AddListingWatingForAuthentication);
                //        Response.Redirect("ListingNewCatIngredients.aspx?Id=" + listing.ID);
                //    }


                //}

                if (CurrentUser !=  null)
                {
                    btnSave.Text = "Save Listing";
                    btnSave.Attributes.Add("Auth","1");
                }
              
            }
        }

        [WebMethod]
        public static int SaveInitialListing(string dishName, string vegOrNonVeg, string description, string servings)
        {
            ListingService service = new ListingService();
            Listing listing = new Listing();
            listing.Title = dishName;
            listing.VegOrNonVeg = vegOrNonVeg == "Veg";
            listing.Description = description;
            listing.Servings = int.Parse(servings);
            listing.UserID = ((User) HttpContext.Current.Session[Common.CurrentSession.CurrentUser]).UserID;
            listing = service.AddListing(listing);
            return listing.ID;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            // Save the values to the and the flag in session
            // send to the validation on facebook
            // on page load check if the flag is set , 
            // if yes then save the initial listing to the DB redirect it the category and ingredients page
            // dont forget to clear old values.

            Listing listing =  new Listing();
            listing.Title = DishNameTextBox.Text.Trim();
            listing.VegOrNonVeg = DishTypeDropDownList.SelectedValue == "Veg";
            listing.Description = DishDescriptionTextBox.Text.Trim();
            listing.Servings = int.Parse(TextBoxPeopleCount.Text);

            if (CurrentUser != null)
            {
                listing.UserID = CurrentUser.UserID;
                ListingService service = new ListingService();
                service.AddListing(listing);
                Response.Redirect("ManageListing.aspx?ID=" + listing.ID); 
            }
            else
            {
                Session[Common.CurrentSession.ListingInitial] = listing;
                Session[Common.CurrentSession.AddListingWatingForAuthentication] = "true";
                Response.Redirect("AutheticationRedirection.aspx?RedirectUrl=ListingNew.aspx"); 
            }
              
        }

       
    }
}