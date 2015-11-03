RAWBOT Virtualization Framework
===============================

This repository is supposed to be used as a git submodule to quickly
bootstrap the virtualization stack of a new or existing project.

For the complete steps on how to create a project from scratch for the
RAWBOT team, please see "[RAWBOT Project Howto][1]" in the Liip wiki.

[1]: https://wiki.liip.ch/display/INTERN/New+project+How-to

TL;DR;
------

To install it in your project, simply run the following in your project root :

```
curl -sS https://raw.githubusercontent.com/team-rawbot/rawbot-virtualization/master/install.sh | /bin/bash
```

This will create a `Vagrantfile` in your root and a `virtualization` folder
containing configuration option. You now have to follow those two steps :

* edit `virtualization/parameters.yml` to set parameters related to your project
* edit `virtualization/playbook.yml` to configure what to install in your box

Those two files are commented to ease the task, but if you have any questions please
refer to this README or ask Gilles Crettenand or Sylvain Fankhauser. Please do not
edit the `Vagrantfile` directly, if you need to customize your project further,
please take the time to read the rest of this file.

You now just have to launch your Vagrant box and start hacking :

```
vagrant up
```

Beforehand, we highly recommend installing the `vagrant-hostmanager` plugin so that
your `/etc/hosts/` file is automatically updated with the correct ip :

```
vagrant plugin install vagrant-hostmanager
```

If you are a lucky linux user, you can use the LXC provider to have a much quicker
box :

```
vagrant plugin install vagrant-lxc
vagrant up --provider lxc
```

Requirements
------------

* Vagrant >= 1.6.2
* Ansible >= 1.7.2

You also need a virtualization solution, either one of those :

* Virtualbox >= 4.3
* LXC >= 1.0 & vagrant-lxc >= 1.0.0.alpha.2

Optional dependencies :

* vagrant-hostmanager >= 1.5.0 (will be automatically used if installed, make sure it's at least 1.5.0 if you have it)

### Linux (Debian & Ubuntu)

For Vagrant and Ansible :

```
apt-get install -y vagrant ansible
```

For Virtualbox :

```
apt-get install -y virtualbox
```

For LXC :

```
apt-get install -y lxc
vagrant plugin install vagrant-lxc
```

### Max OS X

For Ansible :

```
brew install ansible
```

For Vagrant & Virtualbox :

with cask:

```
brew cask install vagrant virtualbox
```

Otherwise download the binaries and install the apps the as usual.

### Windows

TODO: explain how to install the requirements on Windows

Goals
-----

* Streamline our project setups
* Ease the "entry cost" for a new squad member
* Easy to use
* Be adopted by the team as a whole

The idea behind the framework
-----------------------------

The idea is to have a common ground for each project that can be improved over time, each project
benefiting from the improvements.

This repository aims to contain multiples Ansible roles to manage the various part of the development
stack needed to work on the various projects of the RAWBOT team in Lausanne.  If a squad need new roles,
it is highly recommended that they are added to the common pool if they are deemed reusable.

Each squad can tailor its box to its need by modifying the Ansible playbook which should ultimately only
contain role inclusion to maximize reuse.

A common Vagrantfile is also provided to simplify the process even more. An extension mechanism is
in place to provide fine grained control through a parameters file and an included ruby file. This
process is currently in its infancy but it should be sufficient to allow enough customization so
that each project can share the Vagrantfile thus enabling reuse.

What this framework is not ?
----------------------------

This framework does not aim to provide a way to deploy staging and production severs for your project.
The roles are written with a development box in mind and are thus not fit for server provisioning.

However, if your server is using a Debian based OS based on the stable release, both configuration
should be close enough so that you don't run into issues.


Customization
-------------

You can customize what seems to us to be the more important option trough two files :

* `virtualization/parameters.yml` for every project related parameters. Any value in this
file will be passed to ansible as a variable. You can override any role default value
through this file.
* `virtualization/playbook.yml` for provisioning. You can control which roles are
used to build your box. This allows you to control what is installed in your box.

If those two mechanism are not enough for you, you can also extand the `Vagrantfile`
through the `virtualization/VagrantfileExtra.rb` file. You should not have to
touch the `Vagrantfile` at all.

Currently you do not have a lot of control, but we will glad to add anything making sense
to this file. Feel free to ask and we will comply ;)

