/*----------------------------------------*\
  DRIFTER GULPFILE
  Version 1.1.0
\*----------------------------------------*/

const config        = require('./gulp.config.js');
const gulp          = require('gulp');
const $             = require('gulp-load-plugins')();
const browserSync   = require('browser-sync').create();
const reload        = browserSync.reload;
{% if gulp_use_webpack %}
const webpackConfig = require('./webpack.config.js');
const webpack       = require('webpack')(webpackConfig);
{% endif %}

/*----------------------------------------*\
  TASKS
\*----------------------------------------*/

/**
 * Watching files for changes
 */
gulp.task('watch', ['build'], function() {
  browserSync.init(config.browserSync);

  gulp.watch(config.src.sass, ['sass']);
  gulp.watch(config.src.templates, reload);
  {% if gulp_use_webpack %}gulp.watch(webpackConfig.resolve.modules, ['webpack', reload]);{% endif %}
});

/**
 * Compile Sass to CSS
 * Add vendor prefixes with Autoprefixer
 * Write sourcemaps in dev mode
 */
gulp.task('sass', function() {
  return gulp.src(config.src.sass)
    .pipe($.if(!config.optimize, $.sourcemaps.init()))
    .pipe($.sass(config.sass).on('error', $.sass.logError))
    .pipe($.autoprefixer(config.autoprefixer))
    .pipe($.if(!config.optimize, $.sourcemaps.write('.')))
    .pipe(gulp.dest(config.dest.css))
    .pipe(browserSync.stream({match: '**/*.css'}));
});

{% if gulp_use_webpack %}
/**
 * Bundle JavaScript modules
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

gulp.task('build', [{% if gulp_use_webpack %}'webpack', {% endif %}'sass']);
gulp.task('default', ['watch']);
