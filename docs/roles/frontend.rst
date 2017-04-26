**************
Frontend Roles
**************

Gulp
====

*Existing configuration files (Gulpfile.js, gulp.config.js,
webpack.config.js, package.json) will not be overridden.*

-  Install ``gulp`` globally in the Vagrant box
-  Create a prefilled ``Gulpfile.js`` with useful tasks

   -  Watch & live reload with BrowserSync
   -  Compile Sass with Autoprefixer & source-maps
   -  Bundle JavaScript with Webpack, preconfigured with Babel
      (optional)
   -  Lossless images optimization with ImageMin

-  Create associated ``gulp.config.js`` and ``webpack.config.js``
-  Create the ``package.json`` containing the necessary dependencies to
   be installed with NPM.

After the first provisioning, you should edit the ``gulp.config.js`` and
``webpack.config.js`` to match your project structure.

Parameters
----------

-  **gulp\_directory**: where should the gulpfile be created, defaults
   to ``<project_dir>/``
-  **gulp\_package\_json\_path**: where should the package.json file be
   created, defaults to ``<gulp_directory>/package.json``
-  **gulp\_package\_json\_author**: Author that should be put in the
   package.json file, defaults to ``Liip AG``
-  **gulp\_create\_config**: Create the gulp.config.js used by the default Gulpefile.js, defaults to
   ``true``
-  **gulp\_use\_webpack**: Setup Webpack alongside Gulp, defaults to
   ``true``
-  **gulp\_use\_purescript**: Add PureScript support to Webpack,
   defaults to ``false``
-  **gulp\_browserslist**: Define
   `Browserslist <https://github.com/ai/browserslist>`__ in
   ``package.json``, defaults to:

   ::

       - Last 2 versions
       - IE 11

Default tasks
-------------

Watch & live reload proxy
~~~~~~~~~~~~~~~~~~~~~~~~~

Run BrowserSync, watch for changes in files, compile and reload browser
afterwards with:

::

    npm start

Build for production
~~~~~~~~~~~~~~~~~~~~

::

    npm run build

Optimize images
~~~~~~~~~~~~~~~

*For performance reason, this task is not included in the watch/build
tasks. You should run it manually according to your needs.*

Optimize jp(e)g, png, gif & svg files with:

::

    gulp images

Compass
=======

**This role is deprecated, just as Compass is no longer supported.**

Install Compass and incidentally Sass via ``apt-get``. The Ruby role is
installed as dependency.
