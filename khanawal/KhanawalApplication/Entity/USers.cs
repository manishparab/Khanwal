using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace KhanawalApplication.Entity
{
    [Serializable()]
    public class FbUser : BaseUser
    {
        public List<FavoriteAthlete> favorite_athletes { get; set; }
        public double timezone { get; set; }
        public string locale { get; set; }
        public bool verified { get; set; }
        public string updated_time { get; set; }
        public location location { get; set; }
        public string birthday { get; set; }
        //we need to map this id to fb_id
        public string id { get; set; }
    }

    public class FavoriteAthlete
    {
        public string id { get; set; }
        public string name { get; set; }
    }


    public class location
    {
        public string id { get; set; }
        public string name { get; set; }
    }

    public enum UserType
    {
        FaceBook = 1,
        Gmail = 2,
        Live = 3,
        Twitter = 4
    }

    [Serializable()]
    public class BaseUser : User
    {
        public UserType UserType { get; set; }
        
    }

    public class TwittUser : BaseUser
    {
       
    }

}