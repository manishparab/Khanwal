using System;
using System.IO;
using System.Net;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using KhanawalApplication;
using KhanawalApplication.Business;

namespace KhanawalApplication.Entity
{
    /// <summary>
    /// Summary description for ParentPage
    /// </summary>
    public class ParentPage : System.Web.UI.Page
    {
        public ParentPage()
        {
            //
            // TODO: Add constructor logic here
            //
            this.CheckAuthicationStatus();
        }

        public void CheckAuthicationStatus()
        {
            //Server.Execute("AutheticationRedirection.aspx?RedirectUrl=" + HttpContext.Current.Request.Url);

        }

        public static bool HasPermission(int listingId)
        {
            bool returnValue = false;
            User currentUser = CurrentUser;

            if (currentUser != null)
            {
                ListingService service = new ListingService();
                returnValue = service.CheckUserPermission(currentUser.UserID, listingId);
            }
            return returnValue;
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

        public static void Error404()
        {
            HttpContext.Current.Response.Redirect("404.aspx?ErrorUrl=" + HttpContext.Current.Request.Url);
        }

        //public void AuthenticateUser()
        //{

        //    if (HttpContext.Current.Session[Common.CurrentSession.CurrentUser] == null)
        //    {
        //        //HttpContext.Current.Response.Redirect("AutheticationRedirection.aspx?RedirectUrl=" + HttpContext.Current.Request.Url);
        //        //Page.ClientScript.RegisterStartupScript(this.GetType(), "Authenticate", "FB.Login();", true);
        //    }

        //}

        [WebMethod]
        public static AuthData SignUp(string id, string userName, string firstName, string lastName, string locationName, string email, string birthdate, string bio, string gender)
        {
            AuthData returnValue = new AuthData();

            if (HttpContext.Current.Session[Common.CurrentSession.CurrentUser] != null)
            {
                returnValue.AuthStatus = true;
            }
            else
            {


                FbUser user = new FbUser();
                ProxyPage page = new ProxyPage();
                var service = new UserService();


                if (id != "undefined")
                {
                    try
                    {
                        user.fb_id = id;
                        user.first_name = firstName;
                        user.last_name = lastName;
                        user.username = userName;
                        if (locationName != "undefined")
                        {
                            user.location = new location();
                            user.location.name = locationName;
                        }

                        user.email = email;
                        user.birthday = birthdate;
                        user.gender = gender;
                        user.Description = bio;
                        user.UserType = UserType.FaceBook;


                        var fbUSer = service.GetUser(user);
                        //(FbUser)fbUSer .UserType = UserType.FaceBook;
                        if (fbUSer.AgreedTerms.HasValue && fbUSer.AgreedTerms.Value)
                        {
                            HttpContext.Current.Session[Common.CurrentSession.CurrentUser] = fbUSer;
                            var ctl = (TopNavigationUserControl)page.LoadControl("~/TopNavigationUserControl.ascx");
                            returnValue.TopNavigationHtml = GetUserControlHtml(ctl, page);
                            returnValue.IsAuthenticationSuccessful = true;
                            returnValue.IsTermsAggred = fbUSer.AgreedTerms.Value;
                        }
                        else
                        {
                            HttpContext.Current.Session[Common.CurrentSession.TempUser] = fbUSer;
                            returnValue.TopNavigationHtml = string.Empty;
                            returnValue.IsAuthenticationSuccessful = true;
                            returnValue.IsTermsAggred = false;
                        }

                    }
                    catch (Exception exception)
                    {

                        returnValue.IsAuthenticationSuccessful = false;
                    }
                }
            }
            // find user information from database user type is used to query DB.

            return returnValue;
        }



        [WebMethod]
        public static AuthData AuthenticateUser(string id, string userName, string firstName, string lastName, string locationName, string email, string birthdate, string bio, string gender)
        {
            AuthData returnValue = new AuthData();

            if (HttpContext.Current.Session[Common.CurrentSession.CurrentUser] != null)
            {
                returnValue.AuthStatus = true;
            }
            else
            {


                FbUser user = new FbUser();
                ProxyPage page = new ProxyPage();
                var service = new UserService();


                if (id != "undefined")
                {
                    try
                    {
                        user.fb_id = id;
                        user.first_name = firstName;
                        user.last_name = lastName;
                        user.username = userName;
                        if (locationName != "undefined")
                        {
                            user.location = new location();
                            user.location.name = locationName;
                        }

                        user.email = email;
                        user.birthday = birthdate;
                        user.gender = gender;
                        user.Description = bio;
                        user.UserType = UserType.FaceBook;


                        var fbUSer = service.GetUser(user);
                        //(FbUser)fbUSer .UserType = UserType.FaceBook;

                        if (fbUSer.AgreedTerms.HasValue && fbUSer.AgreedTerms.Value)
                        {
                            HttpContext.Current.Session[Common.CurrentSession.CurrentUser] = fbUSer;
                            var ctl = (TopNavigationUserControl)page.LoadControl("~/TopNavigationUserControl.ascx");
                            returnValue.TopNavigationHtml = GetUserControlHtml(ctl, page);
                            returnValue.IsAuthenticationSuccessful = true;
                            returnValue.IsTermsAggred = fbUSer.AgreedTerms.Value;
                        }
                        else
                        {
                            HttpContext.Current.Session[Common.CurrentSession.TempUser] = fbUSer;
                            returnValue.TopNavigationHtml = string.Empty;
                            returnValue.IsAuthenticationSuccessful = true;
                            returnValue.IsTermsAggred = false;
                        }

                    }
                    catch (Exception exception)
                    {
                        FunctionsErrorLog.LogMessage(exception.Message + exception.StackTrace);
                        returnValue.IsAuthenticationSuccessful = false;
                    }
                }
            }
            // find user information from database user type is used to query DB.

            return returnValue;
        }

        public static User CurrentUser
        {
            set { HttpContext.Current.Session[Common.CurrentSession.CurrentUser] = value; }
            get
            {
                User currentUser = null;
                if (HttpContext.Current.Session[Common.CurrentSession.CurrentUser] != null)
                {
                    currentUser = (User)HttpContext.Current.Session[Common.CurrentSession.CurrentUser];
                }
                // else
                //{
                //    //TODO: Later to be replaced with DB call
                //    currentUser = new User();

                //    currentUser.UserID = 2;
                //    currentUser.first_name = "Shilpa";
                //    currentUser.last_name = "Parab";
                //    currentUser.email = "manish.parab@hotmail.com";

                //    //currentUser.UserID = 1;
                //    //currentUser.first_name = "Manish";
                //    //currentUser.last_name = "Parab";
                //    //currentUser.email = "manish.parab@hotmail.com";

                //    HttpContext.Current.Session[Common.CurrentSession.CurrentUser] = currentUser;
                //}

                return currentUser;
            }

        }
    }
}