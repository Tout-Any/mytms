angular.module('tmsApp')
.controller('IndexCtrl', ['$scope', '$location', '$rootScope', ($scope, $location, $rootScope) ->
# scope添加任务对象
  $scope.task = {
    description: ''
  }
  $scope.taskList = []

  # UI添加任务对象
  $scope.addTask = ->
    task = angular.copy($scope.task)
    task.checked = false
    task.status = 'InProgress'
    $scope.taskList.push(task)
    $scope.task.description = ''
])