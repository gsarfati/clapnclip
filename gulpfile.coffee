gulp            = require 'gulp'
jade            = require 'gulp-jade'
less            = require 'gulp-less'
coffee          = require 'gulp-coffee'
concat          = require 'gulp-concat'
filter          = require 'gulp-filter'
flatten         = require 'gulp-flatten'
mainBowerFiles  = require 'main-bower-files'
templateCache   = require 'gulp-angular-templatecache'
plumber         = require 'gulp-plumber'
notify          = require 'gulp-notify'
autoprefixer    = require 'gulp-autoprefixer'

# Configs ########################################################

paths =
  src: './src'
  dest: './www'
  dev:
    index: '/index.jade'
    img: '/img/**'
    jade: ['./src/**/*.jade', '!./src/index.jade']
    less: ['./src/app.less']
    coffee: ['./src/**/*.coffee']
    fonts: ['./bower_components/**/*.{ttf,woff,eof,svg}']
    i18n: 'src/i18n/**.json'
    bower: mainBowerFiles()
  build:
    css: '/css'
    img: '/img'
    fonts: '/fonts'
    js: '/js'
    templates: '/templates'
    i18n: '/i18n'

filenames =
  vendors: 'vendors.js'
  style: 'style.css'
  app: 'app.js'

filters =
  onlyJs: '**/*.js'

configs =
  jade: { pretty: true, doctype: 'html' }
  less: { errLogToConsole: true }
  coffee: { bare: true }

# Tasks ########################################################

gulp.task 'index', ->
  gulp.src paths.src + paths.dev.index
  .pipe plumber(errorHandler: notify.onError('Error: <%= error.message %>'))
  .pipe jade configs.jade
  .pipe gulp.dest paths.dest

gulp.task 'img', ->
  gulp.src paths.src + paths.dev.img
  .pipe plumber(errorHandler: notify.onError('Error: <%= error.message %>'))
  .pipe gulp.dest paths.dest + paths.build.img

gulp.task 'jade', ->
  gulp.src paths.dev.jade
  .pipe plumber(errorHandler: notify.onError('Error: <%= error.message %>'))
  .pipe flatten()
  .pipe jade configs.jade
  .pipe templateCache('templates.js', { module: 'starter' })
  .pipe gulp.dest paths.dest + paths.build.js

gulp.task 'less', ->
  gulp.src paths.dev.less
  .pipe plumber(errorHandler: notify.onError('Error: <%= error.message %>'))
  .pipe less()
  .pipe autoprefixer('last 2 version', 'safari 5', 'ie 8', 'ie 9', 'opera 12.1', 'ios 6', 'android 4')
  .pipe gulp.dest paths.dest + paths.build.css

gulp.task 'ionic', ->
  gulp.src './bower_components/ionic/css/ionic.css'
  .pipe plumber(errorHandler: notify.onError('Error: <%= error.message %>'))
  .pipe flatten()
  .pipe gulp.dest paths.dest + paths.build.css

gulp.task 'coffee', ->
  gulp.src paths.dev.coffee
  .pipe plumber(errorHandler: notify.onError('Error: <%= error.message %>'))
  .pipe coffee configs.coffee
  .pipe concat filenames.app
  .pipe gulp.dest paths.dest + paths.build.js

gulp.task 'vendors', ->
  gulp.src paths.dev.bower
  .pipe plumber(errorHandler: notify.onError('Error: <%= error.message %>'))
  .pipe filter filters.onlyJs
  .pipe concat filenames.vendors
  .pipe gulp.dest paths.dest + paths.build.js

gulp.task 'fonts', ->
  gulp.src paths.dev.fonts
  .pipe plumber(errorHandler: notify.onError('Error: <%= error.message %>'))
  .pipe flatten()
  .pipe gulp.dest paths.dest + paths.build.fonts

gulp.task 'i18n', ->
  gulp.src paths.dev.i18n
  .pipe plumber(errorHandler: notify.onError('Error: <%= error.message %>'))
  .pipe gulp.dest paths.dest + paths.build.i18n

gulp.task 'build', ['index', 'jade', 'less', 'coffee', 'vendors', 'fonts', 'ionic', 'img', 'i18n']

gulp.task 'watch', ['build'], ->
  gulp.watch paths.src + paths.dev.index, ['index']
  gulp.watch './src/**/*.coffee', ['coffee']
  gulp.watch './src/**/*.jade', ['jade']
  gulp.watch './src/**/*.less', ['less']
  gulp.watch paths.dev.bower, ['vendors']
  gulp.watch paths.dev.fonts, ['fonts']
