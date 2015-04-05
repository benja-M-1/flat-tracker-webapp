angular.module '%module%.auth'
.config ($stateProvider) ->
  $stateProvider
  .state "auth",
    abstract: true
    template: "<ui-view/>"
    data:
      requireLogin: false
  .state "auth.login",
    url: "/login"
    templateUrl: "auth/views/login.html"
    controller: "LoginController"
  .state "auth.logout",
    url: "/logout"
    controller: "LogoutController"
  .state "auth.signup",
    url: "/signup"
    templateUrl: "auth/views/signup.html"
    controller: "SignupController"