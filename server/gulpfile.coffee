gulp = require('gulp')
del = require('del')
runSequence = require('run-sequence')
developServer = require('gulp-develop-server')
notify = require('gulp-notify')

gulp.task('default',(callback)->
   runSequence(['clean'],['copy'],['server','watch'],callback)
)

gulp.task('clean',(callback) ->
  del('./dist/',callback)
)


gulp.task('copy', ->

  gulp.src(['./src/**/*.js','./src/database*/*.db'])
  .pipe(gulp.dest('./dist/'))
)

gulp.task('server',->

  developServer.listen({
    path:'./dist/www.js'
  })
)

gulp.task('watch', ->
  gulp.watch('./src/**/*.js',['reload'])
)

gulp.task('reload',(callback) ->

     runSequence(['copy'],['reload-node'],callback)
)

gulp.task('reload-node', ->
   developServer.restart()
   gulp.src('./dist/www.js')
   .pipe(notify('Server restarted'))
)