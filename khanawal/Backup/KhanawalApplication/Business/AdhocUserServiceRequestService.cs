using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace KhanawalApplication.Business
{
    public class AdhocUserServiceRequestService
    {
        private KhanaWalEntities context;
        public int CreateNewAdhocUserRequest(List<int> selectedUserId, string dishName, List<AdHocRequestTasteMapping> tastes, DateTime deliveryTime, string sideDishes, string ingredientsToavoide, bool? isVeg, float? cost, string additionalInformation, int currentUserId, AdHocRequestPickupLocation adHocRequestPickupLocation, bool? homeDelivery, int? peopleCount)
        {
            int returnValue;
            context = new KhanaWalEntities();
            AdHocRequest request = new AdHocRequest();
            request.SideDishesWanted = sideDishes;
            request.Title = dishName;
            request.IsVeg = isVeg;
            request.IsNonVeg = !isVeg;
            request.Cost = cost;
            request.AdditionalInformaition = additionalInformation;
            request.DeliveryTime = deliveryTime;
            request.IngredientsToAvoide = ingredientsToavoide;
            request.HomeDelivery = homeDelivery;
            //request.TasteId = tasteId;
            request.UserId = currentUserId;
            request.IsOpen = true;
            request.PersonCount = peopleCount;
            
            context.AdHocRequests.AddObject(request);
            context.SaveChanges();

            foreach (var selectedUser in selectedUserId)
            {
                request.AdHocRequestUserMappings.Add(new AdHocRequestUserMapping() { UserId = selectedUser, AdhocRequestId = request.Id });
            }
            

            foreach (AdHocRequestTasteMapping item in tastes)
            {
                item.RequestID = request.Id;
                request.AdHocRequestTasteMappings.Add(item);
            }

            if (homeDelivery.HasValue)
            {
                if (!homeDelivery.Value && adHocRequestPickupLocation !=  null)
                {
                    adHocRequestPickupLocation.AdHocRequestId = request.Id;
                    request.AdHocRequestPickupLocations.Add(adHocRequestPickupLocation);
                }
            }

            returnValue = context.SaveChanges();

            context.Dispose();
            return returnValue;
        }

        public DateTime GetServerAdjustedTime(DateTime dateTime)
        {
           return TimeZoneInfo.ConvertTime(dateTime, TimeZoneInfo.Local);
        }

        public AdHocRequest GetAdHocRequestById(int requestId)
        {
            context = new KhanaWalEntities();
            AdHocRequest adHocRequest = null;
            var adHocRequests = context.AdHocRequests.Include("User").Include("AdHocRequestUserMappings").Include("AdHocRequestPickupLocations").Include("AdHocRequestTasteMappings").Where(a => a.Id== requestId).ToList();
            if (adHocRequests.Any())
            {
                adHocRequest = adHocRequests.First();
            }
            return adHocRequest;
        }

        public List<AdHocRequest> GetAdHocRequests()
        {
            context =  new KhanaWalEntities();
            return context.AdHocRequests.Include("User").Include("AdHocRequestUserMappings").ToList().Where(a => GetServerAdjustedTime(a.DeliveryTime) > DateTime.Now && a.IsOpen).ToList();
        }
    }
}