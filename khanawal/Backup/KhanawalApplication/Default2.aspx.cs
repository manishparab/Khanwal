using System;
using System.Collections.Generic;
using System.Web.Services;
using KhanawalApplication.Business;
using KhanawalApplication.Entity;
using System.Web;

namespace KhanawalApplication
{
    public partial class Default2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        [WebMethod]
        public static void SaveOrderInDb(List<CodeObject> codeObjects )
        {
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                throw new Exception("this is custom expection" + DateTime.Now);
            }
            catch (Exception exception)
            {
                  FunctionsErrorLog.LogMessage(exception.Message + exception.StackTrace);
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// http://3.bp.blogspot.com/_7ATpAF0pzXQ/TTqOFnhgqVI/AAAAAAAACq8/vD90bKkStf0/s1600/FB_Post_legend.png
        /// </summary>
        /// <param name="Name">Khanawal</param>
        /// <param name="Message"></param>
        /// <param name="Description"></param>
        /// <param name="PictureUrl"></param>
        /// <param name="LinkCaption"></param>
        /// <param name="LinkUrl"></param>
        /// <param name="ActionName"></param>
        /// <param name="ActionUrl"></param>
        public void PostOnWall(string Name, string Message, string Description, string PictureUrl, string LinkCaption, string LinkUrl, string ActionName, string ActionUrl)
        {

            //string action = "https://graph.facebook.com/me/feed";
            //string postData = "access_token=" + mytoken;

            //if (!string.IsNullOrEmpty(Message)) { postData += ("&message=" + System.Web.HttpUtility.UrlEncode(Message)); }
            //if (!string.IsNullOrEmpty(LinkUrl)) { postData += ("&link=" + LinkUrl); }
            //if (!string.IsNullOrEmpty(PictureUrl)) { postData += ("&picture=" + PictureUrl); }
            //if (!string.IsNullOrEmpty(Name)) { postData += ("&name=" + System.Web.HttpUtility.UrlEncode(Name)); }
            //if (!string.IsNullOrEmpty(Description)) { postData += ("&description=" + System.Web.HttpUtility.UrlEncode(Description)); }
            //if (!string.IsNullOrEmpty(ActionName) && !string.IsNullOrEmpty(ActionUrl)) { postData += ("&actions=[{'name': " + System.Web.HttpUtility.UrlEncode("'" + ActionName + "'") + ", 'link': '" + ActionUrl + "'}]"); }

            //NetworkHelper.ExecuteHttpActionPost(action, postData);
        }  
    }
}