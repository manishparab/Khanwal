using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace KhanawalApplication.Business
{
    public class CityService
    {
        private KhanaWalEntities context;
        public List<City> GetCities()
        {
            context = new KhanaWalEntities();
            return context.Cities.OrderBy(a=>a.city_name).ToList();
        }
    }
}