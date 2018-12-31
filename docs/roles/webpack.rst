*******
Webpack
*******

**Current Webpack version: 4.5.0**

This role provides a pretty simple setup to handle assets (javascripts, stylesheets, images, fonts and SVG icons) through `Webpack <https://webpack.js.org/>`_ in your project.

It creates a `webpack.config.js` that is preconfigured to handle:

- `Sass <https://sass-lang.com/>`_ files to create stylesheets. Stylesheets are processed through `Autoprefixer <https://github.com/postcss/autoprefixer>`_ for browser compatibility and `CSSNano <http://cssnano.co/>`_ for optimisations.
- JavaScript files through `Babel <https://babeljs.io/>`_ with babel-preset-env to use next generation JavaScript today
- SVG icons through `svg-sprite-loader <https://github.com/kisenka/svg-sprite-loader>`_ and make a single sprite file out of it
- Images (svg, png, jp(e)g, gif, webp)
- Fonts (woff, woff2, eot, ttf, otf)


Installation
------------

Once enabled, this role will create a ``webpack.config.js``, a ``babel.config.js`` and a ``package.json`` that includes all the required dependencies by default.

**Existing files (webpack.config.js, babel.config.js and package.json) will not be overridden. If those files already exist, the installation will be incomplete and might not work as expected.**

Parameters
~~~~~~~~~~

- **webpack_directory**: where should the webpack.config.js be created, defaults to ``{{ root_directory }}/``
- **webpack_package_json_path**: where should the package.json be created, defaults to ``{{ webpack_directory }}/package.json``
- **webpack_create_config**: Create the webpack.config.js & babel.config.js, defaults to ``true``
- **webpack_browserslist**: Define `Browserslist <https://github.com/ai/browserslist>`__ in ``package.json``, defaults to:

    .. code-block:: yaml

        - "> 0.5%"
        - "not op_mini all"
        - "not dead"

Post-install
~~~~~~~~~~~~

The default configuration expects a couple of things:

- The main JavaScript file to live at ``assets/scripts/common.js`` (not created by the role)
- All the assets to live in ``assets/…`` or in ``node_modules``
- The SVG icons to be included in the sprite to live in ``assets/icons/``

Other defaults:

- Built files are bundled into the ``dist/`` folder
- Generated icons sprite is named ``icons.svg``

You can change all these default values by editing the ``webpack.config.js`` file. If you need help, you should check out the `Webpack config documentation <https://webpack.js.org/configuration/>`_.


Default tasks
-------------

Development
~~~~~~~~~~~

::

    npm start

Starts ``webpack-dev-server`` at `example.lo:3000 <http://example.lo:3000>`_, compile on-the-fly and reload the browser automatically. All requests not handled by webpack will be proxified to example.lo.

*Replace example.lo by the "hostname" you set in the "parameters.yml".*

Notice that webpack-dev-server does not write the files to the disk. To debug which files are being served, go to `example.lo:3000/webpack-dev-server <http://example.lo:3000/webpack-dev-server>`_.

Production
~~~~~~~~~~

::

    npm run build

Will bundle all the assets, optimized for production, in the ``dist`` folder by default.


Loading assets
--------------

The default public path for bundled assets is ``/``.

To load the main JavaScript file, use:

.. code-block:: html

    <script type="text/javascript" src="common.js"></script>

In development, CSS is automatically injected in a ``<style>`` tag by the JavaScript file that imported it. In production, you need to include the extracted file. For example, all the CSS required by the ``common`` bundle, would be extracted as ``common.css`` and should be loaded like this:

.. code-block:: html

    <link rel="stylesheet" type="text/css" href="common.css">

If you need help to import files such as CSS, images or fonts, take a look to the `Webpack asset management guide <https://webpack.js.org/guides/asset-management/>`_.
