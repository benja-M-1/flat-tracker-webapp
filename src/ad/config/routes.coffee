angular.module "%module%.ad"
.config ($stateProvider) ->
  $stateProvider
  .state "ad",
    abstract: true
    template: "<ui-view/>"
    data:
      requireLogin: true
  .state "ad.list",
    url: "/ads"
    templateUrl: "ad/views/list.html"
    controller: "ListController"
