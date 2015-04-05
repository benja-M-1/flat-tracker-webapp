gulp = require 'gulp'
concat = require 'gulp-concat'
filter = require 'gulp-filter'
mainBowerFiles = require 'main-bower-files'
plumber = require 'gulp-plumber'
wiredep = require 'wiredep'

parameters = require '../parameters.coffee'

gulp.task 'vendor', ->
  # Scripts
  if process.env.NODE_ENV == "prod"
    vendors = [
      "#{parameters.paths.src.bower}/jquery/dist/jquery.min.js",
      "#{parameters.paths.src.bower}/bootstrap/dist/js/bootstrap.min.js",
      "#{parameters.paths.src.bower}/uri.js/src/URI.min.js",
      "#{parameters.paths.src.bower}/moment/min/moment-with-locales.min.js",
      "#{parameters.paths.src.bower}/angular/angular.min.js",
      "#{parameters.paths.src.bower}/angular-ui-router/release/angular-ui-router.min.js",
      "#{parameters.paths.src.bower}/angular-parse/angular-parse.js",
      "#{parameters.paths.src.bower}/angular-momentjs/angular-momentjs.min.js",
      "#{parameters.paths.src.bower}/angular-intercom/angular-intercom.min.js",
    ]
  else
    vendors = [
      "#{parameters.paths.src.bower}/jquery/dist/jquery.js",
      "#{parameters.paths.src.bower}/bootstrap/dist/js/bootstrap.js",
      "#{parameters.paths.src.bower}/uri.js/src/URI.js",
      "#{parameters.paths.src.bower}/moment/min/moment-with-locales.js",
      "#{parameters.paths.src.bower}/angular/angular.js",
      "#{parameters.paths.src.bower}/angular-ui-router/release/angular-ui-router.js",
      "#{parameters.paths.src.bower}/angular-parse/angular-parse.js",
      "#{parameters.paths.src.bower}/angular-momentjs/angular-momentjs.js",
      "#{parameters.paths.src.bower}/angular-intercom/angular-intercom.js",
    ]
  gulp.src vendors
  .pipe concat parameters.files.vendors.scripts
  .pipe gulp.dest parameters.paths.www.scripts

  # Styles
  gulp.src mainBowerFiles()
  .pipe filter '**/*.css'
  .pipe concat parameters.files.vendors.styles
  .pipe gulp.dest parameters.paths.www.styles

  # Fonts
  gulp.src mainBowerFiles()
  .pipe filter [
      '**/*.woff'
      '**/*.svg'
      '**/*.eot'
      '**/*.ttf'
      '**/*.otf'
    ]
  .pipe gulp.dest "#{parameters.paths.www.main}/fonts"
