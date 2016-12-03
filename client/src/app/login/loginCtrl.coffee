angular.module('tmsApp')
  .controller('LoginCtrl',['$scope','$http','$location','tmsUtils'
  ($scope,$http,$location,tmsUtils) ->
    $scope.userEntity={
      username:'',
      password:'',
      rememberMe:false
    }

    $scope.doLogin= ->
      $http.post("#{Tms.apiAddr}/api/user/login",$scope.userEntity)
      .then((res) ->
        console.log($scope.userEntity)
        $location.path('/').replace()
      ,
        tmsUtils.processHttpError
      )

])