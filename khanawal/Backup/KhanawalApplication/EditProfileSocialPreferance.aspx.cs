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
    public partial class EditProfileSocialPreferance : ParentPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //AuthenticateUser();
            if (!IsPostBack)
            {
                if (Session[Common.CurrentSession.CurrentUser] != null)
                {
                    LoadUserSocialPreferances();
                }
            }
        }

        private void LoadUserSocialPreferances()
        {
            User user = CurrentUser;
            if (user != null)
            {
                this.UserImage.ImageUrl = user.ImageUrl + "?type=large";
                this.PostListingOnFaceBookCheckbox.Checked = user.CreateFacebookPost.HasValue && user.CreateFacebookPost.Value;
            }
        }

        protected void SaveUserProfileButton_Click(object sender, EventArgs e)
        {
           UserService userService =  new UserService();
           userService.UpdateSocialPreferances(this.PostListingOnFaceBookCheckbox.Checked, CurrentUser.UserID);
        }

        [WebMethod]
        public static void SaveUserProfile(string postListingOnFaceBook)
        {
            UserService userService = new UserService();
            userService.UpdateSocialPreferances(postListingOnFaceBook == "1", ((User)HttpContext.Current.Session[Common.CurrentSession.CurrentUser]).UserID);
        }
    }
}