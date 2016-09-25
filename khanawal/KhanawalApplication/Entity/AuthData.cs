using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace KhanawalApplication.Entity
{
    public class AuthData
    {
        public string TopNavigationHtml { get; set; }
        public bool IsAuthenticationSuccessful { get; set; }
        public bool AuthStatus { get; set; }
        public bool IsTermsAggred { get; set; }
    }
}