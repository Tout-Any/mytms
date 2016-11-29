express = require('express')
path = require('path')
logger = require('morgan')
bodyParser = require('body-parser')

apiRouters = require('./../routes/api')

app = express()
app.use(logger('dev'))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: false}))

console.log('进来了');
app.use('/api', apiRouters)

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

#render the error page
  res.status(err.status || 500)
  res.send('error')
)

module.exports = app;
