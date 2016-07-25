# PHP

Install PHP 5.4.4 and various extensions : curl, intl, gd, imagemagick, xcache, xdebug.

Development specific configuration options are also put into place, for example to activate
error outputting.

A database driver is also installed if one of the MySQL or PostgreSQL roles was included before.

XDebug profiling and debugging are off by default, you can modify the config file `/etc/php5/conf.d/20-xdebug.ini`
and restart your Apache or PHP-FPM to activate them. XDebug is also configured to trigger debugging
and profiling in response to the related query string or cookie, so you should be able to install
a browser extension to make it work this way.

This role is automatically included by roles PHP-Apache and PHP-FPM, so you should not include
it yourself.

## Parameters

* **php_error_reporting** : php error reporting, defaults to "E_ALL | E_STRICT"
* **php_max_execution** _time** : script max exectution time, defaults to "3600"
* **php_memory_limit** : memory limit, defaults to "4G"
* **php_upload_max_filesize** : maximal size of uploaded file, defaults to "128M"
* **php_date_timezone** : timezone, defaults to "Europe/Zurich"
* **php_default_charset** : default charset, defaults to "UTF-8"

# PHP-Apache

Install libapache2-mod-php5 so that PHP can be used with Apache.

Depends on the PHP and Apache role.

# PHP-FPM

Install php5-fpm so that you can use PHP with NGinx.

Depends on the PHP and NGinx role.

# PHP-XDebug

To be completed

# PHP-Redis

To be completed

# PHP-MemCached

To be completed

# Composer

Install Composer, the PHP package manager. The PHP role is defined as a dependency.
You can set the install dir, a link is `/usr/local/bin` will be set up whichever the
install dir is so that composer can be accessed globally.

If composer is already installed, this role will update it instead.

## Parameters

* **composer.dir** : where to install the binary, default "opt/composer"
