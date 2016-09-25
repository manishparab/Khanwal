<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateCalendar.aspx.cs"
    Inherits="KhanawalApplication.UpdateCalendar" %>
    
<%@ Register TagPrefix="ucTopNavigation" TagName="TopNavigationUserControl" Src="~/TopNavigationUserControl.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script src="js/vendor/bootstrap.min.js"></script>
    <script src="js/jquery.validate.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?v=3&sensor=true"></script>
    <script src="js/bootstrap-datepicker.js" type="text/javascript"></script>
    <link href="css/select2/bootstrap-combined.min.css" rel="stylesheet" type="text/css" />
    <link href="css/Custom.css" rel="stylesheet" type="text/css" />
    <link href="css/datepicker.css" rel="stylesheet" type="text/css" />
    <style>
        .UserBusy
        {
            background-color: #E07272;
        }
        .UserAvailable
        {
            background-color: #ACDBA8;
        }
        .PastDate
        {
            background-color: #F9F9F9;
        }
        #tblCalender td
        {
            height: 90px;
            width: 75px;
            padding: 0;
            margin: 0;
            text-align: left;
            cursor: pointer;
            font-size: 15px;
        }
        
        .containerCalendar
        {
            position: relative;
            height: 100%;
        }
        
        .bg
        {
            position: absolute;
            top: 0;
            bottom: 50%;
            width: 100%;
        }
        
        
        
        .bgBottom
        {
            position: absolute;
            top: 50%;
            bottom: 0;
            width: 100%;
        }
        
        .contentCalendar
        {
            position: relative;
            z-index: 1;
            text-align: right;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" style="margin-top: 60px">
    <ucTopNavigation:TopNavigationUserControl ReloadPage="True" IsAuthenticated="True" ID="TopNavigationUserControl1" runat="server" />
    <div class="container">
        <div style="width: 200px;" class="well pull-left">
            <ul class="nav nav-list">
                <li><a href="DashBoard.aspx">Dashboard</a></li>
                <li><a href="Inbox.aspx">Inbox</a></li>
                <li><a href="#">My Dishes</a></li>
                <li><a href="MyRequests.aspx">My Requests</a></li>
                <li class="active"><a href="#">My Calendar</a></li>
            </ul>
        </div>
        <div class="pull-left" style="margin-left: 20px;width: 70%">
            <div class="alert alert-success">
                <div class="form-horizontal">
                    <div class="control-group">
                        <label class="control-label" for="CancellationDropDownList">
                        </label>
                        <div class="controls">
                            Calendar for Month of
                            <%: DateTime.Now.Date.ToString("MMM/yyyy")  %>
                        </div>
                        <div class="controls" style="display: none">
                            <div class="input-append date form-inline" id="dp3" data-date="03-2013" data-date-format="mm/yyyy"
                                data-date-viewmode="months" data-date-minviewmode="months">
                                <input class="span2" size="16" type="text" value="03-2013" readonly>
                                <span class="add-on"><i class="icon-calendar"></i></span>
                            </div>
                            &nbsp;&nbsp;&nbsp; <span id="SelectedMonth"></span>
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <asp:ListView runat="server" ItemPlaceholderID="itemPlaceHolder" GroupItemCount="7"
                    GroupPlaceholderID="groupplaceHolder" ID="userCalenderListview">
                    <LayoutTemplate>
                        <table id="tblCalender" class="table table-bordered CalenderTable">
                            <tbody>
                                <tr>
                                    <th>
                                        Mon
                                    </th>
                                    <th>
                                        Tue
                                    </th>
                                    <th>
                                        Wed
                                    </th>
                                    <th>
                                        Thu
                                    </th>
                                    <th>
                                        Fri
                                    </th>
                                    <th>
                                        Sat
                                    </th>
                                    <th>
                                        Sun
                                    </th>
                                </tr>
                                <asp:PlaceHolder runat="server" ID="groupplaceHolder"></asp:PlaceHolder>
                            </tbody>
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <td>
                            <div class="containerCalendar">
                                <div class='<%# Eval("StatusfirstHalf") %> bg' half="upper" useravailbility='check'
                                    date='<%# Eval("CalendarDate") %>'>
                                    <asp:Literal runat="server" ID="CalendarDatelitral" Text='<%# Eval("CalendarDate") %>'></asp:Literal></div>
                                <div class='<%# Eval("StatusLowerHalf") %> bgBottom' half="second" useravailbility='check'
                                    date='<%# Eval("CalendarDate") %>'>
                                </div>
                            </div>
                        </td>
                    </ItemTemplate>
                    <GroupTemplate>
                        <tr style="padding: 0; margin: 0">
                            <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
                        </tr>
                    </GroupTemplate>
                </asp:ListView>
            </div>
            <div id="DivStatus" class="">
            </div>
            <br />
            <input type="button" id="btnSave" value="Save Calendar" data-loading-text="Please Wait.."
                data-complete-text="Save Calendar" onclick="SaveCalendar()" class="btn btn-primary" />
        </div>
    </div>
     
    </form>
</body>
<script type="text/javascript">
    var nowTemp = new Date();
    var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
    var monthNames = ["January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"];

    $(function () {
        var listingOrderDate = $("#dp3").datepicker({
            onRender: function (date) {
                return date.valueOf() < now.valueOf() ? 'disabled' : '';
            }
        }).on('changeDate', function (ev) {

            var newDate = new Date(ev.date);
            var selectedDate = newDate.getDay();
            $("#SelectedMonth").text(monthNames[newDate.getMonth()] + " " + newDate.getFullYear());
            //alert($('div[date="12"]').length);
            listingOrderDate.hide();

        }).data('datepicker');
    });

    $('div[useravailbility="check"]').click(function (event) {
        var $target = $(event.target);
        if ($target.is(':input')) {
            return true;
        }
        if ($(this).find('input:checkbox').length > 0) {
            var checkbox = $(this).find('input:checkbox');
            if (checkbox.prop("checked")) {
                checkbox.prop("checked", false);
            } else {
                {
                    checkbox.prop("checked", true);
                }
            }

        }
        return true;
    });



    function SaveCalendar() {
        var userCalendarEnity = [];
        var myString;
        var objCode;
        $("#btnSave").button('loading');
        $(".containerCalendar input[type=checkbox]").each(function (index) {
            var parentDiv = $(this).parent();
            objCode = new Object();
            objCode.CalendarDate = parentDiv.attr("date");
            if (parentDiv.attr("half") == "upper") {

                if (parentDiv.hasClass("UserBusy")) {
                    objCode.StatusfirstHalf = "busy";
                    objCode.StatusLowerHalf = "";
                } else {
                    objCode.StatusfirstHalf = "available";
                    objCode.StatusLowerHalf = "";
                }

            } else {

                if (parentDiv.hasClass("UserBusy")) {
                    objCode.StatusfirstHalf = "";
                    objCode.StatusLowerHalf = "busy";
                } else {
                    objCode.StatusfirstHalf = "";
                    objCode.StatusLowerHalf = "available";
                }

            }
            userCalendarEnity.push(objCode);
        });

        myString = JSON.stringify(userCalendarEnity);



        $.ajax({
            type: "POST",
            url: "UpdateCalendar.aspx/UpdateUserCalendar",
            data: "{userCalendarEnity: " + myString + "}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
                $("#btnSave").button('complete');
                $("#DivStatus").fadeIn('slow').removeClass("alert-error").addClass("alert alert-success").text("Calendar updated successfully").delay(5000).fadeOut(); ;
            },
            error: function (msg) {
                $("#btnSave").button('complete');
                $("#DivStatus").fadeIn('slow').removeClass("alert-success").addClass("alert alert-error").val("Error occured, please try again").delay(5000).fadeOut(); ;
                debugger;
            }
        });

    }

    $('div[useravailbility="check"]').hover(
            function () {
                var checkboxhover;
                if ($(this).hasClass("UserAvailable")) {
                    if ($(this).find('input:checkbox').length > 0) {
                        checkboxhover = $(this).find('input:checkbox');
                        if (checkboxhover.prop("checked")) {
                            // dont do anything
                        }
                    } else {
                        $(this).removeClass("UserAvailable");
                        $(this).addClass("UserBusy");
                        if ($(this).find('input:checkbox').length == 0) {
                            $(this).append("<input type='checkbox' style='position: absolute;top: 60%;bottom: 2px;left:85%'>");
                        }
                    }
                    return true;
                }

                if ($(this).hasClass("UserBusy")) {
                    if ($(this).find('input:checkbox').length > 0) {
                        checkboxhover = $(this).find('input:checkbox');
                        if (checkboxhover.prop("checked")) {

                        }
                    } else {
                        $(this).removeClass("UserBusy");
                        $(this).addClass("UserAvailable");
                        if ($(this).find('input:checkbox').length == 0) {
                            $(this).append("<input type='checkbox' style='position: absolute;top: 60%;bottom: 2px;left:85%'>");
                        }
                    }
                }
            },
            function () {
                var checkbox;
                if ($(this).hasClass("UserBusy")) {

                    if ($(this).find('input:checkbox').length > 0) {
                        checkbox = $(this).find('input:checkbox');
                        if (!checkbox.prop("checked")) {
                            checkbox.remove();
                            $(this).removeClass("UserBusy");
                            $(this).addClass("UserAvailable");
                        }

                    }
                    return true;
                }

                if ($(this).hasClass("UserAvailable")) {
                    if ($(this).find('input:checkbox').length > 0) {
                        checkbox = $(this).find('input:checkbox');
                        if (!checkbox.prop("checked")) {
                            checkbox.remove();
                            $(this).removeClass("UserAvailable");
                            $(this).addClass("UserBusy");
                        }

                    }
                }
            }
        );

</script>
<script src="js/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
</html>
