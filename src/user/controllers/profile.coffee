angular.module "%module%.user"
.controller "ProfileController", [
  "$scope",
  "Parse",
  ($scope, Parse) ->
    $scope.submit = (user) ->
      console.log user
]