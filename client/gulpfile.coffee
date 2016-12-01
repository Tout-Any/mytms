
fs = require('fs')
gulp = require('gulp')
runSequence = require('run-sequence')
del = require('del')
uglify = require('gulp-uglify')
concat = require('gulp-concat')
minifyCss = require('gulp-minify-css')
# unCss = require('gulp-uncss')
browserSync = require('browser-sync').create()

# 读取assets.json文件
assets = JSON.parse(fs.readFileSync('assets.json'))

# 默认构建任务
gulp.task('default',(callback) ->
  runSequence(['clean'], ['build'], ['serve', 'watch'], callback)
)

gulp.task('clean', (callback)->
  del(['./dist/'], callback)
)

gulp.task('build', (callback) ->
  runSequence(
    ['assetsJs', 'assetsCss', 'assetsFonts'],
    ['appJs', 'appCss', 'copyHtml'],
    callback
  )
)

# 合并所有的第三方js文件为assets.js
gulp.task('assetsJs', ->
  gulp.src(assets.assetsJs)
  .pipe(concat('assets.js', {newLine: ';\n'}))
  .pipe(gulp.dest('./dist/assets/js/'))
)

#合并所有的第三方css文件为assets.css文件
gulp.task('assetsCss', ->
  gulp.src(assets.assetsCss)
  .pipe(concat('assets.css', {newLine: '\n\n'}))
  .pipe(gulp.dest('./dist/assets/css/'))
)
#合并字体文件
gulp.task('assetsFonts', ->
  gulp.src(assets.assetsFonts)
  .pipe(gulp.dest('./dist/assets/fonts/'))
)

# 拷贝所有的html目录到dist目录下

gulp.task('copyHtml', ->
  gulp.src(['./src/**/*.html'])
  .pipe(gulp.dest('./dist/'))
)
#合并我们所有自己写的js为app.js
gulp.task('appJs', ->
  gulp.src(assets.appJs)
  .pipe(concat('app.js', {newLine: ';\n'}))
  .pipe(gulp.dest('./dist/assets/js/'))
)
#合并我们所有自己写的css文件为app.css
gulp.task('appCss', ->
  gulp.src(assets.appCss)
  .pipe(concat('app.css', {newLine: '\n\n'}))
  .pipe(gulp.dest('./dist/assets/css/'))
)

gulp.task('serve', ->
  browserSync.init({
    server: {
      baseDir: './dist/'
    }
    port: 7411
  })
)

gulp.task('watch', ->
  gulp.watch('./src/**/*.*', ['reload'])
)

gulp.task('reload', (callback)->
  runSequence(['build'], ['reload-browser'], callback)
)

gulp.task('reload-browser', ->
  browserSync.reload()
)