Submodule access without login
------------------------------

The submodule is initially configured to use your own credentials to access the Github
repository. In some situation, it is possible you will require read-only access without
your credentials.

For this case, a read-only account is available and can be configured directly in the
submodule repositoriy URL, please ask Gilles or Sylvain for more information.


The roles in detail
-------------------

Here is a quick description of each roles. When applicable, the possible parameters
are also described. The parameters can be set upon role inclusion.

### Apache

This roles installs Apache and the required virtual host configuration for your project.

Except for a static website, it should not be used directly because it is automatically
included by other roles, for example PHP-Apache.

#### Parameters

To be completed.

### Base

This roles installs various useful software like vim, ack-grep, etc. It also put some
configuration files of the vagrant user home directory.

It should always be included to have a common environement in all vagrant boxes.

### Compass

Install Compass and incidentally Sass. Also install the Ruby role as a dependency.

### Composer

Install Composer, the PHP package manager. The PHP role is defined as a dependency.
You can set the install dir, a link is `/usr/local/bin` will be set up whichever the
install dir is so that composer can be accessed globally.

If composer is already installed, this role will update it instead.

#### Parameters

* **composer.dir** : where to install the binary, default "opt/composer"

### Django

Create a python virtual environment and install application requirements via pip.
Also configure database access via environment variable and then run migrations
(compatible with Django 1.6 & 1.7).

The virtual environment is automatically activated upon box login.

This role depends on the Python and NGinx roles. The NGinx role is configured to
use the "django-site.js" site template on the port "8000".

#### Parameters

* **requirement** : filename of the requirements file, the file must be located in the project "requirements" directory, default "base"
* **django_root** : root directory of the Django project, default to the "root_directory" variable defined in parameters.yml
* **env_root** : directory where the virtual environment must be created, default to "~/ENV"
* **django_version** : django version, the django version actually installed is decided via the requirements, this is only to determine how to perform migrations, default to "1.8"


### Java

Install a Java Runtime Environment using the OpenJDK Debian package.

### MySQL

Install and set up a MySQL server and then create the configured user and database.

The database administrative user is "root" with the "root" password.

This role must be included before the Django one if both are present in order for the
Django role to be able to configure the database correctly.

#### Parameters

* **database_name** : the name of the database to create, set in parameters.yml
* **database_user**: the name of the user, defaults to the database name
* **database_password**: the password of the user, defaults to the database name

### NGinx

Install the NGinx web server and configure a virtual host based on the given site template.
Except if you need to serve only static files, you should not have to include this role
yourself, the Django or PHP-FPM roles do it automatically with the correct parameters.

The server logs are stored in `/var/log/nginx/<hostname>.(error|access).log`.

For now, there is no SSL support for the NGinx role, ask if you need it !

#### Parameters

* **site_template** : The virtual host template to use, defaults to "default-site.j2" for
  static websites only, possible values are "default-site.j2", "django-site.j2" and "php-site.j2"
* **index** : what file do we use as an index ? defaults to 'false'
* **static_host** : Which static host to use for Django projects ? defaults to "false".
* **static_dir** : Which static URL dir to use for Django projects ? defaults to "false".
* **static_fs_dir** : Which static filesystem dir to use for Django projects ? defaults to "".
* **expire_time** : Expiration time of static files, defaults to "6h"

### PHP

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

#### Parameters

* **php_error_reporting** : php error reporting, defaults to "E_ALL | E_STRICT"
* **php_max_execution** _time** : script max exectution time, defaults to "3600"
* **php_memory_limit** : memory limit, defaults to "4G"
* **php_upload_max_filesize** : maximal size of uploaded file, defaults to "128M"
* **php_date_timezone** : timezone, defaults to "Europe/Zurich"
* **php_default_charset** : default charset, defaults to "UTF-8"

### PHP-Apache

Install libapache2-mod-php5 so that PHP can be used with Apache.

Depends on the PHP and Apache role.

### PHP-FPM

