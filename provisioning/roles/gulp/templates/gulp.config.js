const argv = require('yargs').argv;

module.exports = {
  optimize:         argv.production,
  src: {
    sass:           'static/sass/**/*.scss',
    images:         'static/images/**/*.{gif,jpg,jpeg,png,svg}',
    templates:      '**/*.html'
  },
  dest: {
    css:            'static/stylesheets',
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
