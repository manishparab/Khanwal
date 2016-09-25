// -----------------------------------------------------------------------
// <copyright file="UpDateCurrency.cs" company="">
// TODO: Update copyright text.
// </copyright>
// -----------------------------------------------------------------------

namespace CurrencyUpdater
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Xml.Linq;

    /// <summary>
    /// TODO: Update summary.
    /// </summary>
    public class UpDateCurrency
    {
        public void UpdateCurrency()
        {
            string address = "http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml";

            XDocument doc = XDocument.Load(address);

            XNamespace ns = "http://www.ecb.int/vocabulary/2002-08-01/eurofxref";

            var currencies = doc.Descendants(ns + "Cube").Where(c => c.Attribute("currency") != null)
                                .Select(c => new CurrencyType
                                {
                                    Name = (string)c.Attribute("currency"),
                                    Value = (decimal)c.Attribute("rate")
                                })
                                .ToList();

            KhanawalEntities khanawal = new KhanawalEntities();
            var currencyTypes = khanawal.CurrencyTypes.ToList();

            foreach (var CurrencyType in currencies)
            {
                var curr = currencyTypes.Where(a => a.Name == CurrencyType.Name);
                if (curr.Any())
                {
                    curr.First().Value = CurrencyType.Value;

                }
                else
                {
                    khanawal.AddToCurrencyTypes((new CurrencyType() { Name = CurrencyType.Name, Value = CurrencyType.Value }));
                }
            }



            khanawal.SaveChanges();
        }
    }
}
