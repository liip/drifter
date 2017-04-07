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

-  **nodejs\_version** : The version to install, currently supports 7.x,
   6.x, 5.x, 4.x, 0.12 and 0.10, default being 6.x.
-  **nodejs\_distro** : Is automatically set to either 'jessie' or
   'wheezy' based on available information, you can also put an Ubuntu
   codename here.

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

Install RMT in the box. Once done you can use it on the shell by running
``RMT`` For more info on usage, go to https://github.com/liip/RMT#usage

Redis
=====

To be completed.

Gitlab CI
=========

See :doc:`../tips/ci`.
