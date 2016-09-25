<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AutheticationRedirection.aspx.cs" Inherits="KhanawalApplication.AutheticationRedirection" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
//        function refreshAndClose(code) {
//            window.opener.location.href = window.opener.location.href + "?Code=" + code;
//            window.close();
//        }

        function refreshAndClose() {
            window.opener.location.href = window.opener.location.href;
            window.close();
        }
        

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <input type="button"  value="CloseAndRefreshParent" onclick="refreshAndClose()" />
    </div>
    </form>
</body>
</html>
