using System;
using System.IO;
using System.Web;

namespace KhanawalApplication.Business
{
    public class FunctionsErrorLog
    {
        public static String AppErrorLogFileName = "ErrorLog.txt";

        /// <summary>
        /// Log any messages from the Application
        /// </summary>
        /// <param name="message"></param>
        public static void LogMessage(String pMessage)
        {
            bool Successful = false;

            string errorLogPath = HttpRuntime.AppDomainAppPath + @"\Logs\" + AppErrorLogFileName;

          
                try
                {
                    // Log message to default log file.
                    StreamWriter str = new StreamWriter
                    (errorLogPath, true);

                    str.AutoFlush = true;   // Wri9te text with no buffering
                    str.WriteLine("Time: " + DateTime.Now.ToString() +
                    Environment.NewLine
                        + "Message: " + pMessage);
                    str.Close();

                    Successful = true;
                }
                catch (Exception exception)
                {

                }

               
           
        }


      

        public static void LogMessage(Exception pExeption)
        {
            String str_inner = "";

            try
            {
                str_inner = Environment.NewLine +
                "Inner Exception Msg: " + pExeption.InnerException.Message +
                "Inner Exception Stack: " + pExeption.InnerException.StackTrace;
            }
            catch (Exception)
            {
            }

            LogMessage("Exception: " + pExeption.Message + Environment.NewLine +
                "Stack: " + str_inner);
        }
    } 
}