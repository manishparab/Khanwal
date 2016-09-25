using System.IO;

namespace KhanawalApplication.IO
{
    /// <summary>
    /// Summary description for Common
    /// </summary>
    public class Common
    {
        public Common()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public static string ReadFileFromDisk(string filePath)
        {
            return File.ReadAllText(filePath);
        }

    }
}