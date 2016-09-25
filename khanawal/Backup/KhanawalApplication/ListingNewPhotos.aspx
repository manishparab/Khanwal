<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="ListingNewPhotos.aspx.cs"
    Inherits="KhanawalApplication.ListingNewPhotos" %>
    
<%@ Register Src="TopNavigationUserControl.ascx" TagName="TopNavigationUserControl"
    TagPrefix="ucTopNavigation" %>
<%@ Register Src="ManageListingPhotos.ascx" TagName="ManageListingPhotos" TagPrefix="ucManageListingPhotos" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
    <script src="js/vendor/bootstrap.min.js"></script>
    
    <script src="js/vendor/modernizr-2.6.1-respond-1.1.0.min.js"></script>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/Custom.css" rel="stylesheet" type="text/css" />
    <link href="themes/default/default.css" rel="stylesheet" type="text/css" />
    <link href="css/bootstrap-image-gallery.min.css" rel="stylesheet" type="text/css" />
    <link href="css/jquery.fileupload-ui.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" />
    <!--[if lt IE 9]>
    <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
  <![endif]-->
    <style>
        #sortable
        {
            list-style-type: none;
            margin: 0;
            padding: 0;
            width: 650px;
        }
        #sortable li
        {
            margin: 3px 3px 3px 3px;
            padding: 2px;
            float: left;
            width: 150px;
            height: 150px;
            font-size: 4em;
            text-align: center;
        }
        
        .li_Div_Style
        {
            border-width: 2px;
            padding: 4px;
            border-color: #D4D4D4;
            border-style: solid;
        }
        
        .li_Div_Style_Selected_Reorder
        {
            border-width: 2px;
            padding: 4px;
            background-color: #bce8f1;
            border-color: #bce8f1;
            border-style: solid;
        }
        
        .li_Div_Style_Selected
        {
            border-width: 2px;
            padding: 4px;
            background-color: #ffff00;
            border-color: #ffff00;
            border-style: solid;
        }
    </style>
