Create VIEW [dbo].[Search_Listing] with SCHEMABINDING  AS
SELECT     a.ID, CASE (VegOrNonVeg) WHEN 0 THEN 'Veg' WHEN 1 THEN 'NonVeg Non-Veg' END AS VegOrNonVeg, CASE (FreeHomedelivery) 
                      WHEN 0 THEN '' WHEN 1 THEN 'Free Home Delivery HomeDelivery home-delivery' END AS FreeHomedelivery, a.Address, a.Title, a.Ingredients, a.mainIngredient, a.Description, 
                      b.Name AS Recipe, c.Name AS Taste, CAST(a.Rating AS varchar(10)) + ' star rating' AS Rating, CASE (a.sideDishProvided) 
                      WHEN 1 THEN 'side dish side-dish' WHEN 0 THEN '' END AS SideDish, d.Name AS CuisineType, a.Cost
FROM         dbo.Listing AS a INNER JOIN
                      dbo.RecipeType AS b ON a.RecipeTypeID = b.ID INNER JOIN
                      dbo.Taste AS c ON a.TasteID = c.ID INNER JOIN
                      dbo.CuisineType AS d ON a.CuisineTypeID = d.ID
 
GO
 
create unique clustered index  Search_Listing_Index on Search_Listing(ID)

CREATE FULLTEXT INDEX ON [dbo].[Search_Listing](
[Address] LANGUAGE [English], 
[CuisineType] LANGUAGE [English], 
[Description] LANGUAGE [English], 
[FreeHomedelivery] LANGUAGE [English], 
[Ingredients] LANGUAGE [English], 
[MainIngredient] LANGUAGE [English], 
[Rating] LANGUAGE [English], 
[Recipe] LANGUAGE [English], 
[SideDish] LANGUAGE [English], 
[Taste] LANGUAGE [English], 
[Title] LANGUAGE [English], 
[VegOrNonVeg] LANGUAGE [English])
KEY INDEX [Search_Listing_Index]ON [Search_Listings_Catalog]

