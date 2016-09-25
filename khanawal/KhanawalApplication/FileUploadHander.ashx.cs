using System;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using KhanawalApplication.Business;

namespace KhanawalApplication
{
    /// <summary>
    /// Summary description for FileUploadHander
    /// </summary>
    public class FileUploadHander : IHttpHandler
    {
        private readonly JavaScriptSerializer js = new JavaScriptSerializer();

        public string StorageRoot
        {
            get { return ConfigurationManager.AppSettings["StorageRoot"]; }
        }
        public bool IsReusable { get { return false; } }

        public void ProcessRequest(HttpContext context)
        {
            context.Response.AddHeader("Pragma", "no-cache");

            context.Response.AddHeader("Cache-Control", "private, no-cache");

            HandleMethod(context);


        }

        // Handle request based on method
        private void HandleMethod(HttpContext context)
        {
            //FunctionsErrorLog.LogMessage("HandleMethod");
            switch (context.Request.HttpMethod)
            {
                case "HEAD":
                case "GET":
                    if (GivenFilename(context)) DeliverFile(context);
                    //else ListCurrentFiles(context);
                    break;

                case "POST":
                case "PUT":
                    UploadFile(context);
                    break;

                case "DELETE":
                    DeleteFile(context);
                    break;

                case "OPTIONS":
                    ReturnOptions(context);
                    break;

                default:
                    context.Response.ClearHeaders();
                    context.Response.StatusCode = 405;
                    break;
            }
        }

        private static void ReturnOptions(HttpContext context)
        {
            context.Response.AddHeader("Allow", "DELETE,GET,HEAD,POST,PUT,OPTIONS");
            context.Response.StatusCode = 200;
        }

        // Delete file from the server
        private void DeleteFile(HttpContext context)
        {

            var filePath = HttpRuntime.AppDomainAppPath + context.Request["f"];

            if (File.Exists(filePath))
            {
                File.Delete(filePath);
            }

            var pictureListingId = context.Request["listingPictureID"].ToString();
            if (!string.IsNullOrEmpty(pictureListingId))
            {
                ListingService service = new ListingService();
                if (service.DeleteListingPicture(Convert.ToInt32(pictureListingId)) > 0)
                {
                    WriteJsonIframeSafe(context, new DeleteStatus(true));
                }

            }
        }

        // Upload file to the server
        private void UploadFile(HttpContext context)
        {
            var statuses = new List<files>();
            var headers = context.Request.Headers;

            if (string.IsNullOrEmpty(headers["X-File-Name"]))
            {
                UploadWholeFile(context, statuses);
            }
            else
            {
                UploadPartialFile(headers["X-File-Name"], context, statuses);
            }

            WriteJsonIframeSafe(context, statuses);

        }

        // Upload partial file
        private void UploadPartialFile(string fileName, HttpContext context, List<files> statuses)
        {
            if (context.Request.Files.Count != 1) throw new HttpRequestValidationException("Attempt to upload chunked file containing more than one fragment per request");
            var inputStream = context.Request.Files[0].InputStream;
            var fullName = StorageRoot + Path.GetFileName(fileName);

            using (var fs = new FileStream(fullName, FileMode.Append, FileAccess.Write))
            {
                var buffer = new byte[1024];

                var l = inputStream.Read(buffer, 0, 1024);
                while (l > 0)
                {
                    fs.Write(buffer, 0, l);
                    l = inputStream.Read(buffer, 0, 1024);
                }
                fs.Flush();
                fs.Close();
            }
            //statuses.Add(new files(new FileInfo(fullName)));
        }


        public static void GenerateImageThumbnail(Stream streamImage, string sThumbnailImagePath, int nMaxWidth, int nMaxHeight, string savePath)
        {
            Image oImage = Image.FromStream(streamImage);
            GenerateImageThumbnail(oImage, sThumbnailImagePath, nMaxWidth, nMaxHeight);

        }


        public static void GenerateImageThumbnail(Image oImage, string sThumbnailImagePath, int nMaxWidth, int nMaxHeight)
        {

            float fRatio = 1;
            int nWidth = oImage.Width;
            int nHeight = oImage.Height;


            //calculate the thumb image size if needed

            if (oImage.Width > nMaxWidth || oImage.Height > nMaxHeight)
            {
                if (oImage.Width >= oImage.Height)
                {

                    fRatio = ((float)oImage.Height) / ((float)oImage.Width);
                    nWidth = nMaxWidth;
                    nHeight = Convert.ToInt32(nMaxHeight * fRatio);
                }

                else
                {
                    fRatio = ((float)oImage.Width) / ((float)oImage.Height);
                    nWidth = Convert.ToInt32(nMaxWidth * fRatio);
                    nHeight = nMaxHeight;
                }

            }


            //create the thumbnail ans set it’s settings

            Image oThumbnail = new Bitmap(nWidth, nHeight);

            Graphics oGraphic = Graphics.FromImage(oThumbnail);


            oGraphic.InterpolationMode = InterpolationMode.HighQualityBicubic;

            oGraphic.SmoothingMode = SmoothingMode.HighQuality;

            oGraphic.PixelOffsetMode = PixelOffsetMode.HighQuality;

            oGraphic.CompositingQuality = CompositingQuality.HighQuality;


            oGraphic.DrawImage(oImage, 0, 0, nWidth, nHeight);


            //save the thumbnail

            ImageCodecInfo[] iciInfo = ImageCodecInfo.GetImageEncoders();

            EncoderParameters encoderParameters;

            encoderParameters = new EncoderParameters(1);

            encoderParameters.Param[0] = new EncoderParameter(Encoder.Quality, 100L);

            oThumbnail.Save(sThumbnailImagePath, iciInfo[1], encoderParameters);


            if (oThumbnail != null) { oThumbnail.Dispose(); }

        }

