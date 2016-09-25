using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanawalApplication.Business;
using KhanawalApplication.Entity;

namespace KhanawalApplication
{
    public partial class UserProfile : ParentPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //AuthenticateUser();
            int userId = 0;
            if (Request.QueryString["ID"] != null)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["ID"]))
                {
                    userId = int.Parse(Request.QueryString["ID"]);
                }
            }

            if (userId  == 0)
            {
                if (CurrentUser != null)
                {
                    userId = CurrentUser.UserID;
                }
            }
            
      
            if (!Page.IsPostBack)
            {
                if (userId > 0)
                {
                    UserService userService = new UserService();
                    User user = userService.GetUser(userId);

                    if (user != null)
                    {
                        UserNameLiteral.Text = user.first_name;
                        UserImage.ImageUrl = user.ImageUrl + "?type=large";
                        UserDescriptionLiteral.Text = user.Description;
                        UserListings.UserId = userId;

                    }
                }

            }
        }
    }
}