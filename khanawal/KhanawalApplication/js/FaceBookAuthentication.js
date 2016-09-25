

window.fbAsyncInit = function () {
    FB.init({
        appId: '1376600365907104', // App ID
        channelUrl: 'http://Khanawal.com/channel.html', // Channel File
        status: true, // check login status
        cookie: true, // enable cookies to allow the server to access the session
        xfbml: true  // parse XFBML
    });


    //Test - 1376600365907104
    //Prod - 1396865703858934

    // Here we subscribe to the auth.authResponseChange JavaScript event. This event is fired
    // for any authentication related change, such as login, logout or session refresh. This means that
    // whenever someone who was previously logged out tries to log in again, the correct case below 
    // will be handled. 
    FB.Event.subscribe('auth.authResponseChange', function (response) {
        // Here we specify what we do with the response anytime this event occurs. 
        if (response.status === 'connected') {
            // The response object is returned with a status field that lets the app know the current
            // login status of the person. In this case, we're handling the situation where they 
            // have logged in to the app.

            //GetUserData();
        } else if (response.status === 'not_authorized') {
            // In this case, the person is logged into Facebook, but not into the app, so we call
            // FB.login() to prompt them to do so. 
            // In real-life usage, you wouldn't want to immediately prompt someone to login 
            // like this, for two reasons:
            // (1) JavaScript created popup windows are blocked by most browsers unless they 
            // result from direct interaction from people using the app (such as a mouse click)
            // (2) it is a bad experience to be continually prompted to login upon page load.

            loginWithPublishStream();
        } else {
            // In this case, the person is not logged into Facebook, so we call the login() 
            // function to prompt them to do so. Note that at this stage there is no indication
            // of whether they are logged into the app. If they aren't then they'll see the Login
            // dialog right after they log in to Facebook. 
            // The same caveats as above apply to the FB.login() call here.
            loginWithPublishStream();
        }
    });
};



// Load the SDK asynchronously
(function (d) {
    var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
    if (d.getElementById(id)) { return; }
    js = d.createElement('script'); js.id = id; js.async = true;
    js.src = "//connect.facebook.net/en_US/all.js";
    ref.parentNode.insertBefore(js, ref);
} (document));

function loginWithPublishStream() {
    FB.login(function (response) {
        if (response.authResponse) {
            GetUserData();
        }
    }, { scope: 'email,user_location,user_birthday,publish_stream,user_about_me' });
}


// Here we run a very simple test of the Graph API after login is successful. 
// This testAPI() function is only called in those cases. 
//string id, string userName, string firstName, string lastName, string locationName, string email, string birthdate, string gender
function GetUserData() {
    var id, userName, firstName, lastName, locationName, email, birthdate, gender,bio;
    FB.api('/me', function (response) {
        id = response.id;
        userName = response.username;
        firstName = response.first_name;
        lastName = response.last_name;
        if (typeof response.location != "undefined") {
            locationName = response.location.name;
        }
        email = response.email;
        birthdate = response.birthday;
        gender = response.gender;

        if (typeof response.bio != "undefined") {
            bio = response.bio;
        }

        var pageUrl = $("#HiddenFieldPageUserName").val() + "/" + "AuthenticateUser";

        var postData = "{id:'" + id +
                            "',userName:'" + userName +
                            "',firstName:'" + firstName +
                            "',lastName:'" + lastName +
                            "',locationName:'" + locationName +
                            "',email:'" + email +
                            "',birthdate:'" + birthdate +
                            "',bio:'" + bio +
                            "',gender:'" + gender + "'}";

        $.ajax({
            type: "POST",
            url: pageUrl,
            data: postData,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            beforeSend: function () {
                //Mask page
            },
            complete: function () {
                //remove Mask

            },
            success: function (msg) {
                
                if (msg.d.IsTermsAggred == null) {
                    window.location.href = "/EditProfile.aspx";
                } else if (msg.d.IsTermsAggred == false) {
                    window.location.href = "/EditProfile.aspx";
                }

                if (msg.d.TopNavigationHtml != null) {
                    if (msg.d.AuthStatus != "true") {
                        if (msg.d.TopNavigationHtml.length !=0 ) {
                            $("#DivTopNavigationContainer").replaceWith(msg.d.TopNavigationHtml);
                        }
                        $('.js-activated').dropdownHover().dropdown();

                        if ($("#HiddenFieldReloadPage").val() == "1") {
                            location.reload();
                        } else {
                            $.event.trigger({
                                type: "AuthSuccess",
                                message: msg,
                                time: new Date()
                            });

                        }
                    }

                }

            }
        });

    });
}




    