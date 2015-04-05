angular.module '%module%.auth'
.controller 'LogoutController', [
  '$scope',
  '$rootScope',
  '$state',
  'Parse'
  ($scope, $rootScope, $state, Parse) ->
    Parse.auth.logout()
    $rootScope.user = null
    $state.go "auth.login"
]
