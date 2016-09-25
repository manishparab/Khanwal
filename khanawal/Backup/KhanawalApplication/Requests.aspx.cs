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
    public partial class Requests : ParentPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                BindRequests();
            }
        }

        private void BindRequests()
        {
            var service =  new AdhocUserServiceRequestService();
            RequestsUserControl1.Requests= service.GetAdHocRequests();
        }
    }
}