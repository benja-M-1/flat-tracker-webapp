angular.module "%module%", [
  "ui.router",
  "Parse",
  "angular-moment",
  "ngIntercom",
  "%module%.common",
  "%module%.auth",
  "%module%.ad",
  "%module%.user",
]

.config ($stateProvider, $urlRouterProvider, $intercomProvider, configuration, ParseProvider) ->
  ParseProvider.initialize configuration.parse.app_id, configuration.parse.rest_key

  $intercomProvider.appID configuration.intercom.app_id
  $intercomProvider.asyncLoading true ;

  $urlRouterProvider.otherwise "/ads"

.run ($rootScope, $moment, $intercom) ->
  $moment.locale "fr"

  if $rootScope.user
    $intercom.boot
      email:      $rootScope.user.email
      name:       $rootScope.user.username
      created_at: $rootScope.user.createdAt
      user_id:    $rootScope.user.objectId

  $rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error) ->
    console.log error

  $rootScope.$on '$stateNotFound', (event, unfoundState, fromState, fromParams) ->
    console.log unfoundState