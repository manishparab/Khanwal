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
    public partial class EditProfileContact : ParentPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //AuthenticateUser();
            if (!IsPostBack)
            {
                if (Session[Common.CurrentSession.CurrentUser] != null)
                {
                    LoadUserContactPrerance();
                }
            }
        }

        private void LoadUserContactPrerance()
        {
            User user = CurrentUser;

            if (user != null)
            {
                this.PhoneCheckbox.Checked = user.ReceiveSMS.HasValue ? user.ReceiveSMS.Value : false;
            }

        }

        protected void SaveUserProfileButton_Click(object sender, EventArgs e)
        {
            UserService userService =  new UserService();

            userService.UpdateContactPreferance(this.PhoneCheckbox.Checked, CurrentUser.UserID);
        }

    }
}