Install php5-fpm so that you can use PHP with NGinx.

Depends on the PHP and NGinx role.

### PostgreSQL

Install and set up a PostgreSQL server and then create the configured user and database.

This role must be included before the Django one if both are present in order for the
Django role to be able to configure the database correctly.

#### Parameters

* **database_name** : the name of the database to create, set in parameters.yml
* **database_user**: the name of the user, defaults to the database name
* **database_password**: the password of the user, defaults to the database name

### Python

Install Pip and Virtualenv along with dev dependencies. Dependencies to build the
Pillow package are also installed.

### Ruby

Install Ruby gem integration for Debian and dev dependencies.

Any Debian ruby package should then be also recognized as a Gem. You can however
continue to install Gems using the `gem` utility if you need a specific version
or an unavailable package.

### Solr

Create a "solr" user, then download and extract the given Solr package in the box.

Solr is then launched automatically using the Supervisor role.

#### Parameters

* **solr_base_dir** : Solr base directory, this is not directly used by the role, defaults to "/opt/solr"
* **solr.url** : The Solr package to use, defaults to "http://archive.apache.org/dist/lucene/solr/3.5.0/apache-solr-3.5.0.tgz"
* **solr.install_dir** : Solr installation directory, defaults to the solr_base_dir
* **solr.config_dir** : Solr configuration directory, defaults to "solr_base_dir/example/"

### Supervisor

Install Supervisor so that you can manage long lived processes inside the box.
A config file based on the parameters is also created for your service.

The service are automatically started on boot and restarted if they fail.

If you need multiple services, just include the role multiple times with the various parameters.

#### Parameters

* **service_name** : name of the service
* **user** : user to use to launch the service
* **command** : the command to launch
* **root_directory** : the base directory for the service

### tmpfs

Configure a path to be mounted as a tmpfs (ie : in memory filesystem).

This can be used to speed up application, for example by putting their log directory in memory
thus avoiding costly network transfers for shared directories.

#### Parameters

* **mount_path** : the path to replace with a tmpfs

### Mailcatcher

Allows you to catch emails right in the box. With mailcatcher it's very easy to test a application which sends email. You only need to use __127.0.0.1:1025__ for SMTP in your application. All mails that goes to this port will be immediately shown in the webinterface which you can find under __http://[url_or_ip_to_your_box]:1080__. They weren't then redirected to their real destination.

More infos at: [mailcatcher.me](http://mailcatcher.me)



PHP Debugging with RVF & PHPStorm
---------------------------------

As said earlier, the PHP role installs php-xdebug which is configured to try to connect to any
listener on the host.

If you are using Chrome and PHPStorm, debugging a script can be easily done :

1° Install the (Xdebug helper chrome extension)[2]
2° In your browser address bar, click on the little bug and select "Debug"
3° In PHPStorm, open the "Run" menu and select "Start Listen for PHP Debug connection"
4° Reload the page in your browser
5° A dialog should open in PHPStorm to ask you which file you want to debug, choose the entry point of your application

[2]: https://chrome.google.com/webstore/detail/xdebug-helper/eadndfjplgieldjbigjakmdgkmoaaaoc

The future ?
------------

The framework will evolve as we use it on more projects. It is not the goal to refrain you
from doing anything. It will be improved as we need it, the goal is to serve the team !

What could be done if the need arise :

* Better installer with questions to automatically create the config files instead of manual editing
* Improve the `Vagrantfile` extension mechanism
* Provide a role to simply the creation of a Symfony project

Create boxes
------------

### LXC

```
git clone https://github.com/team-rawbot/vagrant-lxc-base-boxes
cd vagrant-lxc-base-boxes
make jessie
```

If you're getting errors when trying to install the base packages, check your
default LXC config (`/etc/lxc/default.conf`) and adapt it to your setup:

```
lxc.network.type = veth
lxc.network.link = lxcbr0
lxc.network.flags = up
```

### VirtualBox

Install [veewee](https://github.com/jedi4ever/veewee/) and then:

```
git clone https://github.com/team-rawbot/veewee-definitions definitions
veewee vbox build liip-jessie64
veewee vbox export liip-jessie64
```
