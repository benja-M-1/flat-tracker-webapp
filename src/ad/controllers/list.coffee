angular.module "%module%.ad"
.controller 'ListController', [
  '$scope'
  'Ad',
  ($scope, Ad) ->
    Ad.query(
      where:
        "user":
          __type: "Pointer"
          className: "_User"
          objectId: $scope.user.objectId
      include: 'user'
    ).then (ads) ->
      $scope.ads = ads
]