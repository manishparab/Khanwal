using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;

namespace KhanawalApplication.Entity
{
    public class TopNavigation 
    {
        public int Id { get; set; }
        public string MenuName { get; set; }
        public string MenuUrl { get; set; }
        public bool Active { get; set; }

       
    }
}