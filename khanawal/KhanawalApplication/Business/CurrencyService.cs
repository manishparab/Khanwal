using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace KhanawalApplication.Business
{
    public class CurrencyService
    {
        public List<CurrencyType> GetCurrency()
        {
            List<CurrencyType> currencyTypes =  null;
            KhanaWalEntities context = new KhanaWalEntities();
            currencyTypes = context.CurrencyTypes.OrderBy(a=>a.Name).ToList();
            return currencyTypes;
        }
    }
}