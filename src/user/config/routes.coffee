angular.module "%module%.user"
.config ($stateProvider) ->
  $stateProvider
  .state "user",
    abstract: true
    template: "<ui-view/>"
    data:
      requireLogin: true
  .state "user.profile",
    url: "/profile"
    templateUrl: "user/views/profile.html"
    controller: "ProfileController"
