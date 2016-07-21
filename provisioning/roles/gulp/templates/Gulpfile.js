////////////////////////////////////////////
// Drifter Gulpfile
// Version 0.4.0
////////////////////////////////////////////

'use strict';

/**
 * Configuration
 */
var config = {
  src: {
    sass:           'static/sass/**/*.scss',
    images:         'static/images/**/*.{gif,jpg,jpeg,png,svg}',
    templates:      '**/*.html',
  },
  dest: {
    css:            'static/stylesheets',
    images:         'static/images',
  },
  browserSync: {
    proxy:          '{{ hostname }}',
    open:           false,
    notify:         false,
  },
  sass: {
    outputStyle:    'compressed',
  },
  autoprefixer: {
    browsers:       ['last 2 versions', 'ie 9'],
    cascade:        false,
  },
};

/**
 * Load dependencies
 */
var gulp          = require('gulp'),
    $             = require('gulp-load-plugins')(),
    argv          = require('yargs').argv,
    browserSync   = require('browser-sync').create(),
    reload        = browserSync.reload;


/*----------------------------------------*\
  TASKS
\*----------------------------------------*/

/**
 * Watching files for changes
 */
gulp.task('watch', ['sass'], function() {
  browserSync.init(config.browserSync);

  gulp.watch(config.src.sass, ['sass']);
  gulp.watch(config.src.templates, reload);
});

/**
 * Compile Sass into CSS
 * Add vendor prefixes with Autoprefixer
 * Write sourcemaps in dev mode
 */
gulp.task('sass', function() {
  return gulp.src(config.src.sass)
    .pipe($.if(!argv.production, $.sourcemaps.init()))
    .pipe($.sass(config.sass).on('error', $.sass.logError))
    .pipe($.autoprefixer(config.autoprefixer))
    .pipe($.if(!argv.production, $.sourcemaps.write('.')))
    .pipe(gulp.dest(config.dest.css))
    .pipe(browserSync.stream({match: '**/*.css'}));
});

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
