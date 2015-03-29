angular.module('flatTracker', [
    'flatTracker.config',
    'flatTracker.templates',
    'ui.router',
    'parse-angular',
    'parse-angular.enhance',
    'angular-moment',
    'ngIntercom'
])
    .config(function ($stateProvider, $urlRouterProvider, $intercomProvider, configuration) {
        Parse.initialize(configuration.parse.app_id, configuration.parse.js_key);
        $intercomProvider.appID(configuration.intercom.app_id);
        $intercomProvider.asyncLoading(true);

        $urlRouterProvider.otherwise("/");

        $stateProvider
            .state("app", {
                url: "/",
                templateUrl: "app.html",
                controller: "AppController",
                data: {
                    requireLogin: true
                }
            })
            .state("login", {
                url: "/login",
                templateUrl: "login.html",
                controller: "LoginController",
                data: {
                    requireLogin: false
                }
            })
            .state("logout", {
                url: "/logout",
                controller: "LogoutController",
                data: {
                    requireLogin: false
                }
            })
            .state("signup", {
                url: "/signup",
                templateUrl: "signup.html",
                controller: "SignupController",
                data: {
                    requireLogin: false
                }
            })
        ;
    })
    .run(['$rootScope', '$state', '$moment', '$intercom', function ($rootScope, $state, $moment, $intercom) {
        $moment.locale('fr');
        $rootScope.user = Parse.User.current();

        $rootScope.$on('$stateChangeStart', function (event, toState, toParams) {
            var requireLogin = toState.data.requireLogin;

            if (requireLogin && !$rootScope.user) {
                event.preventDefault();
                $state.go("login");
            } else {
                $intercom.boot({
                    email: $rootScope.user.get('email'),
                    name: $rootScope.user.get('username'),
                    created_at: $rootScope.user.createdAt,
                    user_id: $rootScope.user.objectId
                });
            }
        });
    }])
    .filter('debug', function() {
        return function(input) {
            console.log(input);
        };
    })
    .factory('Ad', function () {
        return Parse.Object.extend({
            className: "Ad",
            attrs: ['title', 'url'],
            getURI: function () {
                return URI(this.get('url'));
            }
        });
    })
    .factory('AdCollection', ['$rootScope', 'Ad', function ($rootScope, Ad) {
        return Parse.Collection.extend({
            model:Ad,
            query: (new Parse.Query(Ad)).equalTo('user', $rootScope.user).include('user')
        });
    }])
    .controller('AppController', ['$scope', 'AdCollection', function ($scope, AdCollection) {
        $scope.ads = new AdCollection();
        $scope.ads.fetch();
    }])
    .controller('LoginController', ['$scope', '$rootScope', '$state', function ($scope, $rootScope, $state) {
        $scope.submit = function (username, password) {
            var user = new Parse.User({
                username: username,
                password: password
            });

            return user.logIn().then(function (user) {
                $rootScope.user = user;
                $state.go("app");
            }, function (user, error) {
                $scope.error = error;
            });
        };
    }])
    .controller('LogoutController', ['$scope', '$rootScope', '$state', function ($scope, $rootScope, $state) {
        Parse.User.logOut().then(function () {
            $rootScope.user = null;
            $state.go("app");
        });
    }])
    .controller('SignupController', ['$scope', '$rootScope', '$state', function ($scope, $rootScope, $state) {
        $scope.submit = function (username, email, password) {
            var user = new Parse.User();
            user.set('username', username);
            user.set('email', email);
            user.set('password', password);

            user.signUp().then(function (user) {
                $rootScope.user = user;
                $state.go("app");
            });
        }
    }])
;
