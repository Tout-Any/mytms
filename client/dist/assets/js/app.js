// Generated by CoffeeScript 1.11.1
(function() {
  angular.module('tmsApp', ['ngRoute']).config([
    '$routeProvider', function($routeProvider) {
      return $routeProvider.when('/login', {
        templateUrl: './app/login/index.html',
        controller: 'LoginCtrl'
      }).when('/regist', {
        templateUrl: './app/regist/index.html',
        controller: 'RegistCtrl'
      }).when('/', {
        templateUrl: './app/index/index.html',
        controller: 'IndexCtrl'
      });
    }
  ]).run([
    '$location', function($location) {
      return $location.path('/login').replace();
    }
  ]);

}).call(this);

//# sourceMappingURL=index.js.map
;
// Generated by CoffeeScript 1.11.1
(function() {
  angular.module('tmsApp').controller('IndexCtrl', [
    '$scope', '$location', '$rootScope', function($scope, $location, $rootScope) {
      $scope.task = {
        description: ''
      };
      $scope.taskList = [];
      $scope.exit = function() {
        return $location.path('/login');
      };
      return $scope.addTask = function() {
        var task;
        task = angular.copy($scope.task);
        task.checked = false;
        task.status = 'InProgress';
        $scope.taskList.push(task);
        return $scope.task.description = '';
      };
    }
  ]);

}).call(this);

//# sourceMappingURL=indexCtrl.js.map
;
// Generated by CoffeeScript 1.11.1
(function() {
  angular.module('tmsApp').controller('LoginCtrl', [
    '$scope', '$location', function($scope, $location) {
      $scope.userEntity = {
        username: '',
        password: ''
      };
      $scope.rememberMe = false;
      return $scope.doLogin = function() {
        console.log($scope.userEntity);
        return $location.path('/').replace();
      };
    }
  ]);

}).call(this);

//# sourceMappingURL=loginCtrl.js.map
;
// Generated by CoffeeScript 1.11.1
(function() {
  angular.module('tmsApp').controller('LoginCtrl', [
    '$scope', '$http', '$location', 'tmsUtils', function($scope, $http, $location, tmsUtils) {
      $scope.userEntity = {
        username: '',
        password: '',
        rememberMe: false
      };
      return $scope.doLogin = function() {
        return $http.post(Tms.apiAddr + "/api/user/login", $scope.userEntity).then(function(res) {
          console.log($scope.userEntity);
          return $location.path('/').replace();
        }, tmsUtils.processHttpError);
      };
    }
  ]);

}).call(this);

//# sourceMappingURL=loginCtrl.js.map
;
// Generated by CoffeeScript 1.11.1
(function() {
  angular.module('tmsApp').controller('RegistCtrl', [
    '$scope', '$http', '$location', 'tmsUtils', function($scope, $http, $location, tmsUtils) {
      $scope.userEntity = {
        username: '',
        password: '',
        password2: ''
      };
      return $scope.doReg = function() {
        if ($scope.userEntity.password !== $scope.userEntity.password2) {
          return alert('两次密码不一致');
        }
        if (!$scope.userEntity.username || !$scope.userEntity.password || !$scope.userEntity.password2) {
          return alert('用户名密码不允许为空');
        }
        return $http.post(Tms.apiAddr + "/api/user/regist", $scope.userEntity).then(function(res) {
          alert('注册成功');
          return $location.path('/login');
        }, tmsUtils.processHttpError);
      };
    }
  ]);

}).call(this);

//# sourceMappingURL=registCtrl.js.map
;
// Generated by CoffeeScript 1.11.1
(function() {
  angular.module('tmsApp').factory('tmsUtils', [
    function() {
      var processHttpError;
      processHttpError = function(res) {
        var data;
        console.log(res);
        data = res.data;
        if (data.message) {
          return alert(data.message);
        }
      };
      return {
        processHttpError: processHttpError
      };
    }
  ]);

}).call(this);

//# sourceMappingURL=tmsUtils.js.map
;
// Generated by CoffeeScript 1.11.1
(function() {
  var Tms;

  Tms = {
    apiAddr: 'http://127.0.0.1:7410'
  };

  window.Tms = Tms;

}).call(this);

//# sourceMappingURL=config.js.map
