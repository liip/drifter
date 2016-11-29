# PHP

Install PHP and various extensions : curl, intl, gd, imagemagick, ...

The version can be changed and defaults to 5.6. All version are however not available on
all OS versions, an error message will be displayed by Ansible if you chose an impossible
combination.

Development specific configuration options are also put into place, for example to activate
error outputting.

A database driver is also installed if one of the MySQL or PostgreSQL roles was included before.

If you want to install xdebug, you'll need to also add the specific role : `php-xdebug`.

There are also roles for some more specific extension that could be found below.

This role is automatically included by roles PHP-Apache and PHP-FPM, so you should not include
it yourself.

## Parameters

* **php_version** : version to install, defaults to 5.6
* **php_error_reporting** : php error reporting, defaults to "E_ALL | E_STRICT"
* **php_max_execution** _time** : script max exectution time, defaults to "3600"
* **php_memory_limit** : memory limit, defaults to "4G"
* **php_upload_max_filesize** : maximal size of uploaded file, defaults to "128M"
* **php_date_timezone** : timezone, defaults to "Europe/Zurich"
* **php_default_charset** : default charset, defaults to "UTF-8"
* **php_default_socket_timeout** : socket timeout, defaults to 120

# PHP-Apache

Install the PHP mod for Apache along with Apache and PHP. You only need to install this role, PHP and Apache
will be automatically added as dependencies. For details about PHP config, see above.

The default vhost template from the Apache role is used.

# PHP-FPM

Install PHP-FPM so that you can use NGinx. You only need to install this role, PHP and NGinx
will be automatically added as dependencies. For details about PHP config, see above.

You can change the site template used using the parameter defined below. The templates can be found
in the NGinx role.

## Parameters

* **nginx_site_template**: template to use for site configuration, defaults to "php-site.j2"
* **nginx_index**: index in nginx configuration, defaults to "index.php"

# PHP-XDebug

Installs the XDebug extension for PHP.

You can modify the config file `/etc/php5/conf.d/20-xdebug.ini` to change the configuration and restart
your Apache or PHP-FPM. XDebug is also configured to trigger debugging and profiling in response to the
related query string or cookie, so you should be able to install a browser extension to make it work this way.

# PHP-Redis

Installs the Redis extension for PHP. Redis and PHP are installed as a dependency.

Concerning Redis itself, the documentation is in the "System" section of the documentation.

# PHP-MemCached

Installs the MemCached extension for PHP. MemCached and PHP are installed as a dependency.

Concerning MemCached itself, the documentation is in the "System" section of the documentation.

# Composer

Install Composer, the PHP package manager. The PHP role is defined as a dependency.
You can set the install dir, a link is `/usr/local/bin` will be set up whichever the
install dir is so that composer can be accessed globally.

If composer is already installed, this role will update it instead.

## Parameters

* **composer.dir** : where to install the binary, default "opt/composer"
