gulp = require 'gulp'
plumber = require 'gulp-plumber'
config = require 'gulp-ng-config'

parameters = require '../parameters.coffee'

gulp.task 'configuration', () ->
  gulp.src "#{parameters.paths.src.main}/#{parameters.files.configuration}"
  .pipe plumber()
  .pipe config("#{parameters.angular.module.name}", {
    createModule: false
    environment: process.env.NODE_ENV || 'development'
  })
  .pipe gulp.dest parameters.paths.www.scripts

