using System;
using System.Web;
using System.Web.Services;
using KhanawalApplication.Business;
using KhanawalApplication.Entity;

namespace KhanawalApplication
{
    public partial class Home : ParentPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.LoadHeroSliderImages();
                this.SetDate();
              
            }

        }

        private void SetDate()
        {
            //this.dp3.Text = DateTime.Today.Date.ToString("dd-MM-yyyy");
        }

      
        private void LoadHeroSliderImages()
        {
            SliderImagesService sliderImagesService = new SliderImagesService();
            HeroImagesSliderRepeater.DataSource = sliderImagesService.GetListingPicturesForHeroSlider();
            HeroImagesSliderRepeater.DataBind();
        }
    }
}