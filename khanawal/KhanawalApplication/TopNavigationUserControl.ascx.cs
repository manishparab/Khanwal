using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanawalApplication.Entity;
using System.Linq;

namespace KhanawalApplication
{
    public partial class TopNavigationUserControl : System.Web.UI.UserControl
    {
        public string PageName { get; set; }
        public bool IsAuthenticated { get; set; }
        public bool ReloadPage { get; set; }
        public bool HasPermissionOnCurrentListing { get; set; }

        public List<TopNavigation> TopNavigations = new List<TopNavigation>();
       
        public TopNavigationUserControl()
        {
            // Anon entry
           TopNavigations.Add(new TopNavigation(){Id = 1,MenuName = "Home" ,MenuUrl = "Home.aspx", Active = true});
           TopNavigations.Add(new TopNavigation() {Id = 2,MenuName = "Listing", MenuUrl = "Listings.aspx" });
           
            if (HttpContext.Current.Session[Common.CurrentSession.CurrentUser] != null)
            {
                //Authenticated Entry
                TopNavigations.Add(new TopNavigation() {Id = 3,MenuName = "Inbox", MenuUrl = "Inbox.aspx" });
            }
        }

        public void ClearSelection()
        {
            if (TopNavigations != null)
            {
                TopNavigations.Where(a=>a.Active).ToList().ForEach(b=> b.Active = false);
            }
        }

        private void SetMenuVisibility()
        {
            if (HttpContext.Current.Session[Common.CurrentSession.CurrentUser] != null)
            {
                currentUserName.Text =
                    ((User) HttpContext.Current.Session[Common.CurrentSession.CurrentUser]).first_name;

                
                currentUserUl.Visible = true;
                InboxUl.Visible = true;
                LoginUl.Visible = false;
                SignUpUl.Visible = false;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
          
            if (!IsPostBack)
            {
                HiddenFieldPageUserName.Value = Path.GetFileName(Request.Url.LocalPath);
                HiddenFieldReloadPage.Value = ReloadPage ? 1.ToString() : 0.ToString();

                if (IsAuthenticated)
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "script",
                                                 HttpContext.Current.Session[Common.CurrentSession.CurrentUser] !=
                                                 null
                                                     ? "ShowAuthentication(1)"
                                                     : "ShowAuthentication(0)", true);
                }

                
                if (HasPermissionOnCurrentListing)
                {
                    if (HttpContext.Current.Request["Id"] != null)
                    {
                        if (!ParentPage.HasPermission(int.Parse(HttpContext.Current.Request["Id"].ToString())))
                        {
                           Response.RedirectPermanent("AccessDenied.aspx");
                        }
                        
                    }
                  
                }
               
                //HiddenFieldIsUserAutheticated.Value = HttpContext.Current.Session[Common.CurrentSession.CurrentUser] != null ? "1" : "0";
                //FaceBookRedirectUrl.HRef = "AutheticationRedirection.aspx?" + Common.QueryString.RedirectUrl + "=" + Request.RawUrl;
                //TwitterRedirectUrl.HRef = "AutheticationRedirection.aspx?" + Common.QueryString.RedirectUrl + "=" + Request.RawUrl;
                this.SetMenuVisibility();
                // NaviagtionListView.DataSource = TopNavigations;
                //NaviagtionListView.DataBind();


            }
        }
    }
}