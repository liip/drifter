'use strict';

var path       = require('path'),
    webpack    = require('webpack'),
    gulpConfig = require('./gulp.config.js');

module.exports = function(production) {
  var config = {
    resolve: {
      root: [path.resolve(__dirname, 'static/javascripts')],
      extensions: ['', '.jsx', '.js']
    },
    entry: gulpConfig.src.webpack,
    output: gulpConfig.dest.webpack,
    module: {
      loaders: [
        {
          loader: 'babel',
          exclude: /(node_modules|bower_components)/,
          test: /\.jsx?$/,
          query: {
            presets: ['es2016', 'react']
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

