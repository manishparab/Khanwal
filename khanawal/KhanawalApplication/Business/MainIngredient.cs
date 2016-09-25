using System.Linq;
using KhanawalApplication;
using KhanawalApplication;

namespace KhanawalApplication.Business
{
    public class MainIngredient
    {
        public MainIngredient()
        {
            //
            // TODO: Add constructor logic here
            //
        }

     

        public int EnsureEngredient(string ingredientName)
        {
            KhanaWalEntities context = new KhanaWalEntities();
            Ingredient ingredient = null;

            var ingredients = context.Ingredients.Where(a => a.Name.ToLower() == ingredientName.ToLower());

            if (ingredients.Any())
            {
                ingredient = ingredients.First();
            }
            else
            {
                ingredient = new Ingredient { Name = ingredientName };
                context.Ingredients.AddObject(ingredient);
                context.SaveChanges();
            }

            return ingredient != null ? ingredient.ID : -1;
        }
    }

}