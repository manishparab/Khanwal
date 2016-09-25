using System;
using System.Web;
using KhanawalApplication.Business;

namespace KhanawalApplication.Entity
{
   
    /// <summary>
    /// Summary description for Common
    /// </summary>
    public class Common
    {
        public static class CurrentSession
        {
            public static readonly string TempUser = "TempUser";
            public static readonly string CurrentUser = "CurrentUser";
            public static readonly string FbAuthenticationCode = "code";
            public static readonly string RedirectUrl = "RedirectUrl";
            public static readonly string AddListingWatingForAuthentication = "AddListingWatingForAuthentication";
            public static readonly string ListingInitial = "ListingInitial";

        }

        public static class QueryString
        {
            public static readonly string RedirectUrl = "RedirectUrl";
            public static readonly string IsLogOut = "IsLogout";
        }
        public static class DbTables
        {
            public static readonly string User = "User";
            public static readonly string User1 = "User1";
            public static readonly string ListingRequest = "ListingRequest";
            public static readonly string MessageThreads = "MessageThreads";
            public static readonly string Listing = "Listing";
            public static readonly string Ingredient = "Ingredient";          
        }
        public Common()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public static void SetUserInformationInSession(string code, string callBackUrl)
        {
            //if (HttpContext.Current.Session["curruser"] != null) return;
            var oAuth = new oAuthFacebook { CallBack_Url = callBackUrl };

            //Get the access token and secret.
            //oAuth.AccessTokenGet(HttpContext.Current.Session["code"].ToString());

            oAuth.AccessTokenGet(code);

            if (oAuth.Token.Length <= 0) return;
            //We now have the credentials, so we can start making API calls
            var url = "https://graph.facebook.com/me?access_token=" + oAuth.Token;

            var json = oAuth.WebRequest(oAuthFacebook.Method.GET, url, String.Empty);

            var serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

            var user = (FbUser)serializer.Deserialize(json, typeof(FbUser));

            var service = new UserService();

            // find user information from database user type is used to query DB.

            user.UserType = UserType.FaceBook;
            var fbUSer = service.GetUser(user);
            //(FbUser)fbUSer .UserType = UserType.FaceBook;
            HttpContext.Current.Session[CurrentSession.CurrentUser] = fbUSer;
        }
    }
}