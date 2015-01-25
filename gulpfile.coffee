gulp            = require 'gulp'
jade            = require 'gulp-jade'
less            = require 'gulp-less'
coffee          = require 'gulp-coffee'
concat          = require 'gulp-concat'
filter          = require 'gulp-filter'
flatten         = require 'gulp-flatten'
mainBowerFiles  = require 'main-bower-files'

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
  .pipe jade configs.jade
  .pipe gulp.dest paths.dest

gulp.task 'img', ->
  gulp.src paths.src + paths.dev.img
  .pipe gulp.dest paths.dest + paths.build.img

gulp.task 'jade', ->
  gulp.src paths.dev.jade
  .pipe flatten()
  .pipe jade configs.jade
  .pipe gulp.dest paths.dest + paths.build.templates

gulp.task 'less', ->
  gulp.src paths.dev.less
  .pipe less()
  .pipe gulp.dest paths.dest + paths.build.css

gulp.task 'ionic', ->
  gulp.src './bower_components/ionic/css/ionic.css'
  .pipe flatten()
  .pipe gulp.dest paths.dest + paths.build.css

gulp.task 'coffee', ->
  gulp.src paths.dev.coffee
  .pipe coffee configs.coffee
  .pipe concat filenames.app
  .pipe gulp.dest paths.dest + paths.build.js

gulp.task 'vendors', ->
  gulp.src paths.dev.bower
  .pipe filter filters.onlyJs
  .pipe concat filenames.vendors
  .pipe gulp.dest paths.dest + paths.build.js

gulp.task 'fonts', ->
  gulp.src paths.dev.fonts
  .pipe flatten()
  .pipe gulp.dest paths.dest + paths.build.fonts

gulp.task 'i18n', ->
  gulp.src paths.dev.i18n
  .pipe gulp.dest paths.dest + paths.build.i18n

gulp.task 'build', ['index', 'jade', 'less', 'coffee', 'vendors', 'fonts', 'ionic', 'img', 'i18n']

gulp.task 'watch', ['build'], ->
  gulp.watch paths.src + paths.dev.index, ['index']
  gulp.watch './src/**/*.coffee', ['coffee']
  gulp.watch './src/**/*.jade', ['jade']
  gulp.watch './src/**/*.less', ['less']
  gulp.watch paths.dev.bower, ['vendors']
  gulp.watch paths.dev.fonts, ['fonts']
