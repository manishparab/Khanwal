using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using KhanawalApplication;
using KhanawalApplication.Entity;

namespace KhanawalApplication.Business
{
    /// <summary>
    /// Summary description for ingredients
    /// </summary>
    public class IngredientsService
    {
        
        public IngredientsService()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public List<Ingredient> GetSubIngredients()
        {
            KhanaWalEntities context = new KhanaWalEntities();

            return context.Ingredients.Where(a => a.Validated == true).ToList();
        }

        public List<ListingIngredient> GetListingSubIngredients(int listingId)
        {
           KhanaWalEntities context = new KhanaWalEntities();
           return context.ListingIngredients.Where(a => a.ListingId == listingId && !a.IsMainIngredient).ToList();
        }

        //public List<int> EnsureIngredients(string ingredientName, int mainListingId, bool isMainIngredient)
        //{

        //    KhanaWalEntities context = new KhanaWalEntities();
        //    int listingId = 0;
        //    List<int> ingredientIds = new List<int>();

        //    List<string> uIIngredients = ingredientName.Split(new char[] { '$' }, StringSplitOptions.RemoveEmptyEntries).ToList();

        //    // Add To lisiting table with the sidelisting as true and at the same time add it to the the side listings-listing 
        //    //relation.

        //    List<Ingredient> ingredients = context.Ingredients.ToList();

        //    //SideListing listing;
        //    StringBuilder ingredientWithDescription =  new StringBuilder();

        //    // delete exisiting ingredients
        //    if (!isMainIngredient)
        //    {
        //        context.ListingIngredients.Where(a => a.ListingId == mainListingId && !a.IsMainIngredient).ToList().ForEach(a => context.ListingIngredients.DeleteObject(a));    
        //    }
        //    {
        //        context.ListingIngredients.Where(a => a.ListingId == mainListingId && a.IsMainIngredient).ToList().ForEach(a => context.ListingIngredients.DeleteObject(a));    
        //    }

        //    context.SaveChanges();

        //    foreach (string ingredient in uIIngredients)
        //    {
        //        var ingredientValues =
        //            ingredient.Split(new char[] { '|' }, StringSplitOptions.RemoveEmptyEntries).ToList();

        //        var selectedIngredient = ingredients.Where(a => a.Name.ToLower() == ingredientValues[0].ToLower()).ToList();
        //        //ingredientWithDescription.Append(ingredientValues[0] + string.Empty + ingredientValues[2]);
        //        Ingredient objIngredient;

        //        if (!selectedIngredient.Any())
        //        {
        //            objIngredient = new Ingredient();
        //            objIngredient.Name = ingredientValues[0];
        //            objIngredient.Description = ingredientValues[2];
        //            context.Ingredients.AddObject(objIngredient);
        //            context.SaveChanges();   

        //        }
        //        else
        //        {
        //            objIngredient = selectedIngredient.First();
        //        }

        //        listingId = objIngredient.ID;
        //        ingredientIds.Add(listingId);
                
        //        context.ListingIngredients.AddObject(new ListingIngredient() { ListingId = mainListingId, IngredientId = objIngredient.ID, IsMainIngredient = isMainIngredient });
                
        //        // we need to update the ingredients with the main ingredient as well as the sub ingredients.    
        //        context.SaveChanges();    
        //    }

        //    // we save this ingredients because 
        //    var listing = context.Listings.First(a => a.ID == mainListingId);

        //    if (isMainIngredient)
        //    {
        //        listing.MainIngredientID = listingId;
        //    }

        //    // find the listing description
        //    // find all the listings

        //   var lsitingIngredients =  context.ListingIngredients.Include(Common.DbTables.Ingredient).Where(a => a.ListingId == mainListingId);

        //    foreach (var listingIngredient in lsitingIngredients)
        //    {
        //        ingredientWithDescription.Append(listingIngredient.Ingredient.Name + string.Empty +
        //                                         listingIngredient.Ingredient.Description);
        //    }

        //    listing.Ingredients = ingredientWithDescription.ToString();

        //    context.SaveChanges();

        //    return ingredientIds;

        //}

        public int EnsureMainIngredint(int listingId , int ingredientId )
        {
            var context = new KhanaWalEntities();

            var listingIngredient =  new ListingIngredient
                                                       {
                                                           IngredientId = ingredientId,
                                                           IsMainIngredient = true,
                                                           ListingId = listingId
                                                       };

            context.ListingIngredients.AddObject(listingIngredient);
        
            context.SaveChanges();
            return listingIngredient.ID;
        }
    }
}