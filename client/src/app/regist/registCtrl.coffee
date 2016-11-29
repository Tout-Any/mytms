angular.module('tmsApp')
  .controller('registCtrl',['$scope',($scope) ->
      $scope.userEntity={
              username:'',
              password:'',
              password2:'',
      }
      $scope.doReg= ->
        console.log($scope.userEntity)


])