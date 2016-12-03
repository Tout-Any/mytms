db = require('./../libs/db')
jwt = require('jsonwebtoken')


addTask = (req,res,next) ->
  body = req.body
  data = {
    creator:'xxx'
    taskName:body.taskName
    createDate:Date.now()
    updateDate:Date.now()
    status:'未完成'
    deleted:false
  }
  db.tasks.insert(data,(err,task) ->
    return next(err) if err
    return next('创建任务失败') if !task
    res.json(true)
    return

  )

updateTask = (req,res,next) ->
  body = req.body
  db.tasks.findOne({_id:body._id},(err,task)->
    return next(err) if err
    return next('未找到要更新的任务') if !task
    db.tasks.update({_id:task._id},{$set:{
      creator:'xxx'
      taskName:body.taskName
      updateDate:Date.now()
      status:body.status
      deleted:body.deleted || false
    }},(err,num)->
      return next(err) if err
      return next('更新失败') if num is 0
      res.json(true)
    )

  )

getTask = (req,res,next) ->
  taskId=req.params.id
  db.tasks.findOne({_id:taskId},(err,task) ->
     return next(err) if err
     res.json(task)
  )

getTasks = (req,res,next) ->
  db.tasks.find({deleted:false,creator:'xxx'},(err,tasks) ->
    return next(err) if err
    res.json(tasks)

  )


module.exports ={
  addTask:addTask
  getTask:getTask
  getTasks:getTasks
  updateTask:updateTask
}