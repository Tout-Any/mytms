// Generated by CoffeeScript 1.11.1
(function() {
  var addTask, db, getTask, getTasks, jwt, updateTask;

  db = require('./../libs/db');

  jwt = require('jsonwebtoken');

  addTask = function(req, res, next) {
    var body, data;
    body = req.body;
    data = {
      creator: 'xxx',
      taskName: body.taskName,
      createDate: Date.now(),
      updateDate: Date.now(),
      status: '未完成',
      deleted: false
    };
    return db.tasks.insert(data, function(err, task) {
      if (err) {
        return next(err);
      }
      if (!task) {
        return next('创建任务失败');
      }
      res.json(true);
    });
  };

  updateTask = function(req, res, next) {
    var body;
    body = req.body;
    return db.tasks.findOne({
      _id: body._id
    }, function(err, task) {
      if (err) {
        return next(err);
      }
      if (!task) {
        return next('未找到要更新的任务');
      }
      return db.tasks.update({
        _id: task._id
      }, {
        $set: {
          creator: 'xxx',
          taskName: body.taskName,
          updateDate: Date.now(),
          status: body.status,
          deleted: body.deleted || false
        }
      }, function(err, num) {
        if (err) {
          return next(err);
        }
        if (num === 0) {
          return next('更新失败');
        }
        return res.json(true);
      });
    });
  };

  getTask = function(req, res, next) {
    var taskId;
    taskId = req.params.id;
    return db.tasks.findOne({
      _id: taskId
    }, function(err, task) {
      if (err) {
        return next(err);
      }
      return res.json(task);
    });
  };

  getTasks = function(req, res, next) {
    return db.tasks.find({
      deleted: false,
      creator: 'xxx'
    }, function(err, tasks) {
      if (err) {
        return next(err);
      }
      return res.json(tasks);
    });
  };

  module.exports = {
    addTask: addTask,
    getTask: getTask,
    getTasks: getTasks,
    updateTask: updateTask
  };

}).call(this);

//# sourceMappingURL=taskBiz.js.map
