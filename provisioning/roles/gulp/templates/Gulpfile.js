////////////////////////////////////////////
// RAWBOT Gulpfile
// Version 0.2.0
////////////////////////////////////////////

'use strict';

/**
 * Load dependencies
 */
var gulp          = require('gulp'),
    $             = require('gulp-load-plugins')(),
    browserSync   = require('browser-sync').create(),
    reload        = browserSync.reload;

/**
 * Configuration
 */
var config = {
    src: {
        sass:   'static/sass/**/*.scss',
        images: 'static/images/**/*.{gif,jpg,jpeg,png,svg}',
    },
    dest: {
        css:    'static/stylesheets',
        images: 'static/images',
    },
    autoprefixer: {
        browsers: ['last 2 versions', 'ie 9'],
        cascade:  false,
    },
};


/*----------------------------------------*\
  TASKS
\*----------------------------------------*/

/**
 * Watching files for changes
 */
gulp.task('watch', ['sass'], function() {
    browserSync.init({
        proxy: 'localhost'
    });

    gulp.watch(config.src.sass, ['sass']);
});

/**
 * Compile Sass into CSS
 * Add vendor prefixes with Autoprefixer
 */
gulp.task('sass', function() {
    return gulp.src(config.src.sass)
        .pipe($.sass({
            outputStyle: 'compressed'
        }).on('error', $.sass.logError))
        .pipe($.autoprefixer(config.autoprefixer))
        .pipe(gulp.dest(config.dest.css))
        .pipe(reload({stream: true}));
});

/**
 * Optimize images
 */
gulp.task('images', function () {
    return gulp.src(config.src.images)
        .pipe($.imagemin({
            progressive: true,
            svgoPlugins: [{removeViewBox: false}]
        }))
        .pipe(gulp.dest(config.dest.images));
});

gulp.task('default', ['watch']);
