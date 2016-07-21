Drifter
=======

Drifter is a framework to help provision developer boxes using Ansible and Vagrant.

Requirements
------------

* Vagrant >= 1.6.2 (on Windows you need >= 1.8.1)
* Ansible >= 1.9.0 (starting with Vagrant 1.8.4 this dependency is optional)

You also need a virtualization solution, either one of those :

* Virtualbox >= 4.3
* LXC >= 1.0 & vagrant-lxc >= 1.0.0.alpha.2

Optional dependencies :

* vagrant-hostmanager >= 1.5.0 (will be automatically used if installed, make sure it's at least 1.5.0 if you have it)

Installation
------------

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

Install Virtualbox and Vagrant (>= 1.8.1)

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
stack needed to work on the various projects of Liip.  If a someone need new roles,
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

If those two mechanism are not enough for you, you can also modify the `Vagrantfile`, but
be aware that the risk of botching things up is far greater.

Currently you do not have a lot of control, but we will glad to add anything making sense
to this file. Feel free to ask and we will comply ;)

Submodule access without login
------------------------------

The submodule is initially configured to use your own credentials to access the Github
repository. In some situation, it is possible you will require read-only access without
your credentials.

For this case, a read-only account is available and can be configured directly in the
submodule repositoriy URL, please ask Gilles or Sylvain for more information.
