Drifter
=======

Drifter is a framework to help provision developer boxes using Ansible and Vagrant.

Requirements
------------

* Vagrant >= 1.8.4

You also need a virtualization solution, either one of those :

* Virtualbox >= 4.3
* LXC >= 1.0 & vagrant-lxc >= 1.0.0.alpha.2

Optional dependencies :

* vagrant-hostmanager >= 1.5.0 (will be automatically used if installed, make sure it's at least 1.5.0 if you have it)
* Ansible >= 1.9.0 (if you want to use a different provisioner than the default `ansible-local`)

Install Requirements
------------

### Debian Stretch (testing) and Ubuntu Xenial 16.04

Open a termain and run :

```
sudo apt-get install vagrant vagrant-lxc vagrant-cachier
vagrant plugin install vagrant-hostmanager
```

## older Debian and Ubuntu

Go to https://www.vagrantup.com/downloads.html to download and install the latest Vagrant version.

Then open a terminal and run :

```
sudo apt-get install lxc redir    # this is needed for LXC provider
vagrant plugin install vagrant-lxc vagrant-cachier vagrant-hostmanager
```

### Mac OS X

Go to https://www.vagrantup.com/downloads.html to download and install the latest Vagrant version.

Go to https://www.virtualbox.org/wiki/Downloads to download and install the latest VirtualBox version.

Then open a terminal and run :

```
vagrant plugin install vagrant-lxc vagrant-cachier vagrant-hostmanager
```

You can also use `cask` to help with the installation :

```
brew cask install vagrant virtualbox
```

### Windows

Install Virtualbox and Vagrant (>= 1.8.4) using the binaries available on their respective websites.

Goals
-----

* Streamline our project setups
* Ease the "entry cost" for a new squad member
* Easy to use
* Lean : small codebase, easy to maintain and extend, focus only on Debian and Ubuntu
* Be adopted by Liip as a whole

The idea behind the framework
-----------------------------

The idea is to have a common ground for each project that can be improved over time, each project
benefiting from the improvements.

This repository aims to contain multiples Ansible roles to manage the various part of the development
stack needed to work on the various projects of Liip.  If a someone need new roles,
it is highly recommended that they are added to the common pool if they are deemed reusable.

Each squad can tailor its box to its need by modifying the Ansible playbook which should ultimately only
contain role inclusion to maximize reuse.

When installed, Drifter creates a parameters file to hold various information about your project, a
playbook file where you can choose what to install and finally a Vagrantfile where you can modify
some Vagrant related parameters before the "main" Vagrantfile is included. This should offer enough
flexibility for every projects.

What this framework is not ?
----------------------------

This framework does not aim to provide a way to deploy staging and production servers for your project.
The roles are written with a development box in mind and are thus not fit for server provisioning. There
are absolutely no security consideration.

However, if your server is using a Debian based OS based on the stable release, both configuration
should be close enough so that you won't run into issues.

Customization
-------------

You can customize what seems to us to be the more important option trough two files :

* `virtualization/parameters.yml` for every project related parameters. Any value in this
file will be passed to ansible as a variable. You can override any role default value
through this file. You can find details about possible parameters and values later in
this documentation.
* `virtualization/playbook.yml` for provisioning. You can control which roles are
used to build your box. This allows you to control what is installed in your box.

If those two mechanism are not enough for you, you can also modify the `Vagrantfile`, but
be aware that the risk of botching things up is far greater.

Currently you do not have a lot of control, but we will glad to add anything making sense
to this file. Feel free to ask and we will comply ;)

Intended Public
===============

This project was first and foremost created to be used inside of Liip, but you are more than
welcome to use it for personal projects or anywhere else you'd like to.
