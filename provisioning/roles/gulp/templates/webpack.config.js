'use strict';

var path       = require('path'),
    webpack    = require('webpack'),
    gulpConfig = require('./gulp.config.js');

module.exports = function(production) {
  var config = {
    resolve: {
      root: [path.resolve(__dirname, gulpConfig.src.javascripts)],
      extensions: ['', '.jsx', '.js'{% if gulp_use_purescript %}, '.purs'{% endif %}]
    },
    entry: gulpConfig.src.webpack,
    output: gulpConfig.dest.webpack,
    module: {
      loaders: [
{% if gulp_use_purescript %}
        {
          loader: 'purs-loader',
          exclude: /node_modules/,
          test: /\.purs$/,
          query: {
            psc: 'psa',
            pscArgs: { sourceMaps: true },
            pscIde: true,
            src: ['bower_components/purescript-*/src/**/*.purs', 'src/**/*.purs']
          }
        },
{% endif %}
        {
          loader: 'babel',
          exclude: /(node_modules|bower_components)/,
          test: /\.jsx?$/,
          query: {
            presets: ['es2015', 'es2016', 'react']
          }
        }
      ]
    }
  };
  if (production) {
    // Minify
    config.plugins = [
      new webpack.DefinePlugin({
        'process.env': {
          'NODE_ENV': JSON.stringify('production')
        }
      }),
      new webpack.optimize.UglifyJsPlugin({
        comments: false,
        compress: {
          warnings: false
        }
      })
    ];
  }
  else {
    // Write sourcemaps
    config.devtool = '#cheap-eval-source-map';
  }

  return config;
};

