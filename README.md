RawBot Docker
=============

This repository is a template to ease creating development environment for the RawBot team @ Liip Lausanne.

It contains :

* A Vagrantfile template to create a Vagrant boxes
* Ansible playbooks templates to provision the image based on the needs (PHP, Django, etc)

Overview
========

In order to streamline our project setups and to ease the "entry cost" for a new squad member, we
decided as a team to use a common virtualized development environment.

Requirements
============

You must have vagrant installed.

Linux (Debian & Unbuntu)
------------------------

```
apt-get install -y vagrant
```

Max OS X
--------

TODO

Windows
-------

TODO

Use it on your projects
=======================

curl -sS https://raw.githubusercontent.com/team-rawbot/rawbot-docker/master/install.sh | /bin/bash

Rational
========

LXC containers works great on Linux hosts, however they are not available on Mac OS X or Windows.

It was decided to a Vagrant based solution. A bunch of Ansible roles to ease provisioning of the
box is also provided.

Ansible
=======

Various roles are provided in the `provisioning/roles` directory. Each of those roles should be autonomous,
but you probably will have to use multiple of them to have a coherent system. For example :

* base
* nginx
* php-fpm
* mysql

If you want a PHP website served with an nginx server. An exemple on how to do that is given in the
`provisioning/playbook.yml` file, you should adapt it to the need of your project.

Vagrant
=======

TBW
