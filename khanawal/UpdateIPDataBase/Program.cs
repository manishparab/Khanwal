using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace UpdateIPDataBase
{
    class Program
    {
        static void Main(string[] args)
        {
            var lines = File.ReadAllLines("GeoIPCountryWhois.csv").Select(a => a.Split(';'));
            var csv = from line in lines
                      select (from piece in line
                              select piece.Split(',')).ToArray();
            var context = new khanawalEntities();
            int counter = 0;
            foreach (var item in csv)
            {
                counter = counter + 1;
                Console.WriteLine(counter.ToString());
                context.AddToCoutryIpMappings(new CoutryIpMapping()
                {
                    IpFrom = item[0][0].Replace(@"""", @""),
                    IpTo = item[0][1].Replace(@"""", @""),
                    IpFromRange = item[0][2].Replace(@"""", @""),
                    IpToRange = item[0][3].Replace(@"""", @""),
                    CountryShortName = item[0][4].Replace(@"""", @""),
                    CountryName = item[0][5].Replace(@"""", @"")
                });
                if (counter % 100 == 0)
                {
                    context.SaveChanges();
                }
                
            }
           
        }
    }
}
