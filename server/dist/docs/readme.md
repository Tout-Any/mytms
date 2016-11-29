# 前后端分离的任务管理系统
--------------------------
## 一.前端项目搭建
###   1.建立项目文件夹结构
    1. 新建文件夹TMS,在其下建立2个文件夹client 和 server,其中client用来存放前端的代码,server文件夹存放node服务端代码
    2. 在client文件夹下建立src和dist两个目录
    3. 打开命令行,进入到client目录
       - 执行npm init命令 初始化项目
       
        name: (TMS) tms_client
        version: (1.0.0) 
        description: 
        entry point: (index.js) 
        test command: 
        git repository: 
        keywords: 
        author: lvlay
        license: (ISC) MIT
        About to write to /Users/maggie/WebstormProjects/TMS/package.json:
          
        {
          "name": "tms_client",
          "version": "1.0.0",
          "description": "",
          "main": "index.js",
          "scripts": {
          "test": "echo \"Error: no test specified\" && exit 1"},
          "author": "lvlay",
          "license": "MIT"
        }
          
          
        Is this ok? (yes) yes
    4. 在src下创建文件夹assets,并在其下创建plugin
    5. 在plugin下创建angular,bootstrap,jquery文件夹,用来存放他们的js文件
### 2.使用bower安装需要用到的bootstrap,jquery等依赖
#### 使用 bower init 命令初始化
```
lvlaymac:client maggie$ bower init
?name tms_client
? description 
? main file index.js
? keywords 
? authors lvlay
? license MIT
? homepage 
? set currently installed components as dependencies? Yes
? add commonly ignored files to ignore list? Yes
? would you like to mark this package as private which prevents it from being accidentally published to the registry? No

{
  name: 'tms_client',
  description: '',
  main: 'index.js',
  authors: [
    'lvlay'
  ],
  license: 'MIT',
  homepage: '',
  ignore: [
    '**/.*',
    'node_modules',
    'bower_components',
    'test',
    'tests'
  ]
}

? Looks good? Yes
```
#### 使用 bower install bootstrap -save  安装bootstrap和jquery的依赖, 导入angularjs的文件
    将bower_components下的jquery和bootstrap的js文件复制到src/assets/plugin的相应目录下
    将angular的js文件复制到对应目录中
    
#### 使用HTML5 Boilerplate创建脚手架首页
    1. 使用WebStorm创建一个AngularJS项目项目名任意
    2. 将新项目中创建的index.html复制到client项目的src项目下
    3. 打开这个index.html删除不必要的连接,添加引入jquery,angular和bootstrap的链接
    
### 3.认识CoffeeScript
    1. 使用cnpm install coffee-script -g 安装CoffeeScript编译环境
    2. 使用 cnpm install --save-dev coffee-script再次本地安装
    3. 编写coffeescript代码,注意严格缩进
### 4.使用Gulp前端自动化构建工具
#### 安装Gulp
     1. 使用cnpm install gulp -g 全局安装
     2. 使用cnpm install --save-dev gulp 本地安装
#### 编写Gulp的任务脚本
     1. 在client项目根目录下新建coffee文件gulpfile.coffee
     2. 打开该文件,编写任务内容如下
```
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
```
#### 依次安装上面使用的Gulp插件
  1. 运行命令cnpm install gulp-uglify gulp-minify-css gulp-uncss del --save-dev
  2. 运行命令 cnpm install browser-sync --save-dev --msvs_version=2008
  3. 运行命令 cnpm install run-sequence --save-dev

#### 运行gulpfile文件查看运行结果

#### 选中生成的dist文件 右键菜单Mark Directory as 选中Excluded


## 二.后端node服务器搭建
####  1.建立项目文件夹结构
    1.进入server文件夹 运行npm init初始化项目
    2.使用express-generator创建express脚手架项目
       运行 express src 命令
    3.使用WebStorm打开server项目,将src文件夹中的package.json复制到server根目录下
    4.运行cnpm install --save安装依赖
    5.运行 npm install --save-dev coffee-script 安装本地coffee环境
    6.将bin/www文件复制到src目录下 删除bin文件夹
    7.创建config目录  创建libs文件夹
    8.将src目录下的app.js移动到libs文件夹下
    9.在config文件加下创建config.coffee文件, 内容如下
```
module.exports ={
   port:7410
}
```
    10.改写www文件为www.coffee格式,完成后代码如下
```
#!/usr/bin/env node


app = require('./libs/app')
debug = require('debug')('src:server')
http = require('http')
config = require('./config/config')

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

```

    11.改写libs\app.js为coffee格式
```
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

```
#### 2.创建api路由文件
    1.在routes文件夹下创建api.coffee文件
```
express = require('express');
router = express.Router();

router.get('/faq', (req, res, next) ->
  res.send('I am fine  你好吗');
)
module.exports = router;
```
#### 2.使用Gulp构建后端项目
    1.在项目根目录下新建gulpfile.coffee文件
```
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

  gulp.src('./src/**/*.js')
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
```
    2.安装所需要的依赖
```
    cnpm install gulp --save-dev
    cnpm install gulp-develop-server --save-dev
    cnpm install del --save-dev
    cnpm install run-sequence --save-dev
    cnpm install gulp-notify --save-dev
```
  
