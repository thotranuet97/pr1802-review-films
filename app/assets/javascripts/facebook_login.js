$(document).on('turbolinks:load', function() {
  $('#facebook-login').on('click', function () {
    loginPopup();
  });

  function loginPopup() {
    FB.login(function (response) {
      if (response.authResponse) {
        getUserInfo();
      }
    }, { scope: 'email,user_birthday' });
    // birthday is important
  }

  function getUserInfo() {
    FB.api('/me', function (response) {
      // this is other info you can get from facebook.

      // email: response.email, name: response.name, bio: response.bio,  
      // location: response.location.name, uid: response.id, gender: 
      // response.gender, birthdate: response.birthday
      // this ajax is optional (only if you want to hit server with facebook  
      // info.) 

      $.ajax({
        type: "PUT",
        url: "sessions/update_facebook_info",
        data: { email: response.email, name: response.name, bio: response.bio, 
          location: response.location.name, uid: response.id, gender: response.gender, 
          birthdate: response.birthday },
        statusCode: {
          404: function () {
            alert("page not found");
          },
          200: function () {
            $('#status-login').html("http://localhost:3000/en")
          },
          201: function (msg) {
            $('.error-vote-poup').html(msg.responseText)
          },
          400: function (msg) {
            $('.error-vote-poup').html(msg.responseText)
          }
        }
      });
    });
  }
})

$(document).ready(function(){
  window.fbAsyncInit = function () {
    FB.init({ appId: '521816361595741', cookie: true, xfbml: true, oauth: true });
    if (typeof facebookInit == 'function') {
      facebookInit();
    }
  };

  (function(d){
    var js, id = 'facebook-jssdk'; if (d.getElementById(id)) {return;}
    js = d.createElement('script'); js.id = id; js.async = true;
    js.src = "//connect.facebook.net/en_US/all.js";
    d.getElementsByTagName('head')[0].appendChild(js);
  }(document));
});
