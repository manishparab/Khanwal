using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanawalApplication.Business;
using KhanawalApplication.Entity;

namespace KhanawalApplication
{
    public partial class UpdateCalendar : ParentPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //AuthenticateUser();
            if (!IsPostBack)
            {
                if (Session[Common.CurrentSession.CurrentUser] != null)
                {
                    this.BindCalndar();    
                }
                
            }
        }

        [WebMethod]
        public static int UpdateUserCalendar(List<UserCalendarEnity> userCalendarEnity)
        {
            UserCalendarService service =  new UserCalendarService();
            return service.UpdateUserCalendar(userCalendarEnity,((User)HttpContext.Current.Session[Common.CurrentSession.CurrentUser]).UserID);
        }

        private void BindCalndar()
        {
            UserCalendarService service = new UserCalendarService();
            this.userCalenderListview.DataSource = service.GetUserCalendarForCurrentMonth(CurrentUser.UserID);
            this.userCalenderListview.DataBind();

            //this.CurrentMonthAndYearLiteral.Text = DateTime.Now.ToString("MMMM yyyy");
        }
    }
}