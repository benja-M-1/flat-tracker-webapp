angular.module "%module%.ad"
.factory 'Ad', (Parse) ->
  class Ad extends Parse.Model
    @configure "Ad", "title", "url"

    getURI: () ->
      return URI(this.url)

