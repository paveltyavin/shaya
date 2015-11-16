gulp = require 'gulp'

gulp.task 'copy:app', ->
  gulp.src './copy/**'
  .pipe gulp.dest "./dist/"

  gulp.src ['node_modules/bootstrap/fonts/*']
  .pipe gulp.dest('./dist/fonts')

gulp.task 'copy:vendor', ->
  null

gulp.task 'copy', ['copy:app', 'copy:vendor']

gulp.task 'build', ['copy', 'build:less', 'build:vendor', 'build:app']
gulp.task 'default', ['copy', 'less', 'build:vendor', 'watch']
