*********
PHP Roles
*********

PHP
===

Install PHP and various extensions : curl, intl, gd, imagemagick, ...

The version can be changed and defaults to 5.6. All version are however
not available on all OS versions, an error message will be displayed by
Ansible if you chose an impossible combination.

Available versions are 7.0 for Debian Stretch. 5.6, 7.0 and 7.1 for Debian
Jessie and Ubuntu Trusty (also supports 5.5) and later. 5.4, 5.5 and 5.6
for Debian Wheezy.

Development specific configuration options are also put into place, for
example to activate error outputting.

A database driver is also installed if one of the MySQL or PostgreSQL
roles was included before.

If you want to install xdebug, you'll need to also add the specific role
: ``php-xdebug``.

There are also roles for some more specific extension that could be
found below.

This role is automatically included by roles PHP-Apache and PHP-FPM, so
you should not include it yourself.

Parameters
----------

-  **php\_version** : version to install, defaults to 5.6
-  **php\_error\_reporting** : php error reporting, defaults to "E\_ALL
   \| E\_STRICT"
-  **php\_max\_execution** \_time\*\* : script max exectution time,
   defaults to "3600"
-  **php\_memory\_limit** : memory limit, defaults to "4G"
-  **php\_upload\_max\_filesize** : maximal size of uploaded file,
   defaults to "128M"
-  **php\_date\_timezone** : timezone, defaults to "Europe/Zurich"
-  **php\_default\_charset** : default charset, defaults to "UTF-8"
-  **php\_default\_socket\_timeout** : socket timeout, defaults to 120

PHP-Apache
==========

Install the PHP mod for Apache along with Apache and PHP. You only need
to install this role, PHP and Apache will be automatically added as
dependencies. For details about PHP config, see above.

The default vhost template from the Apache role is used.

PHP-FPM
=======

Install PHP-FPM so that you can use NGinx. You only need to install this
role, PHP and NGinx will be automatically added as dependencies. For
details about PHP config, see above.

You can change the site template used using the parameter defined below.
The templates can be found in the NGinx role.

Parameters
----------

-  **nginx\_site\_template**: template to use for site configuration,
   defaults to "php-site.j2"
-  **nginx\_index**: index in nginx configuration, defaults to
   "index.php"

PHP-XDebug
==========

Installs the XDebug extension for PHP.

You can modify the config file ``/etc/php5/conf.d/20-xdebug.ini`` to
change the configuration and restart your Apache or PHP-FPM. XDebug is
also configured to trigger debugging and profiling in response to the
related query string or cookie, so you should be able to install a
browser extension to make it work this way.

Parameters
----------

- **xdebug_idekey**: value of the ``xdebug.idekey`` setting, defaults to `XDEBUG-DRIFTER`.

PHP-Redis
=========

Installs the Redis extension for PHP. Redis and PHP are installed as a
dependency.

Concerning Redis itself, the documentation is in the "System" section of
the documentation.

PHP-MemCached
=============

Installs the MemCached extension for PHP. MemCached and PHP are
installed as a dependency.

Concerning MemCached itself, the documentation is in the "System"
section of the documentation.

Composer
========

Installs Composer, the PHP package manager. The PHP role is defined as a
dependency. You can set the install dir, a link is ``/usr/local/bin``
will be set up whichever the install dir is so that composer can be
accessed globally.

If composer is already installed, this role will update it instead.

Parameters
----------

-  **composer.dir** : where to install the binary, default
   "opt/composer"
