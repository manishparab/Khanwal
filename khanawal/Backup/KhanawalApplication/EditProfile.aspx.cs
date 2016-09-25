using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using KhanawalApplication.Entity;
using KhanawalApplication.Business;

namespace KhanawalApplication
{
    public partial class EditProfile : ParentPage
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            //AuthenticateUser();

            if (!IsPostBack)
            {
                if (Session[Common.CurrentSession.CurrentUser] != null)
                {
                    LoadUserProfileForm();
                }
                else if (Session[Common.CurrentSession.TempUser] != null)
                {
                    TempHiddenField.Value = "1";
                    LoadUserProfileForm();
                }
               
            }
        }

       

        private void LoadUserProfileForm()
        {
            //this.BindCity();
            //this.BindState();
            this.BindCurrency();
            User user = CurrentUser;

            if (user == null)
            {
                user = (User)Session[Common.CurrentSession.TempUser];
                TempHiddenField.Value = "1";
            }

            if (user != null)
            {
                this.FirstNameTextBox.Text = user.first_name;
                this.LastNameTextBox.Text = user.last_name;
                this.EmailAddressTextBox.Text = user.email;
                this.PhoneNumberTextBox.Text = user.PhoneNumber;
                //this.UserAddressTextBox.Text = user.Address;
                
                this.UserAddressAddressLine1.Text = user.AddressLine1;
                this.UserAddressAddressLine2.Text = user.AddressLine2;
                this.UserAddressAddressPostalCode.Text = user.PostalCode;
                this.UserCityDropDownList.Text = user.UserCity.HasValue
                                                              ? user.UserCity.Value.ToString()
                                                              : string.Empty;

                this.UserStateDropDownList.Text = user.UserState.HasValue ? user.UserState.Value.ToString() : string.Empty;

                this.AddressStyleHiddenField.Value = user.IsPostalStyleSeleted.HasValue
                                                         ? user.IsPostalStyleSeleted.Value ? "postal" : "map"
                                                         : "psotal";

                UserGenderDropDownList.SelectedValue = user.gender.Trim();
                

                this.UserDescriptionTextBox.Text = user.Description;
                this.BirthDateTextBox.Text = user.BirthDate.HasValue
                                                 ? user.BirthDate.Value.ToString("dd/MM/yyyy")
                                                 : string.Empty;

                latHiddenField.Value = user.AddressLat.HasValue ? user.AddressLat.Value.ToString() : string.Empty;
                lngHiddenField.Value = user.AddressLang.HasValue ? user.AddressLang.Value.ToString() : string.Empty;

                this.TermsCheckBox.Checked = user.AgreedTerms.HasValue && user.AgreedTerms.Value;
                if (!string.IsNullOrEmpty(user.PreferredCurrencyType))
                {
                    if (this.currencyPreferance.Items.FindByText(user.PreferredCurrencyType) != null)
                    {
                        this.currencyPreferance.Items.FindByText(user.PreferredCurrencyType).Selected = true;
                    }
                    
                }
            }


        }

        //private void BindCity()
        //{
        //    CityService service =  new CityService();
        //    this.UserCityDropDownList.DataSource = service.GetCities();
        //    this.UserCityDropDownList.DataBind();
        //    this.UserCityDropDownList.Items.Insert(0,new ListItem("-- Select City --",""));
        //}

        private void BindCurrency()
        {
            CurrencyService service = new CurrencyService();
            this.currencyPreferance.DataSource =  service.GetCurrency();
            this.currencyPreferance.DataBind();
            this.currencyPreferance.Items.Insert(0, new ListItem("-- Select Currency Type --", ""));
        }

        //private void BindState()
        //{
        //    StateService service = new StateService();
        //    this.UserStateDropDownList.DataSource = service.GetStates();
        //    this.UserStateDropDownList.DataBind();
        //    this.UserStateDropDownList.Items.Insert(0, new ListItem("-- Select State --", ""));
        //}

        [WebMethod]
        public static int SaveUserProfile(string firstName, string lastName, string gender, string birthDate,
            string emailAddress, string hp, string address, string description, string addressLang, string addressLat,
            string addressLine1, string addressLine2, string postalcode, string city, string state, string isPostalStyleSeleted, string phoneNumber, string preferredCurrencyType)
        {
            int retVal = 0;
            var service = new UserService();
            var _birthDate = DateTime.ParseExact(birthDate, "dd/MM/yyyy", null);

            var lat = addressLat != string.Empty ? float.Parse(addressLat) : (float?)null;
            var lang = addressLang != string.Empty ? float.Parse(addressLang) : (float?)null;

            var _isPostalStyleSelected = isPostalStyleSeleted == "postal";
            User user = null;
            if (HttpContext.Current.Session[Common.CurrentSession.CurrentUser] != null)
            {
                user = ((User) HttpContext.Current.Session[Common.CurrentSession.CurrentUser]);
            }
            else
            {
                  user = ((User) HttpContext.Current.Session[Common.CurrentSession.TempUser]);
            }
           

            retVal = service.UpdateUserProfileBasic(firstName, lastName, gender.Trim(), _birthDate, emailAddress, phoneNumber, address,
                                           description, user.UserID, lang, lat, addressLine1, addressLine2, postalcode, city,
                                           state, _isPostalStyleSelected, preferredCurrencyType);
            if (retVal > 0 )
            {
               HttpContext.Current.Session.Remove(Common.CurrentSession.TempUser);
            }
            return retVal;
        }

        protected void SaveUserProfileButton_Click(object sender, EventArgs e)
        {
           var service =  new UserService();

            var firstName = this.FirstNameTextBox.Text.Trim();
            var lastname = this.LastNameTextBox.Text.Trim();
            var gender = this.UserGenderDropDownList.SelectedValue;
            var birthDate = DateTime.ParseExact(this.BirthDateTextBox.Text.Trim(), "dd/MM/yyyy", null);
            var emailAddress = this.EmailAddressTextBox.Text.Trim();
            var phoneNumber = this.PhoneNumberTextBox.Text.Trim();
            
            var address = this.AddressHiddenField.Value.Trim();
            var lat = this.latHiddenField.Value != string.Empty ? float.Parse(this.latHiddenField.Value) : (float?)null;
            var lang = this.lngHiddenField.Value != string.Empty ? float.Parse(this.lngHiddenField.Value) : (float?)null;

            var addressLine1 = this.UserAddressAddressLine1.Text.Trim();
            var addressLine2 = this.UserAddressAddressLine2.Text.Trim();
            //var city = this.UserCityDropDownList.SelectedValue;
            //var state = this.UserStateDropDownList.SelectedValue;
 
            var description = this.UserDescriptionTextBox.Text.Trim();

            var isPostalStyleSelected = this.AddressStyleHiddenField.Value == "postal";


            //service.UpdateUserProfileBasic(firstName, lastname, gender, birthDate, emailAddress, phoneNumber, address,
            //                               description, CurrentUser.UserID, lang, lat, addressLine1, addressLine2, city,
            //                               state, isPostalStyleSelected);
        }
    }
}