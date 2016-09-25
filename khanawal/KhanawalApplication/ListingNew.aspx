<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="ListingNew.aspx.cs"
    ClientIDMode="Static" Inherits="KhanawalApplication.ListingNew" %>
    
<%@ Register Src="TopNavigationUserControl.ascx" TagName="TopNavigationUserControl"
    TagPrefix="ucTopNavigation" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script>        window.jQuery || document.write('<script src="js/vendor/jquery-1.8.2.min.js"><\/script>')</script>
    <script src="js/vendor/bootstrap.min.js"></script>
    <script src="js/vendor/modernizr-2.6.1-respond-1.1.0.min.js"></script>
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/Custom.css" rel="stylesheet" type="text/css" />
    <link href="themes/default/default.css" rel="stylesheet" type="text/css" />
    <script src="js/jquery.validate.min.js" type="text/javascript"></script>
    <style type="text/css">
        .form-helpers
        {
            margin-top: 6px;
            margin-bottom: 4px;
            line-height: 16px;
            color: #c8c8c8;
        }
    </style>
    <!--[if lt IE 9]>
    <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
  <![endif]-->
</head>
<body>
    <form id="form1" class="form-class" runat="server">
    <ucTopNavigation:TopNavigationUserControl ID="TopNavigationUserControl1" runat="server" ReloadPage="True"  />
    <asp:HiddenField runat="server" ID="UserLoggedInHiddenField" />
    <div class="container" style="margin-top: 60px">
        <div class="span12">
            <div class="navbar-inner" style="text-align: center">
                <h5>
                    Add New Dish</h5>
            </div>
            <div class="form-horizontal" style="margin-top: 10px">
                <div class="control-group">
                    <label class="control-label" for="DishNameTextBox">
                        Dish Name</label>
                    <div class="controls">
                        <asp:TextBox runat="server" custom-validate="true" custom-required="true" MaxLength="25"
                            custom-minlength="5" Width="300px" ID="DishNameTextBox">
                            
                        </asp:TextBox>
                        <label for="DishNameTextBox" style="display: none" generated="true" class="error">
                            Ok</label>
                        <div class="form-helpers">
                            What you call your yummy dish
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="DishDescriptionTextBox">
                        Short Dish recipe</label>
                    <div class="controls">
                        <asp:TextBox custom-validate="true" custom-minlength="25" custom-required="true"
                            runat="server" ID="DishDescriptionTextBox" Rows="20" Columns="40" Width="500px"
                            Height="250px" TextMode="MultiLine"></asp:TextBox>
                        <label for="DishDescriptionTextBox" style="display: none" generated="true" class="error">
                            Ok</label>
                        <div class="form-helpers">
                            provide a short food recipe for eg : how you made chiken biryani or dal pakoda.
                            minimum 30 words are expected.
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="DishTypeDropDownList">
                        Veg or Non-Veg</label>
                    <div class="controls">
                        <asp:DropDownList custom-validate="true" runat="server" ID="DishTypeDropDownList"
                            Width="220px" ClientIDMode="Static">
                            <asp:ListItem Value="">-- Select Veg or Non Veg --</asp:ListItem>
                            <asp:ListItem Value="Veg">Veg</asp:ListItem>
                            <asp:ListItem Value="NonVeg">Non veg</asp:ListItem>
                        </asp:DropDownList>
                        <div class="form-helpers">
                            select your dish type. I like non veg.
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="TextBoxPeopleCount">
                        People <i class="icon-question-sign" rel="tooltip" title="How many people can sufficiently eat in a single dish">
                        </i>
                    </label>
                    <div class="controls">
                        <asp:TextBox runat="server" ID="TextBoxPeopleCount"></asp:TextBox>
                        <label for="TextBoxPeopleCount" style="display: none" generated="true" class="error">
                            Ok</label>
                        <div class="form-helpers">
                            Maximum number of dishes you can provide. consider 1 dish per 1 adult.
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <div class="controls">
                        <asp:Button runat="server" ID="btnSave" OnClientClick="return pageReloadOnButtonClick();" Text="Connect To facebook and Save" CssClass="btn btn-primary" />
                            
                    </div>
                </div>
            </div>
        </div>
    </div>
   
    </form>
    <script type="text/javascript">

        $(document).ready(function () {
            $(document).on("AuthSuccess", AuthSuccessHandler);
        });


        // AuthSuccess event handler
        function AuthSuccessHandler(e) {
            SaveRequest();
        }

        function pageReloadOnButtonClick() {
            if ($('.form-class').valid()) {

                if ($("#btnSave").attr("Auth") != "1") {
                    AuthenticateUser();
                } else {
                    SaveRequest();
                }
               
            }
           
            return false;
        }
        
        function SaveRequest() {

            var dishName = $("#DishNameTextBox").val();
            var vegOrNonVeg = $("#DishTypeDropDownList").val().replace(/'/g, ""); 
            var description = $("#DishDescriptionTextBox").val().replace(/'/g,"");
            var servings = $("#TextBoxPeopleCount").val();

            var postData = "{dishName:'" + dishName +
                "',vegOrNonVeg:'" + vegOrNonVeg +
                "',description:'" + description +
                "',servings:'" + servings +
                "'}";

            $.ajax({
                type: "POST",
                url: "ListingNew.aspx/SaveInitialListing",
                data: postData,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                beforeSend: function () {
                    //Mask page
                    //showProgress();
                },
                complete: function () {
                    //remove Mask
                    //hideProgress();

                },
                success: function (msg) {
                    //alert("success");
                    window.location.href = "ManageListing.aspx?ID=" + msg.d;
                },
                error: function (msg) {
//                    debugger;
//                    alert(msg);

                }
            });
        }


        $(function () {
            $('.form-class').validate({
                ignore: "",
                rules: {
                    DishNameTextBox: { required: true },
                    TextBoxPeopleCount: { required: true, digits: true },
                    DishDescriptionTextBox: { required: true, minlength: 30 },
                    DishTypeDropDownList: { required: true }
                },
                highlight: function (label) {
                    $(label).closest('.control-group').removeClass('success');
                    $(label).closest('.control-group').addClass('error');
                },
                success: function (label) {
                    label
                        .text('OK!').addClass('valid')
                        .closest('.control-group').removeClass('error')
                        .closest('.control-group').addClass('success');
                }
            });
        });
    </script>
</body>
</html>
<script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
