<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ListingSearchUsers.ascx.cs"
    Inherits="KhanawalApplication.ListingSearchUsers" %>

<style>
    .btn-large-navbar
    {
        padding: 9px 14px;
    }
    .navbar-inner h5 span
    {
        float: right;
    }
    
    .navbar-inner h5
    {
        cursor: pointer;
    }
    
    .search_result
    {
        padding-top: 10px;
        height: 110px;
        border-bottom-style: solid;
        border-bottom-width: 1px;
        border-bottom-color: #d4d4d4;
        padding-bottom: 5px;
    }
    
    .search_result_empty
    {
        padding-top: 10px;
        padding-left: 20px;
        height: 30px;
        border-bottom-style: solid;
        border-bottom-width: 1px;
        border-bottom-color: #d4d4d4;
        padding-bottom: 5px;
    }
    
    .search_result:hover
    {
        background-color: #F9F9F9;
    }
    
    
    .search_result .search_result_image
    {
        float: left;
        height: 50px;
    }
    
    .search_result .search_result_info
    {
        float: left;
        margin-left: 10px;
        font-size: 15pt;
        height: 100px;
        position: relative;
        min-width: 150px;
    }
    
    .search_result .search_result_pricing
    {
        float: right;
        font-size: 15pt;
        position: relative;
        height: 100px;
        width: 150px;
        text-align: right;
    }
    .search_result_pricing_manage_info
    {
        position: absolute;
        bottom: 0;
        left: 0;
        margin-bottom: 5px;
    }
    .search_result_info_review
    {
        position: absolute;
        bottom: 0;
        left: 0;
        margin-bottom: 5px;
    }
    
    .divSaveRequestNotification
    {
        margin-top: 5px;
    }
    
    .form-helpers
    {
        margin-top: 6px;
        margin-bottom: 4px;
        line-height: 16px;
        color: #c8c8c8;
    }
</style>
<div>
    <div class="navbar-inner" style="margin-bottom: 10px">
        <h5>
            <div id="divMoreInformation">
                <div class="pull-left">
                    More information about dish
                </div>
                <div class="pull-right">
                    >
                </div>
            </div>
        </h5>
    </div>
    <div class="form-horizontal" id="divDishMoreInformationContent">
        <div class="control-group">
            <label class="control-label" for="RequestType">
                Type ?
            </label>
            <div class="controls">
                <input type="radio" id="VegRequestType" name="FoodType" value="veg" />
                Veg
                <br />
                <input type="radio" id="NonVegRequestType" name="FoodType" value="NonVeg" />
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
                <input type="text" id="RequestCostTextBox" name="RequestCostTextBox" />
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
                <input type="text" id="tagsSideDishes" name="tagsSideDishes" placeholder="Side Dishes"
                    class="tm-inputSideDishes" />
                <div class="form-helpers">
                    write your fav side dishes, [Press Enter or Tab or ',' after every ingredient]
                </div>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="TasteDropDownList">
                At What Time ?
            </label>
            <div class="controls">
                <div id="datetimepicker" class="input-append">
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
            <label class="control-label" for="TasteDropDownList">
                For how many people ?
            </label>
            <div class="controls">
                <div id="Div1" class="input-append">
                    <input type="text" name="numberOfPeople" id="numberOfPeople" />
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
                <input type="radio" id="CheckboxHomeDelivery" name="DeliveryType" value="HomeDelivery" />
                Home Delivery
                <br />
                <input type="radio" id="CheckboxPickUpLocation" name="DeliveryType" value="PickUpLocation" />
                Pickup Location
                <br />
                <div id="UserPostalStyle" style="display: none">
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
                        <label class="control-label" for="UserStateDropDownList" style="width: 120px;">
                            Any Land mark :
                        </label>
                        <div class="controls" style="margin-left: 140px">
                            <textarea name="TextAreaPickupLocation" id="TextAreaPickupLocation" rows="5" style="width: 80%;" />
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
                <textarea rows="5" style="width: 80%" id="TextAdditionalInformation" name="TextAdditionalInformation"
                    placeholder="Additional Information about dish" />
                <div class="form-helpers">
                    Provide Additional information on how you want your dish, shoud it be DRY or GRAVY.
                    ect...ect..
                </div>
            </div>
        </div>
    </div>
</div>
<div class="alert alert-info">
    Below users in your area are interested to serve your dish, select and notify them
    about your request
</div>
<div>
    <input type="button" data-loading-text="Please Wait.." data-complete-text="Notify Selected User"
        value="Notify Selected Users" class="btn btn-primary" id="ButtonNotifySelectedUsers"
        onclick="CheckAuthThenSaveRequestAndNotifyUser()" />
    <input type="button" value="Notify All Users" onclick="CheckAuthThenSaveRequestAndNotifyAllUsers()"
        class="btn btn-primary" id="ButtonNotifyAllUsers" onclick="" />
</div>
<div class="alert divSaveRequestNotification" id="divSaveRequestNotification" style="margin-top: 5px;
    display: none">
</div>
<asp:ListView runat="server" ID="ListingsListview">
    <LayoutTemplate>
        <div id="ListingSearchUserDiv">
            <asp:PlaceHolder ID="itemplaceholder" runat="server" />
        </div>
    </LayoutTemplate>
    <ItemTemplate>
        <div class="search_result">
            <div class="search_result_image">
                <a href="UserProfile.aspx?ID=<%#Eval("User.UserID")%>">
                    <div style="border: 1px; border-style: solid; padding: 4px;">
                        <img alt="<%#Eval("User.first_name")%>" style="min-height: 100px; width: 100px; height: 100px;
                            min-width: 100px;" src="<%#Eval("User.ImageUrl")%>/picture?type=large">
                    </div>
                </a>
            </div>
            <div class="search_result_info">
                <a href="UserProfile.aspx?ID=<%#Eval("User.UserID")%>">
                    <%#Eval("User.first_name")%></a>
            </div>
            <div class="search_result_pricing">
                <div>
                    <input type="checkbox" representsuserid="true" id="<%#Eval("User.UserID")%>" />
                </div>
            </div>
        </div>
    </ItemTemplate>
    <EmptyDataTemplate>
        <div class="search_result_empty">
            No users found in your area.
        </div>
    </EmptyDataTemplate>
</asp:ListView>
<script type="text/javascript">
    $(document).ready(function () {

        $("#divMoreInformation").click(function () {
            $("#divDishMoreInformationContent").toggle();
        });



        $("#CheckboxPickUpLocation").click(function () {
            if ($(this).is(':checked')) {
                $("#UserPostalStyle").css("display", "block");
            }
        });

        $("#CheckboxHomeDelivery").click(function () {
            if ($(this).is(':checked')) {
                $("#UserPostalStyle").css("display", "none");
            }
            CheckIfUserHasAddress();
        });
    });
    
</script>