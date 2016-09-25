using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanawalApplication.Business;

namespace KhanawalApplication
{
    public partial class AdhocRequestDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadListingTaste();
                LoadFormData();
            }
        }

        private void LoadListingTaste()
        {
            var service = new TasteService();
            TasteDropDownList.DataSource = service.GetTastes();
            TasteDropDownList.DataTextField = "Name";
            TasteDropDownList.DataValueField = "ID";
            TasteDropDownList.DataBind();

            //TasteDropDownList.Items.Insert(0, new ListItem("--Select Taste--", "0"));
        }

        private void LoadFormData()
        {
            string requestId = Request.QueryString["ID"];
            if (!string.IsNullOrEmpty(requestId))
            {
                var service = new AdhocUserServiceRequestService();
                var adHocRequest = service.GetAdHocRequestById(int.Parse(requestId));
                if (adHocRequest != null)
                {
                    VegRequestType.Checked = adHocRequest.IsVeg.HasValue && adHocRequest.IsVeg.Value;
                    NonVegRequestType.Checked = adHocRequest.IsNonVeg.HasValue && adHocRequest.IsNonVeg.Value;
                    RequestCostTextBox.Text = adHocRequest.Cost.HasValue ? adHocRequest.Cost.ToString() : string.Empty;
                    HiddenFieldTasteDropDownList.Value = string.Join(",", adHocRequest.AdHocRequestTasteMappings.Select(a=>a.TasteID));
                    HiddenFieldSideDishes.Value = adHocRequest.SideDishesWanted;
                    HiddenFieldDeliveryTime.Value = adHocRequest.DeliveryTime.ToString("MM/dd/yyyy hh:mm:ss");
                    numberOfPeople.Text = adHocRequest.PersonCount.HasValue
                                              ? adHocRequest.PersonCount.ToString()
                                              : string.Empty;
                    CheckboxHomeDelivery.Checked = adHocRequest.HomeDelivery.HasValue && adHocRequest.HomeDelivery.Value;
                    CheckboxPickUpLocation.Checked = adHocRequest.HomeDelivery.HasValue && !adHocRequest.HomeDelivery.Value;
                    if (CheckboxPickUpLocation.Checked)
                    {
                        UserPostalStyle.Visible = true;
                        UserAddressAddressLine1.Text = adHocRequest.AdHocRequestPickupLocations.First().AddRessLine1;
                        UserAddressAddressLine2.Text = adHocRequest.AdHocRequestPickupLocations.First().AddRessLine2;
                        UserAddressAddressPostalCode.Text = adHocRequest.AdHocRequestPickupLocations.First().PinCode;
                        CityTextBox.Text = adHocRequest.AdHocRequestPickupLocations.First().City;
                        StateTextBox.Text = adHocRequest.AdHocRequestPickupLocations.First().State;
                        TextAreaPickupLocation.Text = adHocRequest.AdHocRequestPickupLocations.First().LandMark;
                    }
                    HiddenFieldIngredientToAvoide.Value = adHocRequest.IngredientsToAvoide;
                    TextAdditionalInformation.Text = adHocRequest.AdditionalInformaition;

                }
            }
        }
    }
}