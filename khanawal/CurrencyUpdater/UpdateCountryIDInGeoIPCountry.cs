// -----------------------------------------------------------------------
// <copyright file="UpdateCountryIDInGeoIPCountry.cs" company="">
// TODO: Update copyright text.
// </copyright>
// -----------------------------------------------------------------------

namespace CurrencyUpdater
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;

    /// <summary>
    /// TODO: Update summary.
    /// </summary>
    public class UpdateCountryIDInGeoIPCountry
    {
        public void UpdateContryId()
        {
            KhanawalEntities context = new KhanawalEntities();
            
            List<Country> countries = context.Countries.ToList();

            foreach (Country item in countries)
            {
                Console.WriteLine(item.Name);
                var selectedCountry = context.GeoIPCountries.Where(a => a.CountryName.ToLower() == item.Name.ToLower()).ToList();
                if (selectedCountry.Any())
                {
                    Console.WriteLine("Updating " + item.Name);
                    foreach (var item1 in selectedCountry)
                    {
                        item1.CountryID = item.ID;    
                    }
                    
                    context.SaveChanges();
                }
            }

           

        }
    }
}
