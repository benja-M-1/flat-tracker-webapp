angular.module "%module%.auth"
.factory 'ParseCustomUser', (ParseDefaultUser) ->
  class User extends ParseDefaultUser
    @configure 'users', 'username', 'password', 'email'