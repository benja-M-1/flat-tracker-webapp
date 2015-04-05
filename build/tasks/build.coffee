gulp = require 'gulp'
gulp.task 'build', [
  'assets'
  'styles'
  'vendor'
  'index'
  'app'
  'templates'
  'configuration'
]
