gulp=require('gulp')
del=require('del')
runSequence = require('run-sequence')
uglify=require('gulp-uglify')
minifyCss=require('gulp-minify-css')
#unCss = require('gulp-uncss')
browserSync = require('browser-sync').create()

gulp.task('default',(callback)->
   runSequence(['clean'],['build'],['server','watch'],callback)
)

gulp.task('clean',(callback)->
  del(['./dist'],callback)
)

gulp.task('build',(callback)->
  runSequence(['copy','minijs','minicss'],callback)
)

gulp.task('copy',->
  gulp.src('./src/**/*.*')
  .pipe(gulp.dest('./dist/'))
)

gulp.task('minijs',->
  gulp.src('./src/**/*.js')
  .pipe(uglify())
  .pipe(gulp.dest('./dist/'))
)
gulp.task('minicss',->
  gulp.src('./src/**/*.css')
  .pipe(minifyCss())
 # .pipe(unCss())
  .pipe(gulp.dest('./dist/'))
)

gulp.task('concat',->
  gulp.src('./src/*.js')
  .pipe(concat('all.js',{newLine:';\n'}))
  .pipe(gulp.dest('./dist/'))
)

gulp.task('server', ->
   browserSync.init({
     server:{

       baseDir:'./dist/'
     }
     port:7411

   })
)

#监视文件是否改变
gulp.task('watch',->
  gulp.watch('./src/**/*.*',['reload'])
)

#把上面的任务再做一次
gulp.task('reload',(callback)->
   runSequence(['copy','minijs','minicss'],['reload-browser'],callback)
)

gulp.task('reload-browser',->
   browserSync.reload()
)