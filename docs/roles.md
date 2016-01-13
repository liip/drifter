The roles in detail
===================

Here is a quick description of each roles. When applicable, the possible parameters
are also described. The parameters can be set upon role inclusion.

## Apache

This roles installs Apache and the required virtual host configuration for your project.

Except for a static website, it should not be used directly because it is automatically
included by other roles, for example PHP-Apache.

### Parameters

To be completed.

## Base

This roles installs various useful software like vim, ack-grep, etc. It also put some
configuration files of the vagrant user home directory.

It should always be included to have a common environement in all vagrant boxes.

## Compass

Install Compass and incidentally Sass. Also install the Ruby role as a dependency.

## Composer

Install Composer, the PHP package manager. The PHP role is defined as a dependency.
You can set the install dir, a link is `/usr/local/bin` will be set up whichever the
install dir is so that composer can be accessed globally.

If composer is already installed, this role will update it instead.

### Parameters

* **composer.dir** : where to install the binary, default "opt/composer"

## Django

Create a python virtual environment and install application requirements via pip.
Also configure database access via environment variable and then run migrations
(compatible with Django 1.6 & 1.7).

The virtual environment is automatically activated upon box login.

This role depends on the Python and NGinx roles. The NGinx role is configured to
use the "django-site.js" site template on the port "8000".

### Parameters

* **requirement** : filename of the requirements file, the file must be located in the project "requirements" directory, default "base"
* **django_root** : root directory of the Django project, default to the "root_directory" variable defined in parameters.yml
* **env_root** : directory where the virtual environment must be created, default to "~/ENV"
* **django_version** : django version, the django version actually installed is decided via the requirements, this is only to determine how to perform migrations, default to "1.8"


## Java

Install a Java Runtime Environment using the OpenJDK Debian package.

## MySQL

Install and set up a MySQL server and then create the configured user and database.

The database administrative user is "root" with the "root" password.

This role must be included before the Django one if both are present in order for the
Django role to be able to configure the database correctly.

### Parameters

* **database_name** : the name of the database to create, set in parameters.yml
* **database_user**: the name of the user, defaults to the database name
* **database_password**: the password of the user, defaults to the database name

## NGinx

Install the NGinx web server and configure a virtual host based on the given site template.
Except if you need to serve only static files, you should not have to include this role
yourself, the Django or PHP-FPM roles do it automatically with the correct parameters.

The server logs are stored in `/var/log/nginx/<hostname>.(error|access).log`.

### Parameters

* **site_template** : The virtual host template to use, defaults to "default-site.j2" for
  static websites only, possible values are "default-site.j2", "django-site.j2" and "php-site.j2"
* **index** : what file do we use as an index ? defaults to 'false'
* **static_host** : Which static host to use for Django projects ? defaults to "false".
* **static_dir** : Which static URL dir to use for Django projects ? defaults to "false".
* **static_fs_dir** : Which static filesystem dir to use for Django projects ? defaults to "".
* **expire_time** : Expiration time of static files, defaults to "6h"

## PHP

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

### Parameters

* **php_error_reporting** : php error reporting, defaults to "E_ALL | E_STRICT"
* **php_max_execution** _time** : script max exectution time, defaults to "3600"
* **php_memory_limit** : memory limit, defaults to "4G"
* **php_upload_max_filesize** : maximal size of uploaded file, defaults to "128M"
* **php_date_timezone** : timezone, defaults to "Europe/Zurich"
* **php_default_charset** : default charset, defaults to "UTF-8"

## PHP-Apache

Install libapache2-mod-php5 so that PHP can be used with Apache.

Depends on the PHP and Apache role.

## PHP-FPM

Install php5-fpm so that you can use PHP with NGinx.

Depends on the PHP and NGinx role.

## PostgreSQL

Install and set up a PostgreSQL server and then create the configured user and database.

This role must be included before the Django one if both are present in order for the
Django role to be able to configure the database correctly.

### Parameters

* **database_name** : the name of the database to create, set in parameters.yml
* **database_user**: the name of the user, defaults to the database name
* **database_password**: the password of the user, defaults to the database name

## Python

Install Pip and Virtualenv along with dev dependencies. Dependencies to build the
Pillow package are also installed.

# RMT - Release Management Tool

Install RMT in the box. Once done you can use it on the shell by running `RMT`
For more info on usage, go on https://github.com/liip/RMT#usage

## Ruby

Install Ruby gem integration for Debian and dev dependencies.

Any Debian ruby package should then be also recognized as a Gem. You can however
continue to install Gems using the `gem` utility if you need a specific version
or an unavailable package.

## Solr

Create a "solr" user, then download and extract the given Solr package in the box.

Solr is then launched automatically using the Supervisor role.

### Parameters

* **solr_base_dir** : Solr base directory, this is not directly used by the role, defaults to "/opt/solr"
* **solr.url** : The Solr package to use, defaults to "http://archive.apache.org/dist/lucene/solr/3.5.0/apache-solr-3.5.0.tgz"
* **solr.install_dir** : Solr installation directory, defaults to the solr_base_dir
* **solr.config_dir** : Solr configuration directory, defaults to "solr_base_dir/example/"

## Supervisor

Install Supervisor so that you can manage long lived processes inside the box.
A config file based on the parameters is also created for your service.

The service are automatically started on boot and restarted if they fail.

If you need multiple services, just include the role multiple times with the various parameters.

### Parameters

* **service_name** : name of the service
* **user** : user to use to launch the service
* **command** : the command to launch
* **root_directory** : the base directory for the service

## tmpfs

Configure a path to be mounted as a tmpfs (ie : in memory filesystem).

This can be used to speed up application, for example by putting their log directory in memory
thus avoiding costly network transfers for shared directories.

### Parameters

* **mount_path** : the path to replace with a tmpfs

## SSL

If you set the `ssl` parameter to true in your `parameters.yml` file, ansible will create a
Certification Authority (CA) and then create and sign SSL certificates for all hosts configured
for your project.

The CA certificate will then be copied to your project `root_directory`. If you add this
certificate to your trust store, you should be able to access your websites with HTTPS without
any error messages from most browsers.

If the role is activated, both Apache and NGinx will be configured to use the created certificates.

WARNING: if the certificate is regenerated because you did a `vagrant destroy` or the hostname
changed, you will need to reimport the CA certificate into your trust store and in the meantime you
might get errors from your browser. Chrome for example produce a pretty confusing error message about
an attacker trying to steal your credentials.
