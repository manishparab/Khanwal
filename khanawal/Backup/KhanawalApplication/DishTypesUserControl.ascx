<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DishTypesUserControl.ascx.cs"
    Inherits="KhanawalApplication.DishTypesUserControl" %>
<style type="text/css">
    .subListingImageRecipeType
    {
        height: 223px !important;
        width: 250px;
    }
    .captionCenter
    {
        bottom: 0px !important;
        position: absolute;
        margin-left: 80px;
        margin-bottom: 100px;
        color:white;
        font-weight: bold;
        font-size: 22px !important;
    }
</style>
<div class="row">
    <div class="span4">
        <div class="wrapper">
            <a href='Listings.aspx?recipeId=1'>
                <img class="subListingImageRecipeType" alt="" src="img/RecipeTypes/breakfast.jpg" />
                <div class="captionCenter">
                    BreakFast
                    <br />
                </div>
            </a>
        </div>
    </div>
    <div class="span4">
        <div class="wrapper">
            <a href='Listings.aspx?recipeId=11'>
                <img class="subListingImageRecipeType" alt="" src="img/RecipeTypes/snacks.jpg" />
                <div class="captionCenter">
                    snacks
                    <br />
                </div>
            </a>
        </div>
    </div>
    <div class="span4">
        <div class="wrapper">
            <a href='Listings.aspx?recipeId=7'>
                <img class="subListingImageRecipeType" alt="" src="img/RecipeTypes/lunch.jpg" />
                <div class="captionCenter">
                    lunch  &<br/> Dinner
                    <br />
                </div>
            </a>
        </div>
    </div>
</div>
<div class="row">
    <div class="span4">
        <div class="wrapper">
            <a href='Listings.aspx?recipeId=10'>
                <img class="subListingImageRecipeType" alt="" src="img/RecipeTypes/soup.jpg" />
                <div class="captionCenter">
                    Soups
                    <br />
                </div>
            </a>
        </div>
    </div>
    <div class="span4">
        <div class="wrapper">
            <a href='Listings.aspx?recipeId=5'>
                <img class="subListingImageRecipeType" alt="" src="img/RecipeTypes/desert.jpg" />
                <div class="captionCenter">
                    Desert
                    <br />
                </div>
            </a>
        </div>
    </div>
    <div class="span4">
        <div class="wrapper">
            <a href='Listings.aspx?recipeId=9'>
                <img class="subListingImageRecipeType" alt="" src="img/RecipeTypes/biryani.jpg" />
                <div class="captionCenter">
                    biryani & <br/> pulao
                    <br />
                </div>
            </a>
        </div>
    </div>
</div>
