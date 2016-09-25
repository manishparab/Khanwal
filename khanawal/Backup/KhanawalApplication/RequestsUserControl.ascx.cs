using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KhanawalApplication
{
    public partial class RequestsUserControl : System.Web.UI.UserControl
    {
        public string RequestsUserTitle { get; set; }
        public List<AdHocRequest> Requests
        {
            set
            {
                RequestsListview.DataSource = value;
                RequestsListview.DataBind();
            }
        }

        public RequestsUserControl()
        {
            if (!String.IsNullOrEmpty(RequestsUserTitle))
            {
                this.resultLiteralTitle.Text = RequestsUserTitle;
            }
            
        }
      
    }
}