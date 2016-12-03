angular.module('tmsApp')
.factory('tmsUtils',[() ->
   processHttpError = (res) ->
     console.log(res)
     data = res.data
     if data.message
       alert(data.message)
   return {
     processHttpError: processHttpError
   }

])