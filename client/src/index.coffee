angular.module('myApp',[])
.controller('helloCtrl',($scope) ->
   $scope.name='Hello world'
)
angular.bootstrap('myApp',[])