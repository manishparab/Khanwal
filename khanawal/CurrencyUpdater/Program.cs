using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.IO;
using System.Xml.Linq;

namespace CurrencyUpdater
{
    class Program
    {
        static void Main(string[] args)
        {

            //UpDateCurrency upDateCurrency = new UpDateCurrency();
            //upDateCurrency.UpdateCurrency();

            //UpdateCountryCurrencyRefarance currRef = new UpdateCountryCurrencyRefarance();
            //currRef.UpdateCountryCurrRef();

            UpdateCountryIDInGeoIPCountry updateCountryIDInGeoIPCountry = new UpdateCountryIDInGeoIPCountry();
            updateCountryIDInGeoIPCountry.UpdateContryId();


        }
    }
}
