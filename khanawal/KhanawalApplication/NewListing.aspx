<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false"
    Inherits="KhanawalApplication.NewListing" Codebehind="NewListing.aspx.cs" %>

<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolderMain">
  <!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
    <!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
    <!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
    <!--[if gt IE 8]><!-->
    <html class="no-js">
    <!--<![endif]-->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title></title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width">
    
    <link href="css/datepicker.css" rel="stylesheet" type="text/css" />
    <style>
        body
        {
            padding-top: 60px;
            padding-bottom: 40px;
        }
        
        #map_canvas
        {
            width: auto;
            height: 300px;
        }
        
        #gallery
        {
            padding: 2em 0;
            margin: 0 auto;
            width: 600px;
        }
        
        #gallery #main
        {
            width: 100%;
            margin: 0;
            list-style: none;
        }
        #gallery #main li
        {
            float: left;
            width: 160px;
            margin: 0 20px 10px 0;
        }
        #gallery #main li img
        {
            display: block;
            width: 140px;
            height: 120px;
        }
        #gallery #main li p
        {
            margin: 0;
        }
    </style>
    <link href="themes/default/default.css" rel="stylesheet" type="text/css" />
    <link href="jasny-bootstrap/css/jasny-bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="js/AjaxUpload/fileuploader.css" rel="stylesheet" type="text/css" />
    <link href="css/select2/select2.css" rel="stylesheet" type="text/css" />
    
    <script src="js/AjaxUpload/fileuploader.js" type="text/javascript"></script>
    <script src="js/jquery.validate.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?v=3&sensor=true"></script>
    <script src="js/select2.min.js" type="text/javascript"></script>
    <div class="container">
        <div class="span12">
            <div class="well">
            </div>
            <div class="form-horizontal">
                <div class="control-group">
                    <label class="control-label" for="DishNameTextBox">
                        Dish Name</label>
                    <div class="controls">
                        <asp:TextBox runat="server" ID="DishNameTextBox" name="DishNameTextBox" ClientIDMode="Static"></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="DishTypeDropDownList">
                        Veg or Non-Veg</label>
                    <div class="controls">
                        <asp:DropDownList runat="server" ID="DishTypeDropDownList" ClientIDMode="Static">
                            <asp:ListItem Value="">-- Select --</asp:ListItem>
                            <asp:ListItem Value="Veg">Veg</asp:ListItem>
                            <asp:ListItem Value="NonVeg">Non veg</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="TasteDropDownList">
                        Taste
                    </label>
                    <div class="controls">
                        <asp:DropDownList runat="server" ID="TasteDropDownList" ClientIDMode="Static">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="RecipetypeDropDownList">
                        Recipe type
                    </label>
                    <div class="controls">
                        <asp:DropDownList runat="server" ID="RecipetypeDropDownList" ClientIDMode="Static">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="CuisineTypeDropDownList">
                        Cuisine Type
                    </label>
                    <div class="controls">
                        <asp:DropDownList runat="server" ID="CuisineTypeDropDownList" ClientIDMode="Static">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="MainIngredientTextBox">
                        Main Ingredient <i class="icon-question-sign" rel="tooltip" title="What will be the main ingredient in the food, for eg : chiken tikka has chiken as main ingredient">
                        </i>
                    </label>
                    <div class="controls">
                        <asp:TextBox runat="server" ID="MainIngredientTextBox" Style="width: 220px" ClientIDMode="Static"></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="SubIngredientTextBox">
                        Sub Ingredient <i class="icon-question-sign" rel="tooltip" title="What will be the sub ingredients in the food, for eg : Dal tadka has ginger as sub ingredient">
                        </i>
                    </label>
                    <div class="controls">
                        <asp:HiddenField runat="server" ID="SubIngredientsHiddenField" ClientIDMode="Static" />
                        <asp:DropDownList multiple runat="server" Width="220px" DataTextField="Name" DataValueField="ID"
                            ID="SubIngredientDropDownList">
                        </asp:DropDownList>
                         <a href="#SubIngredientsModal" role="button" data-toggle="modal">
                            <img src="img/icons/glyphicons_145_folder_plus.png" alt="Add sub ingredients" />
                        </a>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="PeopleDropDownList">
                        People <i class="icon-question-sign" rel="tooltip" title="How many people can sufficiently eat in a single dish">
                        </i>
                    </label>
                    <div class="controls">
                        <asp:DropDownList runat="server" ID="PeopleDropDownList">
                            <asp:ListItem Value="">-- Select --</asp:ListItem>
                            <asp:ListItem Value="1" Selected="True">1</asp:ListItem>
                            <asp:ListItem Value="2">2</asp:ListItem>
                            <asp:ListItem Value="3">3</asp:ListItem>
                            <asp:ListItem Value="4">4</asp:ListItem>
                            <asp:ListItem Value="5">5</asp:ListItem>
                            <asp:ListItem Value="5+">5+</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="DishDescriptionTextBox">
                        Dish Description</label>
                    <div class="controls">
                        <asp:TextBox runat="server" ClientIDMode="Static" ID="DishDescriptionTextBox" Rows="8"
                            Columns="40" TextMode="MultiLine"></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="CostTextBox">
                        Dish Cost</label>
                    <div class="controls">
                        <asp:TextBox runat="server" ID="CostTextBox" Rows="20" Columns="40"></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="HomedeliveryCheckbox">
                        Home delivery <i class="icon-question-sign" rel="tooltip" title="Are you going to provide free delivery">
                        </i>
                    </label>
                    <div class="controls">
                        <div style="float: left">
                            <label class="checkbox" style="float: left; margin-right: 10px;">
                                <asp:RadioButton GroupName="HomeDelivery" Text="Yes" runat="server" ID="HomedeliveryCheckbox" />
                            </label>
                            <label class="checkbox" style="float: left">
                                <asp:RadioButton GroupName="HomeDelivery" Text="No" runat="server" Checked="True"
                                    ID="HomedeliveryNoCheckbox" />
                            </label>
                        </div>
                    </div>
                </div>
                <div class="control-group HomeDeliveryTextboxclass" style="display: none">
                    <label class="control-label" for="HomeDeliveryTextbox">
                        Home delivery charges
                    </label>
                    <div class="controls">
                        Free? &nbsp;&nbsp;
                        <asp:CheckBox Checked="True" ClientIDMode="Static" runat="server" ID="HDfreeCheckbox" />
                        <br />
                        What are the charges?
                        <asp:TextBox ClientIDMode="Static" runat="server" ID="AdditionalHDChargesTextBox"
                            disabled></asp:TextBox>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="SideDishes">
                        Side Dish Provided? <i class="icon-question-sign" rel="tooltip" title="Are you going to provide side dish along with the main dish">
                        </i>
                    </label>
                    <div class="controls">
                        <div style="float: left">
                            <label class="checkbox" style="float: left; margin-right: 10px;">
                                <asp:RadioButton GroupName="SideDish" Text="Yes" runat="server" ID="SideDishcheckbox"
                                    ClientIDMode="Static" />
                            </label>
                            <label class="checkbox" style="float: left;">
                                <asp:RadioButton GroupName="SideDish" Text="No" Checked="True" runat="server" ID="SideDishNocheckbox"
                                    ClientIDMode="Static" />
                            </label>
                        </div>
                    </div>
                </div>
                <div class="control-group" id="SideDishValue" style="display: none">
                    <label class="control-label" for="SideDishes">
                        Side Dish Name <i class="icon-question-sign" rel="tooltip" title="If you have more than one side dish then separate them with semicoloum.">
                        </i>
                    </label>
                    <div class="controls">
                        <asp:HiddenField runat="server" ID="SideListingHidden" ClientIDMode="Static" />
                        <asp:DropDownList multiple runat="server" Width="220px" DataMember="SideListing"
                            DataTextField="Name" DataValueField="ID" ID="SideDishDropDownList">
                        </asp:DropDownList>
                        <a href="#myModal" role="button" data-toggle="modal">
                            <img src="img/icons/glyphicons_145_folder_plus.png" alt="Dish Served" />
                        </a>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="DishDescriptionTextBox">
                        Dish Images <i class="icon-question-sign" rel="tooltip" title="Take beautiful photographs of your dish and upload it here.">
                        </i>
                    </label>
                    <div class="controls">
                        <div id="file-uploader">
                            <noscript>
                                <p>
                                    Please enable JavaScript to use file uploader.</p>
                                <!-- or put a simple form for upload here -->
                            </noscript>
                        </div>
                        <div id="gallery">
                            <ul id="main">
                            </ul>
                            <asp:HiddenField runat="server" ID="HiddenFieldListingImages" ClientIDMode="Static" />
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="PickUpLocation">
                        Use home address as pick up location?<i class="icon-question-sign" rel="tooltip"
                            title="are you going use your home addess as the pick up address, or you want to specify some other address, your browser may ask request to share your current location"></i>
                    </label>
                    <div class="controls">
                        <div style="float: left">
                            <label class="radio" style="float: left; margin-right: 10px;">
                                <asp:RadioButton Text="Yes" GroupName="PickUplocation" runat="server" ID="PickUplocationCheckBox"
                                    Checked="True" ClientIDMode="Static" />
                            </label>
                            <label class="radio" style="float: left;">
                                <asp:RadioButton runat="server" Text="No" GroupName="PickUplocation" ID="PickUplocationNoCheckBox"
                                    ClientIDMode="Static" />
                            </label>
                        </div>
                    </div>
                </div>
                <div class="control-group" id="pickUpLocationDiv" style="display: none">
                    <label class="control-label" for="PickUpLocation">
                        Select pick up location
                    </label>
                    <div class="controls">
                        <div id="map_canvas">
                        </div>
                    </div>
                    <asp:HiddenField runat="server" ID="latHiddenField" ClientIDMode="Static" />
                    <asp:HiddenField runat="server" ID="lngHiddenField" ClientIDMode="Static" />
                    <asp:HiddenField runat="server" ID="AddressHiddenField" ClientIDMode ="Static" />
                </div>
                <div class="control-group">
                    <label class="control-label" for="ConfirmAvailability">
                        Confirmation Available message required?<i class="icon-question-sign" rel="tooltip"
                            title="If you choose your answers as yes then user has to send you a message for checcking your availablity"></i>
                    </label>
                    <div class="controls">
                        <div style="float: left">
                            <label class="radio" style="float: left; margin-right: 10px;">
                                <asp:RadioButton Text="Yes" GroupName="ConfirmAvailability" runat="server" ID="ConfirmAvailability"
                                    Checked="True" ClientIDMode="Static" />
                            </label>
                            <label class="radio" style="float: left;">
                                <asp:RadioButton runat="server" Text="No" GroupName="ConfirmAvailability" ID="ConfirmAvailabilityNo"
                                    ClientIDMode="Static" />
                            </label>
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="CancellationDropDownList">
                        Cancellation</label>
                    <div class="controls">
                        <asp:DropDownList runat="server" ID="CancellationDropDownList" ClientIDMode="Static">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-actions">
                    <asp:Button CausesValidation="False" runat="server" ID="SubmitButton" Text="Submit"
                        CssClass="btn btn-primary btn-large" OnClick="SubmitButton_Click" />
                    <button class="btn">
                        Cancel</button>
                </div>
            </div>
            <!-- Modal -->
            <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                aria-hidden="true">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        ×</button>
                    <h3 id="myModalLabel">
                        New Side Listing</h3>
                </div>
                <div class="modal-body">
                    <table>
                        <tr>
                            <td>
                                Name
                            </td>
                            <td>
                                <asp:TextBox runat="server" ClientIDMode="Static" ID="ListingNameTextBox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Description
                            </td>
                            <td>
                                <asp:TextBox TextMode="MultiLine" ClientIDMode="Static" Rows="5" Width="400px" runat="server"
                                    ID="ListingDescription"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <ul id="errorUl">
                                </ul>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">
                        Close</button>
                    <input type="button" class="btn btn-primary" onclick="SaveSideListing()" data-dismiss="modal"
                        aria-hidden="true" value="Save" />
                </div>
            </div>
            <!--Modal for Sub Ingredients -->
            <div id="SubIngredientsModal" class="modal hide fade" tabindex="-1" role="dialog"
                aria-labelledby="SubIngredientsModalLabel" aria-hidden="true">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        ×</button>
                    <h3 id="H1">
                        New sub Ingredient</h3>
                </div>
                <div class="modal-body">
                    <table>
                        <tr>
                            <td>
                                Name
                            </td>
                            <td>
                                <asp:TextBox runat="server" ClientIDMode="Static" ID="SubIngredientTextBox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Description
                            </td>
                            <td>
                                <asp:TextBox TextMode="MultiLine" ClientIDMode="Static" Rows="5" Width="400px" runat="server"
                                    ID="SubIngredientDescriptionTextBox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <ul id="SubIngredientUl">
                                </ul>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary" data-dismiss="modal" aria-hidden="true">
                        Close</button>
                    <input type="button" class="btn btn-primary" onclick="SaveSubIngredientsListing()" data-dismiss="modal"
                        aria-hidden="true" value="Save" />
                </div>
            </div>
        </div>
    </div>
    
    <script type="text/javascript">

          var sideDishDropDownListVal = "";
          var subIngredientsDropDownListVal = "";


          function SaveSubIngredientsListing() {
              //            var commentsdivID = "#MainPostComments-" + PostID;
              //            var userCommentDivID = "#MainPostCurrUserComment-" + PostID;
              //            var commentsdiv = $(commentsdivID);

              var subIngredientsTextBox = $("#SubIngredientTextBox");
              var subIngredientsDescription = $("#SubIngredientDescriptionTextBox");
              var subIngredientValidate = false;

              var postData = "{Name:'" + subIngredientsTextBox.val() + "',Comment:'" + subIngredientsDescription.val() + "'}";

              if (subIngredientsTextBox.val().length > 0 && subIngredientsDescription.val().length > 0) {
                  subIngredientValidate = true;
              } else {
                  $("#errorUl").empty();
                  if (subIngredientsTextBox.val().length <= 0) {
                      $("#errorUl").append("<li>Ingredient name is required</li>");
                  }
                  if (subIngredientsDescription.val().length <= 0) {
                      $("#errorUl").append("<li>Ingredient description is required , if you dont have Ingredient description just use ingredient name as description</li>");
                  }
              }

              if (subIngredientValidate) {
                  var subIngredientDropDownList = $("#SubIngredientDropDownList");
                  var description = subIngredientsDescription.val();

                  if (description.length > 100) {
                      description = description.toString().substring(0, 99) + "..";
                  }
                  subIngredientDropDownList.append("<option data-Descfull='" + description + "' data-Desc='" + subIngredientsDescription.val() + "' value='" + subIngredientsTextBox.val() + "'>" + subIngredientsTextBox.val() + "</option>");
                  ///Do it simple

                  var data = subIngredientDropDownList.val() + "," + subIngredientsTextBox.val();

                  //Make an array

                  var dataarray = data.split(",");

                  // Set the value

                  subIngredientDropDownList.val(dataarray);

                  // Then refresh

                  subIngredientDropDownList.select2({
                      formatResult: format
                  });

                  subIngredientsDropDownListVal = "";
                  subIngredientDropDownList.find(":selected").each(function () {
                      //alert($(this).text() + ' ' + $(this).val() + ' ' + $(this).attr('data-Desc'));
                      subIngredientsDropDownListVal = subIngredientsDropDownListVal + $(this).text() + '|' + $(this).val() + '|' + $(this).attr('data-Desc') + '$';
                  });


                  $("#SubIngredientsHiddenField").val(subIngredientsDropDownListVal);
              }
          }

          function SaveSideListing() {
              //            var commentsdivID = "#MainPostComments-" + PostID;
              //            var userCommentDivID = "#MainPostCurrUserComment-" + PostID;
              //            var commentsdiv = $(commentsdivID);

              var listingNameTextBox = $("#ListingNameTextBox");
              var listingDescription = $("#ListingDescription");
              var sideListingValidate = false;

              var postData = "{Name:'" + listingNameTextBox.val() + "',Comment:'" + listingDescription.val() + "'}";

              if (listingNameTextBox.val().length > 0 && listingDescription.val().length > 0) {
                  sideListingValidate = true;
              } else {
                  $("#errorUl").empty();
                  if (listingNameTextBox.val().length <= 0) {
                      $("#errorUl").append("<li>list name is required</li>");
                  }
                  if (listingDescription.val().length <= 0) {
                      $("#errorUl").append("<li>list description is required</li>");
                  }
              }

              if (sideListingValidate) {

                  var description = listingDescription.val();

                  if (description.length > 100) {
                      description = description.toString().substring(0, 99) + "..";
                  }

                  $("#SideDishDropDownList").append("<option data-Descfull='" + description + "' data-Desc='" + listingDescription.val() + "' value='" + listingNameTextBox.val() + "'>" + listingNameTextBox.val() + "</option>");
                  ///Do it simple

                  var data = $("#SideDishDropDownList").val() + "," + listingNameTextBox.val();

                  //Make an array

                  var dataarray = data.split(",");

                  // Set the value

                  $("#SideDishDropDownList").val(dataarray);

                  // Then refresh

                  $("#SideDishDropDownList").select2({
                      formatResult: format
                  });

                  sideDishDropDownListVal = "";
                  $('#SideDishDropDownList').find(":selected").each(function () {
                      //alert($(this).text() + ' ' + $(this).val() + ' ' + $(this).attr('data-Desc'));
                      sideDishDropDownListVal = sideDishDropDownListVal + $(this).text() + '|' + $(this).val() + '|' + $(this).attr('data-Desc') + '$';
                  });


                  $("#SideListingHidden").val(sideDishDropDownListVal);
              }
          }

          function format(sideDish) {
              var originalOption = sideDish.element;
              return "<div><b>" + sideDish.text + "</b><small>" + " (" + $(originalOption).data('descfull') + ")</small></div>";

          }

          $(function () {
              $('[rel=tooltip]').tooltip();

              $.validator.addMethod('positiveNumber',
                 function (value) {
                     return Number(value) > 0;
                 }, 'Enter a positive number.');

              $("#MainIngredientTextBox").select2({ tags: ["red", "green", "blue"], maximumSelectionSize: 1 });

              $("#SideDishDropDownList").select2({
                  formatResult: format
              });

              $("#SubIngredientDropDownList").select2({
                  formatResult: format
              });

              $("#SubIngredientDropDownList")
            .on("change", function (e) {
                subIngredientsDropDownListVal = "";
                $('#SubIngredientDropDownList').find(":selected").each(function () {
                    //alert($(this).text() + ' ' + $(this).val() + ' ' + $(this).attr('data-Desc'));
                    subIngredientsDropDownListVal = subIngredientsDropDownListVal + $(this).text() + '|' + $(this).val() + '|' + $(this).attr('data-Desc') + '$';
                });

                $("#SubIngredientsHiddenField").val(subIngredientsDropDownListVal);
                //SideListingHidden
            });



              $("#SideDishDropDownList")
            .on("change", function (e) {
                sideDishDropDownListVal = "";
                $('#SideDishDropDownList').find(":selected").each(function () {
                    //alert($(this).text() + ' ' + $(this).val() + ' ' + $(this).attr('data-Desc'));
                    sideDishDropDownListVal = sideDishDropDownListVal + $(this).text() + '|' + $(this).val() + '|' + $(this).attr('data-Desc') + '$';
                });


                $("#SideListingHidden").val(sideDishDropDownListVal);
                //SideListingHidden
            });


              // $("#sideDishesTextBox").select2({ tags: ["Raita"] });

              $('.form-class').validate({
                  ignore: "",
                  rules: {
                      DishNameTextBox: { required: true },
                      DishTypeDropDownList: { required: true },
                      TasteDropDownList: { required: true },
                      PeopleDropDownList: { required: true },
                      RecipetypeDropDownList: { required: true },
                      CuisineTypeDropDownList: { required: true },
                      CostTextBox: { required: true, number: true, positiveNumber: true },
                      MainIngredientTextBox: { required: true },
                      DishDescriptionTextBox: { required: true },
                      CancellationDropDownList: { required: true }
                  },
                  highlight: function (label) {
                     
                      (label)
                          .closest('.control-group').addClass('error');
                  },
                  success: function (label) {
                      label
                        .text('OK!').addClass('valid')
                        .closest('.control-group').addClass('success');
                  }
              });
          });




          $(function () {
              $("#HomedeliveryCheckbox, #HomedeliveryNoCheckbox").change(function () {
                  if ($("#HomedeliveryCheckbox").is(':checked')) {
                      $(".HomeDeliveryTextboxclass").show();
                  } else {
                      $(".HomeDeliveryTextboxclass").hide();
                  }
              });
          });

          function OnFileSelected_Change(input) {
              debugger;
              $("#form2").submit();
          }

          function OnComplete(result) {
              alert('Success');
          }
          function OnFail(result) {
              alert('Request failed');

          }

          function createUploader() {
              var uploader = new qq.FileUploader({
                  element: document.getElementById('file-uploader'),
                  action: 'Handler.ashx',
                  allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
                  debug: true,
                  multiple: true,
                  onComplete: function (id, fileName, responseJSON) {
                      if (responseJSON.success) {
                          $("#main").append("<li><img  src='" + responseJSON.path + "' /></li>");
                          $('#HiddenFieldListingImages').val(function (i, val) {
                              return val + (!val ? '' : ', ') + responseJSON.name;
                          });

                      }
                      else {
                          $(".qq-upload-failed-text").text("Upload Failed With Error:" + responseJSON.Error);

                      }
                  }
              });
          }

          $(function () {
              createUploader();
          });

          $(function () {
              $("#HDfreeCheckbox").change(function () {
                  if ($(this).is(':checked')) {
                      $("#AdditionalHDChargesTextBox").attr("disabled", "");
                      $("#DropDownListAdditionalChargers").attr("disabled", "");
                  } else {

                      $("#AdditionalHDChargesTextBox").removeAttr("disabled");
                      $("#DropDownListAdditionalChargers").removeAttr("disabled");
                  }
              });
          });


          $(function () {
              $("#SideDishcheckbox, #SideDishNocheckbox").change(function () {
                  if ($("#SideDishcheckbox").is(':checked')) {
                      $("#SideDishValue").show();
                      $("#sideDishesTextBox").removeAttr("disabled");
                  } else {
                      $("#SideDishValue").hide();
                      $("#sideDishesTextBox").attr("disabled", "");
                  }
              });
          });


          $(function () {
              $("#PickUplocationCheckBox , #PickUplocationNoCheckBox").change(function () {
                  if ($("#PickUplocationNoCheckBox").is(':checked')) {
                      $("#pickUpLocationDiv").show();
                      initializeMap();
                  } else {
                      $("#pickUpLocationDiv").hide();

                  }
              });
          });

        

    </script>
    <script type="text/javascript">
        function codeLatLng(lat, lng) {
            var geocoder = new google.maps.Geocoder();
            var latlng = new google.maps.LatLng(lat, lng);
            geocoder.geocode({ 'latLng': latlng }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    if (results[1]) {
                        $("#AddressHiddenField").val(results[0].formatted_address);
                    }
                }
            });
        }
        function initializeMap() {

            var initialLocation;
            var lattitue;
            var longitude;
            var map;
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function (position) {
                    lattitue = position.coords.latitude;
                    longitude = position.coords.longitude;
                    $("#latHiddenField").val(lattitue);
                    $("#lngHiddenField").val(longitude);
                    codeLatLng(lattitue, longitude);
                    var myOptions = {
                        zoom: 15,
                        center: new google.maps.LatLng(lattitue, longitude),
                        zoomControlOptions: {
                            style: google.maps.ZoomControlStyle.LARGE
                        },
                        mapTypeId: google.maps.MapTypeId.ROADMAP
                    };

                    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

                    var myMarker = new google.maps.Marker({
                        position: new google.maps.LatLng(lattitue, longitude),
                        draggable: true
                    });

                    google.maps.event.addListener(myMarker, 'dragend', function () {
                        $("#latHiddenField").val(myMarker.position.lat());
                        $("#lngHiddenField").val(myMarker.position.lng());
                        codeLatLng(myMarker.position.lat(), myMarker.position.lng())
                    });

                    // Add a Circle overlay to the map.
                    var circle = new google.maps.Circle({
                        map: map,
                        radius: 500 // 3000 km
                    });

                    circle.bindTo('center', myMarker, 'position');

                    map.setCenter(myMarker.position);
                    myMarker.setMap(map);
                });


            }


        }
        
    </script>
</asp:Content>


