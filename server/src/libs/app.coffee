express = require('express')
path = require('path')
logger = require('morgan')
bodyParser = require('body-parser')
cors = require('cors')

apiRouters = require('./../routes/api')
userRouters = require('./../routes/user')
taskRouters = require('./../routes/task')

app = express()
app.use(logger('dev'))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: false}))
app.use(cors())
app.use('/api', apiRouters)
app.use('/api', userRouters)
app.use('/api', taskRouters)

# catch 404 and forward to error handler
app.use((req, res, next) ->
  err = new Error('Not Found')
  err.status = 404
  next(err)
)

# error handler
app.use((err, req, res, next) ->
# set locals, only providing error in development
  res.locals.message = err.message;
  if req.app.get('env') is 'development'
    res.locals.error = err
  else
    res.locals.error = {}

  console.log(err)
#render the error page
  res.send(err.status || 500,{
    message:err.message
    err:{}
  })
)

module.exports = app;
