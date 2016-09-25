using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace KhanawalApplication.Business
{
    public class CountryService
    {
        private KhanaWalEntities context;

        public List<Country> GetCountries()
        {
            context = new KhanaWalEntities();
            return context.Countries.ToList();
        }
    }
}