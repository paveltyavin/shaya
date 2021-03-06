gulp = require 'gulp'
concat = require 'gulp-concat'
replace = require 'gulp-replace'
less = require 'gulp-less'
combiner = require 'stream-combiner2'
livereload = require 'gulp-livereload'
minifyCss = require('gulp-minify-css')

gulp.task 'less', ->
  combined = combiner.obj([
    gulp.src './less/styles.less'
    less()
    gulp.dest './dist/'
    livereload()
  ])
  combined.on('error', console.error.bind(console));
  return combined

gulp.task 'build:less', ->
  gulp.src './less/styles.less'
  .pipe less()
#  .pipe minifyCss()
  .pipe gulp.dest './dist/'