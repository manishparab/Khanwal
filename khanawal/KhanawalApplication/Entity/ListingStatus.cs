using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace KhanawalApplication.Entity
{
    public class ListingStatus
    {
        public bool TitleAndDescription { get; set; }
        public bool CategoryAndIngredients { get; set; }
        public bool Photos { get; set; }
        public bool LocationAndPricing { get; set; }
        public bool AdditionalDetails { get; set; }
        public bool ValidstionStatus { get; set; }
    }
}