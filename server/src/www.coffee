#!/usr/bin/env node


app = require('./libs/app')
debug = require('debug')('src:server')
http = require('http')
config = require('./config/config')

#normalizePort =(val)->
#  port = parseInt(val, 10)
#  console.log(port);
#  if isNaN(port)
## named pipe
#     return val
#
#
#  if port >= 0
##port number
#     return port
#  false




port = config.port;
console.log("port="+port);
app.set('port', port);


server = http.createServer(app);

onListening = ()->
  addr = server.address()
  if typeof addr is 'string'
    bind = 'pipe ' + addr
  else
    bind =  'port ' + addr.port
  console.log(bind);
  debug('Listening on ' + bind)


onError=(error)->
   if error.syscall isnt 'listen'
        throw error
   if typeof port is 'string'
     bind = 'Pipe ' + port
   else
     bind = 'Port ' + port

#handle specific listen errors with friendly messages
   switch (error.code)
     when 'EACCES'
       console.error(bind + ' requires elevated privileges')
       process.exit(1)
       break
     when 'EADDRINUSE'
       console.error(bind + ' is already in use')
       process.exit(1)
       break;
     else
       throw error;


server.listen(port)
server.on('error', onError)
server.on('listening', onListening)





