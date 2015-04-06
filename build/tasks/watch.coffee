gulp = require 'gulp'

parameters = require '../parameters.coffee'

gulp.task 'watch', ['build'], ->
  gulp.watch "#{parameters.paths.src.main}/**", ['build']
