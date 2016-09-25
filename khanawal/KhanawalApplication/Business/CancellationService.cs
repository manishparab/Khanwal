using System.Collections.Generic;

namespace KhanawalApplication.Business
{
    /// <summary>
    /// Summary description for CancellationUserService
    /// </summary>
    public class CancellationService
    {
        public Dictionary<int, string> CancellationTypes { get; set; }
    

        public CancellationService()
        {
            Dictionary<int, string>  cancellationTypes =  new Dictionary<int, string>();
            cancellationTypes.Add(1, "Strict");
            cancellationTypes.Add(2, "Moderate");
            cancellationTypes.Add(3, "Easy");

            CancellationTypes = cancellationTypes;
            //
            // TODO: Add constructor logic here
            //
        }


    }
}