<%@ Page Language="C#" AutoEventWireup="true" Inherits="KhanawalApplication.Default2"
    CodeBehind="Default2.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <input type="button" onclick="iterateCustom()" value="click me" /><asp:Button 
            ID="Button1" runat="server" onclick="Button1_Click" Text="Button" />
        <asp:Button ID="Button2" runat="server" Text="Post to wall" 
            onclick="Button2_Click" />
&nbsp;<ul id="sortable">
            <li id="Li1">1</li>
            <li id="Li2">2</li>
            <li id="Li3">3</li>
            <li id="Li4">4</li>
        </ul>
    </div>
    </form>
    <script type="text/javascript">
        var CodeObject = [];
        var myString;
        $(function () {
            
            var objCode = new Object();
            objCode.Code = "1";
            objCode.Value = "1";
            CodeObject.push(objCode);

            objCode = new Object();
            objCode.Code = "2";
            objCode.Value = "2";
            CodeObject.push(objCode);
            
            myString = JSON.stringify(CodeObject);

            
        });

        function iterateCustom() {
            var test = "";
            $("#sortable > li").each(function (index) {
                test = test + $(this).attr("id");
            });
            alert(test);
        }

        function postDataCustom() {
            $.ajax({
                type: "POST",
                url: "Default2.aspx/SaveOrderInDb",
                data: "{codeObjects: " + myString + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    alert('success');
                },
                error: function (msg) {
                    debugger;
                    alert('fail');
                }
            });
        }
    </script>
</body>
</html>
