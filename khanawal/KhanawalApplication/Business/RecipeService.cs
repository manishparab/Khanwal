using System.Collections.Generic;
using System.Linq;
using KhanawalApplication;

namespace KhanawalApplication.Business
{
    /// <summary>
    /// Summary description for RecipeService
    /// </summary>
    public class RecipeService
    {
        public RecipeService()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public List<RecipeType> GetRecipeType()
        {
            KhanaWalEntities context =  new KhanaWalEntities();
            return context.RecipeTypes.OrderBy(a=>a.Name).ToList();
        }
    }
}