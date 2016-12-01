angular.module('tmsApp')
  .controller('RegistCtrl',['$scope',($scope) ->
      $scope.userEntity={
              username:'',
              password:'',
              password2:'',
      }
      $scope.doReg= ->
        console.log($scope.userEntity)


])