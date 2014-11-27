RAWBOT Virtualization Framework
===============================

This repository is supposed to be used as a git submodule to allow for quick
bootstrap of the virtualization stack of a new or existing project.

For the complete steps on how to create a project from scratch for the
RAWBOT team, please see "[RAWBOT Project Howto][1]" in the Liip wiki.

[1]: http://need.some.url.here

TL;DR;
------

To install it in your project, simply run the following in your project root :

```
curl -sS https://raw.githubusercontent.com/team-rawbot/rawbot-virtualization/master/install.sh | /bin/bash
```

This will create a `Vagrantfile` in your root and a `virtualization` folder
containing configuration option. You know have to follow those two steps :

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

* vagrant-hostmanager >= 1.5.0

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

TODO: explain how to install the requirements on a Mac

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


The roles in detail
-------------------

TODO: list the roles and describe them with their option and parameters.

The future ?
------------

The framework will evolve as we use it on more projects. It is not the goal to refrain you
from doing anything. It will be improved as we need it, the goal is to serve the team !

What could be done if the need arise :

* Better installer with questions to automatically create the config files instead of manual editing
* Improve the `Vagrantfile` extension mechanism
* Provide a role to simply the creation of a Symfony project
