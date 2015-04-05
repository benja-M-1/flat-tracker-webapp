angular.module "%module%.auth", [
  "ui.router"
  "%module%.ad"
  "Parse"
]
.run [
  '$rootScope',
  '$state',
  'Parse'
  ($rootScope, $state, Parse) ->
    Parse.auth.resumeSession()
    $rootScope.user = Parse.auth.currentUser

    $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
      if toState.data.requireLogin && !$rootScope.user
        event.preventDefault()
        $state.go "auth.login"
]