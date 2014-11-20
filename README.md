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

* Vagrant >= 1.5
* Ansible >= 1.6

Linux (Debian & Unbuntu)
------------------------

```
apt-get install -y vagrant ansible
```

Max OS X
--------

TODO

Windows
-------

TODO

Installation
============

Hipster-style (piping curl output to sh)
----------------------------------------

```
curl -sS https://raw.githubusercontent.com/team-rawbot/rawbot-virtualization/master/install.sh | /bin/bash
```

Manually
--------

Have a look at the `install.sh` script and just manually reproduce it.

Using it
========

What you'll probably want to do first is edit the `Vagrantfile` file. Don't do
this, instead edit the `parameters.yml` file and set the values accordingly. If
you need finer control or if you like writing Ruby code, edit the
`VagrantfileExtra.rb`. You should never edit the `Vagrantfile` file since it's
part of the submodule, this way you'll be able to get it updated when it gets
updated in this repository.

Various roles are provided in the `provisioning/roles` directory. Each of those
roles should be autonomous, but you probably will have to use multiple of them
to have a coherent system. For example :

* base
* nginx
* php-fpm
* mysql

If you want a PHP website served with an nginx server. An exemple on how to do that is given in the
`provisioning/playbook.yml` file, you should adapt it to the need of your project.

Vagrant
=======

TBW
