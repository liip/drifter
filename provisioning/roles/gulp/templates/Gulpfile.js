/* eslint-env node */
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
const stripAnsi     = require('strip-ansi');
{% endif %}

/*----------------------------------------*\
  TASKS
\*----------------------------------------*/

/**
 * Watching files for changes
 */
gulp.task('watch', ['build'], () => {
  browserSync.init(config.browserSync);

  gulp.watch(config.src.sass, ['sass']);
  gulp.watch(config.src.templates, reload);
{% if gulp_use_webpack %}
  gulp.watch(config.src.javascripts, ['webpack']);
{% endif %}
});

/**
 * Compile Sass to CSS
 * Add vendor prefixes with Autoprefixer
 * Write sourcemaps in dev mode
 */
gulp.task('sass', () => {
  return gulp.src(config.src.sass)
    .pipe($.if(!config.optimize, $.sourcemaps.init()))
    .pipe(
      $.sass(config.sass)
        .on('error', error => {
          browserSync.sockets.emit('fullscreen:message', {
            title: 'Sass compilation error',
            body: error.message,
          });
          $.sass.logError.apply(this, arguments);
        })
        .on('data', () => {
          browserSync.sockets.emit('fullscreen:message:clear');
        })
    )
    .pipe($.autoprefixer(config.autoprefixer))
    .pipe($.if(!config.optimize, $.sourcemaps.write('.')))
    .pipe(gulp.dest(config.dest.css))
    .pipe(browserSync.stream({ match: '**/*.css' }));
});

{% if gulp_use_webpack %}
/**
 * Bundle JavaScript modules
 */
gulp.task('webpack', done => {
  webpack.run((error, stats) => {
    if (stats.hasErrors() || stats.hasWarnings()) {
      browserSync.sockets.emit('fullscreen:message', {
        title: 'WebPack compilation error',
        body: stripAnsi(stats.toString()),
        timeout: 100000,
      });
      $.util.log('[webpack]', stats.toString());
    } else {
      browserSync.sockets.emit('fullscreen:message:clear');
      reload();
    }
    done();
  });
});
{% endif %}

/**
 * Optimize images
 */
gulp.task('images', () => {
  return gulp.src(config.src.images)
    .pipe($.imagemin({
      progressive: true,
      svgoPlugins: [{
        removeViewBox: false,
      }],
    }))
    .pipe(gulp.dest(config.dest.images));
});

gulp.task('build', [{% if gulp_use_webpack %}'webpack', {% endif %}'sass']);
gulp.task('default', ['watch']);
