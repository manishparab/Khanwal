using System;
using System.Globalization;
using KhanawalApplication.Entity;

namespace KhanawalApplication
{
    public partial class AutheticationRedirection : ParentPage
    {

        public string DefaultRedirectUrl = "Home.aspx"; 
        public readonly string DefaultAuthUrl = "AutheticationRedirection.aspx";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString[Common.QueryString.IsLogOut] != null)
            {
                CurrentUser = null;
                Response.Redirect(DefaultRedirectUrl);
            }
            else
            {
                if (Request.QueryString[Common.QueryString.RedirectUrl] != null)
                {
                    Session[Common.CurrentSession.RedirectUrl] = Request.QueryString[Common.QueryString.RedirectUrl];
                }

                if (Request[Common.CurrentSession.FbAuthenticationCode] == null)
                {
                    var oAuth = new oAuthFacebook { CallBack_Url = DefaultAuthUrl };
                    Response.Redirect(oAuth.AuthorizationLinkGet());
                }
                else
                {
                    //user is authicated
                    Session[Common.CurrentSession.FbAuthenticationCode] = Request[Common.CurrentSession.FbAuthenticationCode];
                    Common.SetUserInformationInSession(Request[Common.CurrentSession.FbAuthenticationCode].ToString(CultureInfo.InvariantCulture),
                                                        DefaultAuthUrl);
                    string redirectUrl = Session[Common.CurrentSession.RedirectUrl] != null
                                             ? Session[Common.CurrentSession.RedirectUrl].ToString()
                                             : DefaultRedirectUrl;
                    Response.Redirect(redirectUrl);
                }
            }
           
        }

        
    }
}