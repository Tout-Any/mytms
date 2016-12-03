db = require('./../libs/db')
jwt = require('jsonwebtoken')



login = (req,res,next) ->
  username=req.body.username
  password=req.body.password
  console.log("username="+username+" pwd="+password)
  db.users.findOne({username:username,password:password},(err,user) ->
      console.log(user)
      return next(err) if err
      return next(new Error('登陆失败')) if  !user
      token = jwt.sign({username:username},'lvlay')
      expiredTime = Date.now()+1000*60*60*24
      db.users.update(
        {_id:user._id},
        {$set:{token:token,expiredTime:expiredTime}},
        {upsert:false}
        (err,num)->
           console.log("num="+num);
           return next(err) if err
           return next(new Error('登陆失败,请重试')) if num is 0
           res.json({token:token})
        )

  )




isUserExists = (req,res,next) ->
  body = req.body
  return next(new Error('请提交用户注册信息')) if not body or not body.username or not body.password
  db.users.findOne({username:req.body.username},(err,user) ->
      return next(err) if err
      if user
        return next(new Error('用户名已存在,请重新注册'))
      next()
      return
  )

regist=(req,res,next) ->
  body = req.body
  #正常注册
  console.log('bbbb')
  postData={
    username:body.username
    password:body.password
    token:''
    expiredTime:Date.now()
  }
  console.log('cccc')
  db.users.insert(postData,(err,user)->
    console.log(user)
    return next(err) if err
    res.json(true)
  )
  return

module.exports={
  isUserExists:isUserExists
  regist:regist
  login:login
}