</head>
<body>
    <form id="fileupload" clientidmode="Static" action="FileUploadHander.ashx" runat="server"
    method="post" enctype="multipart/form-data">
    <ucTopNavigation:TopNavigationUserControl IsAuthenticated="True" HasPermissionOnCurrentListing="True" ReloadPage="True" ID="TopNavigationUserControl1" runat="server" />
    <div class="container" style="margin-top: 60px">
        <div id="blockTitle" class="navbar-inner" align="center">
            <h4>
                Photos</h4>
        </div>
        <div style="width: 225px;" class="well pull-left">
            <ul class="nav nav-list">
                <li><a runat="server" id="ManageListingHyperlink" href="ManageListing.aspx"><i class="icon-edit">
                </i><b>Manage your Dish</b>&nbsp;<i runat="server" id="listingCompletionCount" class="badge badge-important">5</i></a></li>
                <li><a href="ListingNewTitleDescription.aspx" runat="server" id="NameAndDescriptionHyperlink">
                    <i class="icon-text-width"></i><b>Name and Description</b></a></li>
                <li><a href="ListingNewCatIngredients.aspx" runat="server" id="ListingCatAndIngredientsHyperlink">
                    <i class="icon-tag"></i><b>Category and Ingredients</b></a></li>
                <li class="active"><a href="ListingNewPhotos.aspx" runat="server" id="ListingPhotosHyperlink"><i
                    class="icon-picture"></i><b>Photos</b></a></li>
                <li><a href="ListingNewLocationPricing.aspx" runat="server" id="ListingLocationAndPricingHyperlink">
                    <i class="icon-home"></i><b>Pickup location and Pricing</b></a></li>
                <li><a href="ListingsAdditionalOption.aspx" runat="server" id="listingAdditionalHyperlink">
                    <i class="icon-th-list"></i><b>Additional options</b></a></li>
            </ul>
        </div>
        <div class="pull-left" style="margin-top: 10px; margin-left: 10px; width: 720px">
            <div class="navbar" style="margin-bottom: 0px;">
                <div class="navbar-inner">
                    <asp:HiddenField runat="server" ID="ListingPhotoCount" ClientIDMode="Static"/>
                    <ul class="nav nav-tabs" id="divTop">
                        <li class="active"><a href="#UploadPhoto">Upload Photo(s)</a> </li>
                        <li id="ManagePhotoTabLi"><a id="ManagePhotoTabLiA" href="#ManagePhoto">Manage Photos</a></li>
                    </ul>
                </div>
            </div>
            <div style="border-style: solid; border-width: 1px; border-color: #D4D4D4">
                <div class="tab-content" style="margin: 5px">
                    <div class="tab-pane active" id="UploadPhoto">
                        <div class="row fileupload-buttonbar">
                            <div class="span7">
                                <!-- The fileinput-button span is used to style the file input field as button -->
                                <span class="btn btn-success fileinput-button"><i class="icon-plus icon-white"></i><span>
                                    Add files...</span>
                                    <input type="file" name="files[]" multiple>
                                </span>
                                <button type="submit" class="btn btn-primary start">
                                    <i class="icon-upload icon-white"></i><span>Start upload</span>
                                </button>
                                <button type="reset" class="btn btn-warning cancel">
                                    <i class="icon-ban-circle icon-white"></i><span>Cancel upload</span>
                                </button>
                                <button type="button" class="btn btn-danger delete">
                                    <i class="icon-trash icon-white"></i><span>Delete</span>
                                </button>
                                <input type="checkbox" class="toggle" />
                            </div>
                            <!-- The global progress information -->
                            <div class="span5 fileupload-progress fade">
                                <!-- The global progress bar -->
                                <div class="progress progress-success progress-striped active" role="progressbar"
                                    aria-valuemin="0" aria-valuemax="100">
                                    <div class="bar" style="width: 0%;">
                                    </div>
                                </div>
                                <!-- The extended global progress information -->
                                <div class="progress-extended">
                                    &nbsp;</div>
                            </div>
                        </div>
                        <!-- The loading indicator is shown during file processing -->
                        <div class="fileupload-loading">
                        </div>
                        <br>
                        <!-- The table listing the files available for upload/download -->
                        <table role="presentation" class="table table-striped" width="700">
                            <tbody class="files" data-toggle="modal-gallery" data-target="#modal-gallery">
                            </tbody>
                        </table>
                    </div>
                    <div class="tab-pane" id="ManagePhoto">
                        <div style="margin: 5px">
                            <input type="button" class="btn btn-primary" value="Save Order" onclick="UpdatePictureOrder()" />
                            <input type="button" class="btn btn-primary" value="Delete Photo" onclick="DeletePicture()" />
                        </div>
                        <div class="alert alert-info">
                            <button type="button" class="close" data-dismiss="alert">
                                &times;</button>
                            To change the order of photos drag the thumbnail of photo to the desired order.
                        </div>
                        <div class="alert" style="display: none" id="SaveOrderDiv">
                            <button type="button" class="close" data-dismiss="alert">
                                &times;</button>
                            <div>
                                Save Listing order methos</div>
                        </div>
                        <div class="tab-content" style="margin: 5px" id="ManageListingtab-content">
                            <ucManageListingPhotos:ManageListingPhotos runat="server" ID="ManageListingPhotoUserControl" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
     
    </form>
    <script type="text/javascript">
        $(function () {
            $('#divTop a').click(function (e) {
                e.preventDefault();
                $(this).tab('show');
            });

            initSortable();

            if (parseInt($("#ListingPhotoCount").val()) > 0) {
                $("#ManagePhotoTabLiA").tab('show');
            }
        });
        
        function initSortable() {
            $("#sortable li").click(function (e) {
                $("#sortable li > div").removeClass("li_Div_Style_Selected");
                $(this).children('div').addClass("li_Div_Style_Selected");
            });

            $("#sortable").sortable({
                start: function (event, ui) {
                    ui.item.children("div").removeClass("li_Div_Style");
                    ui.item.children("div").addClass("li_Div_Style_Selected_Reorder");
                    //get current element being sorted
                },
                stop: function (event, ui) {
                    //get current element being sorted
                    ui.item.children("div").removeClass("li_Div_Style_Selected_Reorder");
                    ui.item.children("div").addClass("li_Div_Style");
                }
            }).disableSelection();

            $("#sortable li").first().children('div').addClass("li_Div_Style_Selected");
        }

        function DeletePicture() {
            var selectedPicture = $("#sortable .li_Div_Style_Selected");
            var listingPictureId = selectedPicture.parent().attr('listingpictureid');
            var listingpictureUrl = selectedPicture.children("img").attr("src");

            var postData = "{listingId:'" + listingPictureId + "',listingUrl:'" + listingpictureUrl + "'}";
            
            $.ajax({
                type: "POST",
                url: "ListingNewPhotos.aspx/DeleteListingPicture",
                data: postData,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    selectedPicture.parent().remove();
                    $("#SaveOrderDiv").removeClass("alert-error");
                    $("#SaveOrderDiv").addClass("alert-success");
                    $("#SaveOrderDiv > div").text("Photo successfully deleted");
                    $("#sortable li").first().children('div').addClass("li_Div_Style_Selected");
                    $("#SaveOrderDiv").fadeIn("slow").delay(10000).fadeOut("slow");
                },
                error: function (msg) {
                    $("#SaveOrderDiv").removeClass("alert-success");
                    $("#SaveOrderDiv").addClass("alert-error");
                    $("#SaveOrderDiv > div").text("Error occure while deleting photo");
                    $("#SaveOrderDiv").fadeIn("slow").delay(5000).fadeOut("slow");
                }
            });
        }

        function UpdatePictureOrder() {
            var codeObject = [];
            var myString;
            var objCode;
            $("#sortable li").each(function (index) {
                objCode = new Object();
                objCode.Code = $(this).attr("listingpictureid");
                objCode.Value = index;
                codeObject.push(objCode);
            });

            myString = JSON.stringify(codeObject);

            $.ajax({
                type: "POST",
                url: "ListingNewPhotos.aspx/SaveOrderInDb",
                data: "{codeObjects: " + myString + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    $("#SaveOrderDiv").removeClass("alert-error");
                    $("#SaveOrderDiv").addClass("alert-success");
                    $("#SaveOrderDiv > div").text("Order saved successfully");
                    $("#SaveOrderDiv").fadeIn("slow").delay(10000).fadeOut("slow");
                },
                error: function (msg) {
                    $("#SaveOrderDiv").removeClass("alert-success");
                    $("#SaveOrderDiv").addClass("alert-error");
                    $("#SaveOrderDiv > div").text("Error occure while saving order");
                    $("#SaveOrderDiv").fadeIn("slow").delay(5000).fadeOut("slow");
                }
            });
        }
    </script>
    <!-- The template to display files available for upload -->
    <script id="template-upload" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) {  %}
  
    <tr class="template-upload fade">
        <td class="preview"><span class="fade"></span></td>
        <td class="name"><span>{%=file.name%}</span></td>
        <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
        {% if (file.error) { %}
            <td class="error" colspan="2"><span class="label label-important">Error</span> {%=file.error%}</td>
        {% } else if (o.files.valid && !i) { %}
            <td>
                <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="bar" style="width:0%;"></div></div>
            </td>
            <td class="start">{% if (!o.options.autoUpload) { %}
                <button class="btn btn-primary">
                    <i class="icon-upload icon-white"></i>
                    <span>Start</span>
                </button>
            {% } %}</td>
        {% } else { %}
            <td colspan="2"></td>
        {% } %}
        <td class="cancel">{% if (!i) { %}
            <button class="btn btn-warning">
                <i class="icon-ban-circle icon-white"></i>
                <span>Cancel</span>
            </button>
        {% } %}</td>
    </tr>
{% } %}
    </script>
    <!-- The template to display files available for download -->
    <script id="template-download" type="text/x-tmpl">

