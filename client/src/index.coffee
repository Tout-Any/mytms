angular.module('tmsApp', ['ngRoute'])
.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.when('/login', {

    templateUrl: './app/login/index.html',
    controller: 'LoginCtrl'

  }).when('/regist',{
    templateUrl: './app/regist/index.html',
    controller: 'RegistCtrl'
  }).when('/',{
    templateUrl: './app/index/index.html',
    controller: 'IndexCtrl'
  })
])
.run(['$location',($location) ->
    $location.path('/login').replace()
])