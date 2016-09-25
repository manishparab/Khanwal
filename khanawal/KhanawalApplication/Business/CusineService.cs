using System.Collections.Generic;
using System.Linq;
using KhanawalApplication;

namespace KhanawalApplication.Business
{
    /// <summary>
    /// Summary description for CusineService
    /// </summary>
    public class CusineService
    {
        public CusineService()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public List<CuisineType> GetCuisine()
        {
            var context =  new KhanaWalEntities();
            return  context.CuisineTypes.OrderBy(a=>a.Name).ToList();
        }
    }
}