        // Upload entire file
        private void UploadWholeFile(HttpContext context, List<files> statuses)
        {
            // check if the path exists for the current listing
            // if directory does not exist then create one.
            string listingId = HttpContext.Current.Request.QueryString["Id"];
            string listingIoPath = HttpRuntime.AppDomainAppPath + StorageRoot + listingId;
            string listingurlPath = StorageRoot + listingId;

            try
            {

                //FunctionsErrorLog.LogMessage("UploadWholeFile");

                if (!System.IO.Directory.Exists(listingIoPath))
                {
                    System.IO.Directory.CreateDirectory(listingIoPath);
                }

                //get all the files in the same directory, because we need to check if
                // duplicate files are being uploaded.
                var currentDirectoryfiles =
                   new DirectoryInfo(listingIoPath)
                       .GetFiles("*", SearchOption.TopDirectoryOnly)
                       .Where(f => !f.Attributes.HasFlag(FileAttributes.Hidden))
                       .Select(f => new files(f.Name))
                       .ToArray();

                for (int i = 0; i < context.Request.Files.Count; i++)
                {
                    var file = context.Request.Files[i];
                    var savePath = listingIoPath + @"\" + Path.GetFileName(file.FileName);

                    if (currentDirectoryfiles.Any(f => f.name.ToLower() == Path.GetFileName(file.FileName).ToLower()))
                    {
                        files objFiles = new files();
                        objFiles.error = "File with same name already exists for this listing";
                        statuses.Add(objFiles);
                    }
                    else
                    {
                        Image sourceImage = Image.FromStream(file.InputStream);
                        int imageHeight, imageWidth;

                        if (sourceImage.Width >= 1600)
                        {
                            imageWidth = 1600;
                            imageHeight = 700;
                        }
                        else if (sourceImage.Width > 650)
                        {
                            imageWidth = 650;
                            imageHeight = 430;
                        }
                        else
                        {
                            imageWidth = sourceImage.Width;
                            imageHeight = sourceImage.Height;
                        }


                        if (file.ContentLength > 100)
                        {
                            GenerateImageThumbnail(sourceImage, savePath, imageWidth, imageHeight);
                        }
                        else
                        {
                            file.SaveAs(savePath);
                        }

                        listingurlPath = listingurlPath + @"\" + Path.GetFileName(file.FileName);
                        listingurlPath = listingurlPath.Replace(@"\", @"/");
                        string fullName = Path.GetFileName(file.FileName);

                        ListingService service = new ListingService();
                        savePath = savePath.Replace("\\\\","\\");
                        int listingPictureId = service.AddListingPicture(Convert.ToInt32(listingId), savePath, listingurlPath);

                        statuses.Add(new files(fullName, listingurlPath, file.ContentLength, listingPictureId));
                    }

                }
            }
            catch (Exception exception)
            {
                files objFiles = new files();
                objFiles.error = exception.Message + exception.StackTrace;
                statuses.Add(objFiles);
            }
        }

        private void WriteJsonIframeSafe(HttpContext context, DeleteStatus deleteStatus)
        {
            context.Response.AddHeader("Vary", "Accept");
            try
            {
                if (context.Request["HTTP_ACCEPT"].Contains("application/json"))
                    context.Response.ContentType = "application/json";
                else
                    context.Response.ContentType = "text/plain";
            }
            catch
            {
                context.Response.ContentType = "text/plain";
            }



            var jsonObj = js.Serialize(deleteStatus);
            context.Response.Write(jsonObj);
        }

        private void WriteJsonIframeSafe(HttpContext context, List<files> statuses)
        {
            context.Response.AddHeader("Vary", "Accept");
            try
            {
                if (context.Request["HTTP_ACCEPT"].Contains("application/json"))
                    context.Response.ContentType = "application/json";
                else
                    context.Response.ContentType = "text/plain";
            }
            catch
            {
                context.Response.ContentType = "text/plain";
            }

            CustomFileCollection customFileCollection = new CustomFileCollection();
            customFileCollection.files = statuses;
            //var test = statuses.ToArray();

            var jsonObj = js.Serialize(customFileCollection);
            context.Response.Write(jsonObj);
        }

        private static bool GivenFilename(HttpContext context)
        {
            return !string.IsNullOrEmpty(context.Request["f"]);
        }

        private void DeliverFile(HttpContext context)
        {
            var filename = context.Request["f"];
            var filePath = StorageRoot + filename;

            if (File.Exists(filePath))
            {
                context.Response.AddHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
                context.Response.ContentType = "application/octet-stream";
                context.Response.ClearContent();
                context.Response.WriteFile(filePath);
            }
            else
                context.Response.StatusCode = 404;
        }

        //private void ListCurrentFiles(HttpContext context)
        //{
        //    var files =
        //        new DirectoryInfo(StorageRoot)
        //            .GetFiles("*", SearchOption.TopDirectoryOnly)
        //            .Where(f => !f.Attributes.HasFlag(FileAttributes.Hidden))
        //            .Select(f => new files(f))
        //            .ToArray();

        //    string jsonObj = js.Serialize(files);
        //    context.Response.AddHeader("Content-Disposition", "inline; filename=\"files.json\"");
        //    context.Response.Write(jsonObj);
        //    context.Response.ContentType = "application/json";
        //}

    }
}