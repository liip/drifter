/* eslint-env node */
const argv = require('yargs').argv;

module.exports = {
  optimize: argv.production,
  src: {
    sass: 'static/sass/**/*.scss',
    images: 'static/images/**/*.{gif,jpg,jpeg,png,svg}',
    javascripts: 'static/javascripts/**/*.js',
    templates: '**/*.html',
  },
  dest: {
    css: 'static/stylesheets',
    images: 'static/images',
  },
  browserSync: {
    proxy: '{{ hostname }}',
{% if ssl|default(false) and ssl_key_file is defined and ssl_cert_file is defined %}
    https: {
      key: '{{ ssl_key_file }}',
      cert: '{{ ssl_cert_file }}',
    },
{% endif %}
    open: false,
    notify: false,
    plugins: ['bs-pretty-message'],
  },
  sass: {
    outputStyle: 'compressed',
  },
  autoprefixer: {
    cascade: false,
  },
};
