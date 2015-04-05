angular.module '%module%.auth'
.controller 'LoginController', [
  "$scope",
  "$rootScope",
  "$state",
  "Parse"
  ($scope, $rootScope, $state, Parse) ->
    $scope.user = {}
    $scope.submit = (user) ->
      Parse.auth.login(user.username, user.password)
      .then( () ->
        $rootScope.user = Parse.auth.currentUser
        $state.go "ad.list"
      , (error) ->
        $scope.error = error
      )
]