{% for (var i=0, file; file=o.files[i]; i++) { %}


    <tr class="template-download fade">
        {% if (file.error) { %}
            <td></td>
            <td class="name"><span>{%=file.name%}</span></td>
            <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
            <td class="error" colspan="2"><span class="label label-important">Error</span> {%=file.error%}</td>
        {% } else { %}
            <td class="preview">{% if (file.thumbnail_url) { %}
                <img style="height: 50px" src="{%=file.thumbnail_url%}">
            {% } %}</td>
            <td class="name">
                <a href="{%=file.url%}" title="{%=file.name%}" target="_blank" data-gallery="{%=file.thumbnail_url&&'gallery'%}" download="{%=file.name%}">{%=file.name%}</a>
            </td>
            <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
            <td colspan="2"></td>
        {% } %}
        <td class="delete">
            <button class="btn btn-danger" data-type="{%=file.delete_type%}" data-url="{%=file.delete_url%}"{% if (file.delete_with_credentials) { %} data-xhr-fields='{"withCredentials":true}'{% } %}>
                <i class="icon-trash icon-white"></i>
                <span>Delete</span>
            </button>
            <input type="checkbox" name="delete" value="1">
        </td>
    </tr>
{% } UpdateManagePhotosTab(); %}

    </script>
    <script type="text/javascript">
        function UpdateManagePhotosTab() {

            $.ajax({
                type: "POST",
                url: "ListingNewPhotos.aspx/GetListingPictures",
                data: "",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (msg.d.length > 0) {
                        $("#ManageListingtab-content").html(msg.d);
                        initSortable();
                        $("#ManagePhotoTabLi").effect("pulsate", { times: 1 }, 2000);
                       
                    }
                },
                error: function (msg) {

                }
            });
            

        }
    </script>
    <!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
    <script src="js/FileUpload/vendor/jquery.ui.widget.js"></script>
    <!-- The Templates plugin is included to render the upload/download listings -->
    <script src="js/FileUpload/blueimp/JavaScript-Templates-2.2.1/tmpl.min.js"></script>
    <!-- The Load Image plugin is included for the preview images and image resizing functionality -->
    <script src="js/FileUpload/blueimp/JavaScript-Load-Image/load-image.min.js"></script>
    <!-- The Canvas to Blob plugin is included for image resizing functionality -->
    <script src="js/FileUpload/blueimp/JavaScript-Canvas-to-Blob-master/canvas-to-blob.min.js"></script>
    <!-- Bootstrap JS and Bootstrap Image Gallery are not required, but included for the demo -->
    <script src="http://blueimp.github.com/cdn/js/bootstrap.min.js"></script>
    <script src="http://blueimp.github.com/Bootstrap-Image-Gallery/js/bootstrap-image-gallery.min.js"></script>
    <!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
    <script src="js/FileUpload/jquery.iframe-transport.js"></script>
    <!-- The basic File Upload plugin -->
    <script src="js/FileUpload/jquery.fileupload.js"></script>
    <!-- The File Upload file processing plugin -->
    <script src="js/FileUpload/jquery.fileupload-fp.js"></script>
    <!-- The File Upload user interface plugin -->
    <script src="js/FileUpload/jquery.fileupload-ui.js"></script>
    <!-- The main application script -->
    <script src="js/FileUpload/main.js"></script>
    <!-- The XDomainRequest Transport is included for cross-domain file deletion for IE8+ -->
    <!--[if gte IE 8]><script src="js/FileUpload/cors/jquery.xdr-transport.js"></script><![endif]-->
</body>
</html>
<script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>