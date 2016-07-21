////////////////////////////////////////////
// Drifter Gulpfile
// Version 1.0.4
////////////////////////////////////////////

'use strict';

var config        = require('./gulp.config.js'),
    gulp          = require('gulp'),
    $             = require('gulp-load-plugins')(),
    argv          = require('yargs').argv,
    browserSync   = require('browser-sync').create(),
    reload        = browserSync.reload,
    isProduction  = argv.production;

{% if gulp_use_webpack %}
var webpackConfig = require('./webpack.config.js'),
    webpack       = require('webpack')(webpackConfig(isProduction)),
    util = require("gulp-util");
{% endif %}

/*----------------------------------------*\
  TASKS
\*----------------------------------------*/

/**
 * Watching files for changes
 */
gulp.task('watch', [{% if gulp_use_webpack %}'webpack', {% endif %}'sass'], function() {
  browserSync.init(config.browserSync);

  gulp.watch(config.src.sass, ['sass']);
  gulp.watch(config.src.templates, reload);
  {% if gulp_use_webpack %}gulp.watch(config.src.javascripts, ['webpack', reload]);{% endif %}
});

/**
 * Compile Sass into CSS
 * Add vendor prefixes with Autoprefixer
 * Write sourcemaps in dev mode
 */
gulp.task('sass', function() {
  return gulp.src(config.src.sass)
    .pipe($.if(! isProduction, $.sourcemaps.init()))
    .pipe($.sass(config.sass).on('error', $.sass.logError))
    .pipe($.autoprefixer(config.autoprefixer))
    .pipe($.if(! isProduction, $.sourcemaps.write('.')))
    .pipe(gulp.dest(config.dest.css))
    .pipe(browserSync.stream({match: '**/*.css'}));
});

{% if gulp_use_webpack %}
/**
 * Pack JavaScript modules
 */
gulp.task('webpack', function(done) {
  webpack.run(function(err, stats) {
    if(err) throw new $.util.PluginError('webpack', err);
    $.util.log('[webpack]', stats.toString());
    done();
  });
});
{% endif %}

/**
 * Optimize images
 */
gulp.task('images', function () {
  return gulp.src(config.src.images)
    .pipe($.imagemin({
      progressive: true,
      svgoPlugins: [{
        removeViewBox: false
      }]
    }))
    .pipe(gulp.dest(config.dest.images));
});

gulp.task('default', ['watch']);

gulp.task('build', [{% if gulp_use_webpack %}'webpack', {% endif %}'sass']);
