using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace KhanawalApplication.Business
{
    public class StateService
    {
        private KhanaWalEntities context;
        public List<State> GetStates()
        {
            context =  new KhanaWalEntities();
           return context.States.OrderBy(a=>a.Name).ToList();
        }
    }
}