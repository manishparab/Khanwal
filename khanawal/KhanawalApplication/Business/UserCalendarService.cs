using System;
using System.Collections.Generic;
using KhanawalApplication.Entity;
using System.Linq;

namespace KhanawalApplication.Business
{
    /// <summary>
    /// Summary description for UserCalendar
    /// </summary>
    public class UserCalendarService
    {
        private string _userBusy = "UserBusy";
        private string _userAvailable = "UserAvailable";
        private string _pastDate = "PastDate";
        private KhanaWalEntities context = null;
        private UserCalendar userCalendar = null;
        public UserCalendarService()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public int UpdateUserCalendar(List<UserCalendarEnity> userCalendarEnity, int userId)
        {
            List<UserCalendar> listUserCalendar = new List<UserCalendar>();

            foreach (UserCalendarEnity objuserCalendarEnity in userCalendarEnity)
            {
                var entryAlreadypresent =
                    listUserCalendar.Where(a => a.BusyDate.Day == int.Parse(objuserCalendarEnity.CalendarDate)).ToList();
                if (entryAlreadypresent.Any())
                {
                    var alreadyPresentEntry = entryAlreadypresent.First();
                    if (!string.IsNullOrEmpty(objuserCalendarEnity.StatusLowerHalf))
                    {
                        alreadyPresentEntry.SecondHalf = objuserCalendarEnity.StatusLowerHalf == "busy";
                    }
                    if (!string.IsNullOrEmpty(objuserCalendarEnity.StatusfirstHalf))
                    {
                        alreadyPresentEntry.FirstHalf = objuserCalendarEnity.StatusfirstHalf == "busy";
                    }
                }
                else
                {
                    userCalendar = new UserCalendar();
                    userCalendar.BusyDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, int.Parse(objuserCalendarEnity.CalendarDate)).Date;
                    userCalendar.UserId = userId;
                    if (!string.IsNullOrEmpty(objuserCalendarEnity.StatusfirstHalf))
                    {
                        userCalendar.FirstHalf = objuserCalendarEnity.StatusfirstHalf == "busy";
                    }
                    if (!string.IsNullOrEmpty(objuserCalendarEnity.StatusLowerHalf))
                    {
                        userCalendar.SecondHalf = objuserCalendarEnity.StatusLowerHalf == "busy";
                    }
                    listUserCalendar.Add(userCalendar);
                }

            }

            context = new KhanaWalEntities();
            var userCalendarListing = context.UserCalendars.Where(a => a.UserId == userId).ToList();


            foreach (UserCalendar objuserCalendar in listUserCalendar)
            {
                var userCalendarDays = userCalendarListing.Where(a => a.BusyDate == objuserCalendar.BusyDate).ToList();
                if (userCalendarDays.Any())
                {
                    var userCalendarDay = userCalendarDays.First();
                    if (objuserCalendar.FirstHalf.HasValue)
                    {
                        userCalendarDay.FirstHalf =  objuserCalendar.FirstHalf.Value;
                    }
                    
                    if (objuserCalendar.SecondHalf.HasValue)
                    {
                        userCalendarDay.SecondHalf =  objuserCalendar.SecondHalf.Value;
                    }
                    
                }
                else
                {
                    if (!objuserCalendar.FirstHalf.HasValue)
                    {
                        objuserCalendar.FirstHalf = false;
                    }

                    if (!objuserCalendar.SecondHalf.HasValue)
                    {
                        objuserCalendar.SecondHalf = false;
                    }
                    context.UserCalendars.AddObject(objuserCalendar);
                }

            }

            return context.SaveChanges();
        }

        public List<UserCalendarEnity> GetUserCalendarForCurrentMonth(int userId)
        {

            context = new KhanaWalEntities();
            var objCurrentUserAvailabily = context.UserCalendars.Where(a => a.UserId == userId && a.BusyDate.Month == DateTime.Now.Month).ToList();
            List<Entity.UserCalendarEnity> userCalendars = new List<Entity.UserCalendarEnity>();
            Entity.UserCalendarEnity userCalendar = null;
            int monthInDays = DateTime.DaysInMonth(DateTime.Now.Year, DateTime.Now.Month);
            int currentDays = DateTime.Now.Day - 1;
            for (int i = 0; i < 35; i++)
            {
                userCalendar = new Entity.UserCalendarEnity();
                if (i < currentDays)
                {
                    userCalendar.StatusfirstHalf = _pastDate;
                    userCalendar.StatusLowerHalf = _pastDate;
                }
                else
                {
                    if (i < monthInDays)
                    {
                        var checkAvailability = objCurrentUserAvailabily.Where(a => a.BusyDate.Day == i + 1).ToList();
                        if (checkAvailability.Any())
                        {
                            var userAvailability = checkAvailability.First();
                            if (userAvailability.FirstHalf.HasValue)
                            {
                                userCalendar.StatusfirstHalf = userAvailability.FirstHalf.Value
                                                                   ? _userBusy
                                                                   : _userAvailable;
                            }
                            if (userAvailability.SecondHalf.HasValue)
                            {
                                userCalendar.StatusLowerHalf = userAvailability.SecondHalf.Value
                                                                ? _userBusy
                                                                : _userAvailable;
                            }

                        }
                        else
                        {
                            userCalendar.StatusLowerHalf = userCalendar.StatusfirstHalf = _userAvailable;
                        }
                    }

                }
                userCalendar.CalendarDate = i < monthInDays ? (i + 1).ToString() : String.Empty;
                userCalendars.Add(userCalendar);
            }
            return userCalendars;
        }
    }
}