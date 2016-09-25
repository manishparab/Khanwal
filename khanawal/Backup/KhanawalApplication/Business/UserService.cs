using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using KhanawalApplication.Entity;
using System.Linq;

namespace KhanawalApplication.Business
{
    /// <summary>
    /// Summary description for UserService
    /// </summary>
    public class UserService
    {
        public UserService()
        {
            //
            // TODO: Add constructor logic here
            //
        }


        private double GetDistance(double? lat1, double? lang1, double? lat2, double? lang2)
        {
            Haversine haversine = new Haversine();
            double distance = 0;
            if (lat1.HasValue && lat2.HasValue && lang1.HasValue && lang2.HasValue)
            {
                Position pos1 = new Position() { Latitude = lat1.Value, Longitude = lang1.Value };
                Position pos2 = new Position() { Latitude = lat2.Value, Longitude = lang2.Value };
                distance = haversine.Distance(pos1, pos2, DistanceType.Kilometers);
            }

            return distance;
        }

        public List<SearchUserListing> SearchUserListing(string searchKeyWord, Double? lat2, double? lang2, int? distance)
        {

            KhanaWalEntities context = new KhanaWalEntities();
            var listingUserSearch = new List<SearchUserListing>();

            // both the conditions are same and change lator to incude the searchkeyword
            if (!string.IsNullOrEmpty(searchKeyWord))
            {
                listingUserSearch =
                    context.Users.Where(a=>a.IsActive).AsEnumerable().Select(
                        a =>
                        new SearchUserListing
                            {
                                User = a,
                                Distance = GetDistance(a.AddressLat, a.AddressLang, lat2, lang2)
                            }).ToList();
            }
            else
            {
                listingUserSearch =
                   context.Users.Where(a=>a.IsActive).AsEnumerable().Select(
                       a =>
                       new SearchUserListing
                       {
                           User = a,
                           Distance = GetDistance(a.AddressLat, a.AddressLang, lat2, lang2)
                       }).ToList();
            }

            if (distance.HasValue && lat2.HasValue && lang2.HasValue)
            {
                listingUserSearch = listingUserSearch.Where(a => a.Distance < distance && a.Distance > 0).ToList();

            }
            return listingUserSearch;
        }

  
        public AddressLatLang GetUserAddressLangLat(int userId)
        {
            KhanaWalEntities context = new KhanaWalEntities();
            AddressLatLang userAddress = null;
            var user = context.Users.Where(a => a.UserID == userId && a.IsActive).ToList();
            if (user.Count > 0 )
            {
                userAddress = user.Select(d => new AddressLatLang() { Lang = d.AddressLang, Lat = d.AddressLat , Address = d.Address }).FirstOrDefault();
            }
            return userAddress;
        }

         

        public User CreateNewFbUser(FbUser fbUser)
        {
            var context = new KhanaWalEntities();
            var user = new User();
            user.email = fbUser.email;
            user.Address = fbUser.location !=  null ? fbUser.location.name : null;
            user.fb_id = fbUser.fb_id;
            user.gender = fbUser.gender;
            user.first_name = fbUser.first_name;
            user.last_name = fbUser.last_name;
            user.username = fbUser.username;
            user.UserType = (int)UserType.FaceBook;
            user.JoinedDate = DateTime.Now.Date;
            user.BirthDate = DateTime.ParseExact(fbUser.birthday,"MM/dd/yyyy", null);
            user.ImageUrl = string.Format(@"https://graph.facebook.com/{0}/picture",
                                          fbUser.username);
            user.IsActive = true;
            user.CreateFacebookPost = true;
            user.Description = fbUser.Description;
            context.Users.AddObject(user);
            context.SaveChanges();
            return user;
        }

        public int CreateTwitterUser(TwittUser user)
        {
            var context = new KhanaWalEntities();
            var tempuser = new User()
            {
                ////email = string.Empty,
                //fb_id = user.tUser.Id.ToString(CultureInfo.InvariantCulture),
                ////gender = string.Empty,
                //first_name = user.tUser.ScreenName,
                //last_name = string.Empty,
                ////username = user.tUser.Name,
                //ImageUrl = user.tUser.ProfileImageLocation,
                //UserType = (int)UserType.Twitter
            };

            context.Users.AddObject(tempuser);
            var saveChanges = context.SaveChanges();
            return tempuser.UserID;
        }

