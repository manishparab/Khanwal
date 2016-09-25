using System.Collections.Generic;
using System.Linq;
using KhanawalApplication;

namespace KhanawalApplication.Business
{
    /// <summary>
    /// Summary description for SideListing
    /// </summary>
    public class SideListingService
    {
        private KhanaWalEntities context;
        public SideListingService()
        {
            context =  new KhanaWalEntities();
            //
            // TODO: Add constructor logic here
            //
        }

        public int AddSideListing(SideListing sideListing)
        {

            context.SideListings.AddObject(sideListing);
            context.SaveChanges();
            return default(int);


        }

       
        public List<SideListing> GetSideListings()
        {
            List<SideListing> sideListings = new List<SideListing>();

            sideListings = context.SideListings.ToList();

            return sideListings;
        }
    }
}