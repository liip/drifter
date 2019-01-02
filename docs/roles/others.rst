***********
Other Roles
***********

Ruby
====

Install Ruby, Gem integration for Debian and dev dependencies.

Any Debian ruby package should then be also recognized as a Gem. You can
however continue to install Gems using the ``gem`` utility if you need a
specific version or an unavailable package.

NodeJS
======

Install NodeJS and NPM.

Parameters
----------

-  **nodejs\_version** : The version to install, currently supports 11.x, 10.x, 9.x, 8.x,
   7.x, 6.x, 5.x, 4.x, 0.12 and 0.10, default being 10.x.
-  **nodejs\_distro** : Is automatically set to either 'jessie' or
   'wheezy' based on available information, you can also put an Ubuntu
   codename here.
-  **nodejs_create_package_json**: create a ``package.json`` file based on the
   settings below during provisioning. Defaults to ``true``.
-  **nodejs_package_json_template**: template to use for the creation of the initial ``package.json`` file. Defaults to
  ``package.json.j2``, or ``package.json.gulp.j2`` if you're using the gulp role. See the
  ``provisioning/roles/nodejs/templates`` directory for the list of available templates.
-  **nodejs_package_json_path**: where should the package.json file be
   created, defaults to ``<root_directory>/package.json``
-  **nodejs_package_json_author**: Author that should be put in the
   package.json file, defaults to ``Liip AG``
-  **nodejs_install_package_json**: Run ``npm install`` on each provisioning. Defaults to ``true``.

OpenLDAP
========

Install an OpenLDAP (slapd) server.

It will open the standard LDAP ports (389 for ``ldap://``, 636 for
``ldaps://``), and the ``ldap-utils`` (shipping ``ldapsearch`` is also
installed.

Parameters
----------

-  **ldap\_organization** : Fulltext organization name, defaults to
   'EvilCorp Ltd'
-  **ldap\_organization\_domain** : Organization domain name, defaults
   to ``evilcorp.example.com``
-  **ldap\_admin\_password** : Password of the original
   cn=admin,dc=evilcorp,dc=example,dc=com user, defaults to 'admin'

RMT - Release Management Tool
=============================

Install RMT in the box. Once done you must run `php /home/vagrant/.config/composer/vendor/liip/rmt/RMT` to init it for your project. Then for the next steps go to https://github.com/liip/RMT#usage

Redis
=====

To be completed.

Gitlab CI
=========

See :doc:`../tips/ci`.
