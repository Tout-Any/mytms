db = require('./../libs/db')

module.exports ={

  setUserInfo :(req,res,next)->
    #客户端在提交请求时,要将他的令牌token一起提交过来,以便让服务器端知道它是谁
    token = req.headers['x-token']
    db.users.findOne({token:token,expiredTime:{$gt:Date.now()}},(err,user) ->
       req.userInfo = user if not err
       next()
    )

  validateUserinfo:(req,res,next) ->
    if not req.userInfo
      res.status(401)
      return res.send('未授权')
    next()
}