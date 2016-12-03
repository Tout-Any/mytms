express = require('express');
router = express.Router();
taskBiz = require('./../biz/taskBiz')
commonBiz = require('./../biz/commonBiz')

#新增任务
router.post('/task',commonBiz.setUserInfo,commonBiz.validateUserinfo,taskBiz.addTask)

#修改任务
router.put('/task',commonBiz.setUserInfo,commonBiz.validateUserinfo,taskBiz.updateTask)

#查找单个任务
router.get('/task/:id',commonBiz.setUserInfo,commonBiz.validateUserinfo,taskBiz.getTask)

#获得多个任务列表
router.get('/task',commonBiz.setUserInfo,commonBiz.validateUserinfo,taskBiz.getTasks)

module.exports = router;