        public User EnsureUser(BaseUser user)
        {
            
            User tempUser = null;
            tempUser = GetUser(user);
            if (tempUser == null)
            {
                switch (user.UserType)
                {
                    case UserType.FaceBook:
                        tempUser = CreateNewFbUser((FbUser)user);
                        break;
                    case UserType.Gmail:
                        break;
                    case UserType.Live:
                        break;
                    default:
                        break;
                }
            }
            return user;
        }

        
        public int UpdateContactPreferance(bool receiveSms, int userId)
        {
            var context = new KhanaWalEntities();
            var user = context.Users.First(a => a.UserID == userId);
            if (user != null)
            {
                user.ReceiveSMS = receiveSms;
            }

            int returnValue = context.SaveChanges();
            if (returnValue > 0)
            {
                HttpContext.Current.Session[Common.CurrentSession.CurrentUser] = user;
            }
            return returnValue;
        }

      

        public int UpdateSocialPreferances(bool postOnWall, int userId)
        {
            var context = new KhanaWalEntities();
            var user = context.Users.First(a => a.UserID == userId);
            if (user != null)
            {
                user.CreateFacebookPost = postOnWall;
            }

            int returnValue = context.SaveChanges();
            if (returnValue > 0)
            {
                HttpContext.Current.Session[Common.CurrentSession.CurrentUser] = user;
            }
            return returnValue;
        }

        public int UpdateUserProfileBasic(string firstName, string lastName, string gender, DateTime birthDate, 
            string emailAddress, string hp, string address, string description, int userId, float? addressLang, float? addressLat,
            string addressLine1, string addressLine2, string postalCode, string city, string state, bool isPostalStyleSeleted, string preferredCurrencyType)
        {
            // Update the user profile and save the user in session
            var context = new KhanaWalEntities();
            int returnValue = 0;

            var user = context.Users.First(a => a.UserID == userId);
            if (user != null)
            {
                user.first_name = firstName;
                user.last_name = lastName;
                user.gender = gender;
                user.BirthDate = birthDate;
                user.email = emailAddress;
                user.PhoneNumber = hp;
                
                user.Address = address;
                user.AddressLang = addressLang;
                user.AddressLat = addressLat;

                user.AddressLine1 = addressLine1;
                user.AddressLine2 = addressLine2;
                user.PostalCode = postalCode;
                int cityId, stateId;
                if (int.TryParse(city, out cityId))
                {
                    user.UserCity = cityId;
                }

                if (int.TryParse(state, out stateId))
                {
                    user.UserCity = stateId;
                }
              
                user.IsPostalStyleSeleted = isPostalStyleSeleted;
                user.Description = description;
                user.PreferredCurrencyType = preferredCurrencyType;
                user.AgreedTerms = true;
                
            }

            returnValue = context.SaveChanges();
            if (returnValue > 0 )
            {
                HttpContext.Current.Session[Common.CurrentSession.CurrentUser] = user;
            }
            return returnValue;

        }

          public User GetUser(int userId)
          {
              User user =  null;
              var context = new KhanaWalEntities();
              var users = context.Users.Where(a => a.UserID == userId);
              if (users.Any())
              {
                  user = users.First();
              }
              return user;
          }

        public User GetUser(BaseUser user)
        {
            var context = new KhanaWalEntities();
            User tempUser = null;
            int count = 0;
         

            switch (user.UserType)
            {
                case UserType.FaceBook:
                    var tempUsers = context.Users.Where(u => u.fb_id == ((FbUser)user).fb_id).ToList();
                    tempUser = tempUsers.Count > 0 ? tempUsers.FirstOrDefault() : null;
                    if (tempUser == null)
                    {
                        tempUser = CreateNewFbUser((FbUser)user);
                        //MailService service = new MailService();
                        //service.SendWelcomeMail(tempUser, "Welcome to Khanawal");
                        // send welcome mail to user 
                    }

                    break;
                case UserType.Twitter:
                    //var twitterUserId = ((TwittUser)user).tUser.Id.ToString(CultureInfo.InvariantCulture);
                    //var tempUsersTwitter = context.Users.Where(u => u.fb_id == twitterUserId).ToList();
                    //tempUser = tempUsersTwitter.Count > 0 ? tempUsersTwitter.FirstOrDefault() : null;
                    //if (tempUser == null)
                    //{
                    //    userID = CreateTwitterUser((TwittUser)user);
                    //} 
                    break;
                case UserType.Gmail:
                    break;
                case UserType.Live:
                    break;
                default:
                    break;
            }

            //;
            //if (tempUser != null)
            //{
            //    user = tempUser;
            //}
            //else
            //{
            //    user.UserID = userID;
            //}


            return tempUser;
        }

    }
}