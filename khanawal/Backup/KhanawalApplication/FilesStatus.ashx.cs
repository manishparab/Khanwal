using System.Collections.Generic;
using System.IO;

namespace KhanawalApplication
{

    public class DeleteStatus
    {
        public DeleteStatus()
        {

        }
        public DeleteStatus(bool deleteStatus)
        {
            this.Successful = deleteStatus;
        }
        public bool Successful { get; set; }
        public string ErrorMessgage { get; set; }
    }
    public class CustomFileCollection
    {
        public List<files> files { get; set; }
    }
    public class files
    {
        public const string HandlerPath = "/";

        public string group { get; set; }
        public string name { get; set; }
        public string type { get; set; }
        public int size { get; set; }
        public string progress { get; set; }
        public string url { get; set; }
        public string thumbnail_url { get; set; }
        public string delete_url { get; set; }
        public string delete_type { get; set; }
        public string error { get; set; }

        public files() { }


        public files(string filename)
        {
            this.name = filename;
        }
        public files(string fileName, string listingurl, int fileLength, int listingPictureId) { SetValues(fileName, listingurl, fileLength, listingPictureId); }



        private void SetValues(string fileName, string listingurl, int fileLength, int listingPictureId)
        {
            name = fileName;
            type = "image/png";
            size = fileLength;
            progress = "1.0";
            url = listingurl;
            thumbnail_url = listingurl;
            delete_url = HandlerPath + "FileUploadHander.ashx?f=" + listingurl + "&listingPictureID=" + listingPictureId;
            delete_type = "DELETE";
        }
    }
}