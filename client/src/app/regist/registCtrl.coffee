angular.module('tmsApp')
  .controller('RegistCtrl',['$scope',
  '$http','$location','tmsUtils',($scope,$http,$location,tmsUtils) ->
      $scope.userEntity={
              username:'',
              password:'',
              password2:'',
      }

      $scope.doReg = ->
        return alert('两次密码不一致') if $scope.userEntity.password isnt $scope.userEntity.password2
        return alert('用户名密码不允许为空') if !$scope.userEntity.username or !$scope.userEntity.password or !$scope.userEntity.password2
        $http.post("#{Tms.apiAddr}/api/user/regist",$scope.userEntity)
        .then(
          (res) ->
            alert('注册成功')
            $location.path('/login')
        ,
          tmsUtils.processHttpError)
])