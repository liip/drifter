'use strict';

module.exports = {
  src: {
    sass:           'static/sass/**/*.scss',
{% if gulp_use_webpack %}
    javascripts:    'static/javascripts/src/**/*.{js,jsx{% if gulp_use_purescript %},purs{% endif %}}',
    webpack:        ['./static/javascripts/src/main.js'],
{% endif %}
    images:         'static/images/**/*.{gif,jpg,jpeg,png,svg}',
    templates:      '**/*.html'
  },
  dest: {
    css:            'static/stylesheets',
{% if gulp_use_webpack %}
    webpack:        { path: './static/javascripts/', filename: 'main.js' },
{% endif %}
    images:         'static/images'
  },
  browserSync: {
    proxy:          '{{ hostname }}',
{% if ssl_key_file is defined %}
    https: {
      key: '{{ ssl_key_file }}',
      cert: '{{ ssl_cert_file }}'
    },
{% endif %}
    open:           false,
    notify:         false
  },
  sass: {
    outputStyle:    'compressed'
  },
  autoprefixer: {
    browsers:       ['last 2 versions', 'ie 9'],
    cascade:        false
  }
};
