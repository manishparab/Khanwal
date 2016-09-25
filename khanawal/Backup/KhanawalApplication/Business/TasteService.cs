using System.Collections.Generic;

using System.Linq;
using KhanawalApplication;

namespace KhanawalApplication.Business
{
    /// <summary>
    /// Summary description for TasteService
    /// </summary>
    public class TasteService
    {
        public TasteService()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public List<Taste> GetTastes()
        {
            KhanaWalEntities context =  new KhanaWalEntities();

            return context.Tastes.ToList();
        }
    }
}