<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdhocRequestDetails.aspx.cs"
    Inherits="KhanawalApplication.AdhocRequestDetails" %>

<%@ Register TagPrefix="ucTopNavigation" TagName="TopNavigationUserControl" Src="~/TopNavigationUserControl.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Request Details</title>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script src="js/vendor/bootstrap.min.js"></script>
    <!--[if lt IE 9]>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
    <link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="css/Custom.css" rel="stylesheet" type="text/css" />
    <link href="css/select2/select2.css" rel="stylesheet" type="text/css" />
    <script src="js/select2.min.js" type="text/javascript"></script>
    <script src="js/bootstrap-tagmanager.js" type="text/javascript"></script>
    <link href="css/bootstrap-tagmanager.css" rel="stylesheet" type="text/css" />
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css" />
    <script src="js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
    <style>
        .form-helpers
        {
            margin-top: 6px;
            margin-bottom: 4px;
            line-height: 16px;
            color: #c8c8c8;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <ucTopNavigation:TopNavigationUserControl ID="TopNavigationUserControl1" runat="server" />
    <div class="container" style="margin-top: 60px">
        <div>
            <div class="navbar-inner" style="margin-bottom: 10px">
                <h5>
                    <div class="pull-left">
                        More information about dish
                    </div>
                </h5>
            </div>
            <div class="form-horizontal" id="divDishMoreInformationContent">
                <div class="control-group">
                    <label class="control-label" for="RequestType">
                        Type ?
                    </label>
                    <div class="controls">
                        <asp:RadioButton runat="server" ID="VegRequestType" GroupName="FoodType" />
                        Veg
                        <br />
                        <asp:RadioButton runat="server" ID="NonVegRequestType" GroupName="FoodType" />
                        Non Veg
                        <div class="form-helpers">
                            you like Veg or Non veg?
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="RequestCostTextBox">
                        Cost ?
                    </label>
                    <div class="controls">
                        <asp:TextBox runat="server" ID="RequestCostTextBox"></asp:TextBox>
                        <div class="form-helpers">
                            provide your maximum budget for dish.
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="TasteDropDownList">
                        Taste ?
                    </label>
                    <div class="controls">
                        <asp:HiddenField runat="server" ID="HiddenFieldTasteDropDownList" />
                        <asp:DropDownList multiple custom-validate="true" runat="server" ID="TasteDropDownList"
                            Width="220px" ClientIDMode="Static">
                        </asp:DropDownList>
                        <div class="form-helpers">
                            Select your dish type, you can select multiple Taste types
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="DropDownListSideDishes">
                        Need Any Side Dish ?
                    </label>
                    <div class="controls">
                        <asp:HiddenField runat="server" ID="HiddenFieldSideDishes" />
                        <input type="text" id="tagsSideDishes" name="tagsSideDishes" placeholder="Side Dishes"
                            class="tm-inputSideDishes" />
                        <div class="form-helpers">
                            write your fav side dishes, [Press Enter or Tab or ',' after every ingredient]
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="datetimepicker">
                        At What Time ?
                    </label>
                    <div class="controls">
                        <asp:HiddenField runat="server" ID="HiddenFieldDeliveryTime" />
                        <div id="datetimepicker1" class="input-append">
                            <input data-format="MM/dd/yyyy hh:mm:ss" type="text"></input>
                            <span class="add-on"><i data-time-icon="icon-time" data-date-icon="icon-calendar"></i>
                            </span>
                        </div>
                        <div class="form-helpers">
                            your hunger time.
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="numberOfPeople">
                        For how many people ?
                    </label>
                    <div class="controls">
                        <div id="Div1" class="input-append">
                            <asp:TextBox runat="server" ID="numberOfPeople"></asp:TextBox>
                            <span class="add-on"><i class="icon-user"></i></span>
                        </div>
                        <div class="form-helpers">
                            for how many people do you want it.
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="TextAdditionalInformation">
                        Delivery Type
                    </label>
                    <div class="controls">
                        <asp:RadioButton runat="server" ID="CheckboxHomeDelivery" GroupName="Delivery" />
                        Home Delivery
                        <br />
                        <asp:RadioButton runat="server" ID="CheckboxPickUpLocation" GroupName="Delivery" />
                        Pickup Location
                        <br />
                        <div id="UserPostalStyle" runat="server" visible="False">
                            <div class="control-group">
                                <label class="control-label" for="UserAddressAddressLine1" style="width: 120px;">
                                    Address Line 1 :
                                </label>
                                <div class="controls" style="margin-left: 140px">
                                    <asp:TextBox runat="server" ID="UserAddressAddressLine1" Width="80%"></asp:TextBox>
                                    <div class="form-helpers">
                                        your unit number, building number, society number
                                    </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="UserAddressAddressLine2" style="width: 120px;">
                                    Address Line 2 :
                                </label>
                                <div class="controls" style="margin-left: 140px">
                                    <asp:TextBox runat="server" ID="UserAddressAddressLine2" Width="80%"></asp:TextBox>
                                    <div class="form-helpers">
                                        street name, Area Name
                                    </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="UserAddressAddressPostalCode" style="width: 120px;">
                                    Postal Code :
                                </label>
                                <div class="controls" style="margin-left: 140px">
                                    <asp:TextBox runat="server" ID="UserAddressAddressPostalCode" Width="80%"></asp:TextBox>
                                    <div class="form-helpers">
                                        Postal code/ Pin code
                                    </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="UserCityDropDownList" style="width: 120px;">
                                    City :
                                </label>
                                <div class="controls" style="margin-left: 140px">
                                    <asp:TextBox runat="server" ID="CityTextBox" Width="80%"></asp:TextBox>
                                    <div class="form-helpers">
                                        your city
                                    </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="UserStateDropDownList" style="width: 120px;">
                                    State :
                                </label>
                                <div class="controls" style="margin-left: 140px">
                                    <asp:TextBox runat="server" ID="StateTextBox" Width="80%"></asp:TextBox>
                                    <div class="form-helpers">
                                        your state
                                    </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="TextAreaPickupLocation" style="width: 120px;">
                                    Any Land mark :
                                </label>
                                <div class="controls" style="margin-left: 140px">
                                    <asp:TextBox runat="server" ID="TextAreaPickupLocation" TextMode="MultiLine" Rows="5"></asp:TextBox>
                                    <div class="form-helpers">
                                        providing information like landmark or famous place near your area will help to
                                        locate.
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="User_Pickup_Address">
                        </div>
                        <div class="form-helpers">
                            Select how you want your dish to be delivered , At home or at pickup location,Please
                            note if you have not edited your HOME Address in your profile. we recommend you
                            to do so.
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="DropDownListAvoidingredients">
                        Ingredients to avoid ?
                    </label>
                    <div class="controls">
                        <asp:HiddenField runat="server" ID="HiddenFieldIngredientToAvoide" />
                        <input type="text" id="tagsIngredientToAvoide" name="tagsIngredientToAvoide" placeholder="Ingredients To Avoide"
                            class="tm-inputAvoidingredients" />
                        <div class="form-helpers">
                            which ingredients you want to avoid, [Press Enter or Tab or ',' after every ingredient]
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="TextAdditionalInformation">
                        Additional Information
                    </label>
                    <div class="controls">
                        <asp:TextBox runat="server" ID="TextAdditionalInformation" TextMode="MultiLine" Rows="5"></asp:TextBox>
                        <div class="form-helpers">
                            Provide Additional information on how you want your dish, shoud it be DRY or GRAVY.
                            ect...ect..
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </form>
    <script type="text/javascript">
        $(document).ready(function () {
            var arrayTasteDropDownList = $("#HiddenFieldSideDishes").val().split(',');
            $("#TasteDropDownList").select2().select2('val', arrayTasteDropDownList);
            $(".tm-inputAvoidingredients").tagsManager({ prefilled: [$("#HiddenFieldIngredientToAvoide").val()] });
            $(".tm-inputSideDishes").tagsManager({ prefilled: [$("#HiddenFieldSideDishes").val()] });
            $('#datetimepicker1').datetimepicker({
                language: 'en',
                pick12HourFormat: true
            });
            var dt = new Date($("#HiddenFieldDeliveryTime").val());
            var picker = $('#datetimepicker1').data('datetimepicker');
            picker.setLocalDate(dt);
        });
    </script>
</body>
</html>
<script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
