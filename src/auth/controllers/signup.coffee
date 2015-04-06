angular.module '%module%.auth'
.controller 'SignupController', [
  "$scope",
  "$rootScope",
  "$state",
  "Parse"
  ($scope, $rootScope, $state, Parse) ->
    $scope.user = {}
    $scope.submit = (user) ->
      Parse.auth.register(user.username, user.password).then ->
        $rootScope.user = Parse.auth.currentUser
        $rootScope.user.email = user.email
        $rootScope.user.fullname = user.username
        $rootScope.user.save()

        $state.go "ad.list"
      , (error) ->
        $cope.error = error
]
