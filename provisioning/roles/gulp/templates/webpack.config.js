const path    = require('path');
const webpack = require('webpack');
const config  = require('./gulp.config.js');

const webpackConfig = {
  resolve: {
    modules: [
      path.resolve(__dirname, 'static/javascripts/**/*.{js{% if gulp_use_purescript %},purs{% endif %}}'),
      'node_modules'
    ],
    extensions: ['.js'{% if gulp_use_purescript %}, '.purs'{% endif %}]
  },
  entry: './static/javascripts/index.js',
  output: {
    path: './static/javascripts',
    filename: 'bundle.js'
  },
  module: {
    rules: [
{% if gulp_use_purescript %}
      {
        test: /\.purs$/,
        exclude: /node_modules/,
        loader: 'purs-loader',
        options: {
          psc: 'psa',
          pscArgs: { sourceMaps: true },
          pscIde: true,
          src: ['bower_components/purescript-*/src/**/*.purs', 'src/**/*.purs']
        }
      },
{% endif %}
      {
        test: /\.jsx?$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        options: {
          presets: ['es2015', 'es2016', 'react']
        }
      }
    ]
  }
};

if (config.optimize) {
  webpackConfig.plugins = [
    new webpack.DefinePlugin({
      'process.env': {
        'NODE_ENV': JSON.stringify('production')
      }
    }),
    new webpack.optimize.UglifyJsPlugin({
      comments: false
    })
  ];
} else {
  webpackConfig.devtool = '#eval';
}

module.exports = webpackConfig;
