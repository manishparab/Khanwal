using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KhanawalApplication
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            IPAddress address = GetIp(HttpContext.Current.Request);
            Response.Write(address.ToString());
        }

        public IPAddress GetIp(HttpRequest request)
        {
            string ipString;
            if (string.IsNullOrEmpty(request.ServerVariables["HTTP_X_FORWARDED_FOR"]))
            {
                ipString = request.ServerVariables["REMOTE_ADDR"];
            }
            else
            {
                ipString = request.ServerVariables["HTTP_X_FORWARDED_FOR"].Split(",".ToCharArray(), StringSplitOptions.RemoveEmptyEntries)
                    .FirstOrDefault();
            }

            IPAddress result;
            if (!IPAddress.TryParse(ipString, out result))
            {
                result = IPAddress.None;
            }

            return result;
        }
    }
}