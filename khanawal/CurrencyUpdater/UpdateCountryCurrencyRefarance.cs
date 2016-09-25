// -----------------------------------------------------------------------
// <copyright file="UpdateCountryCurrencyRefarance.cs" company="">
// TODO: Update copyright text.
// </copyright>
// -----------------------------------------------------------------------

namespace CurrencyUpdater
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.IO;

    /// <summary>
    /// TODO: Update summary.
    /// </summary>
    public class UpdateCountryCurrencyRefarance
    {
        public void UpdateCountryCurrRef()
        {
            var lines = File.ReadAllLines(@"C:\Manish\Currency.csv").Select(a => a.Split(';'));
            var csv = from line in lines
                      select (from piece in line
                              select piece.Split(',')).ToArray();
            KhanawalEntities context = new KhanawalEntities();
            List<Country> countries = context.Countries.ToList();
            List<CurrencyType> currencies = context.CurrencyTypes.ToList();
            foreach (var item in csv)
            {
                if (item[0].Length > 2)
                {
                    var currency = currencies.Where(a => a.Name.ToLower() == item[0][2].ToLower());
                    if (currency.Any())
                    {
                        context.AddToCountries(new Country()
                        {
                            Name = item[0][0],
                            Region = item[0][1],
                            CurrencyTypeId = currency.First().ID
                        });

                    }
                }

            }

            context.SaveChanges();
        }
    }
}
