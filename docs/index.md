Drifter
=======

Drifter is a framework to help provision developer boxes using Ansible and Vagrant.

Goals
-----

* Streamline our project setups
* Ease the "entry cost" for a new squad member
* Easy to use
* Lean: small codebase, easy to maintain and extend, focus only on Debian and Ubuntu
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
flexibility for every project.


What this framework is not ?
----------------------------

This framework does not aim to provide a way to deploy staging and production servers for your project.
The roles are written with a development box in mind and are thus not fit for server provisioning. There
are absolutely no security issues taken into consideration.

However, if your server is using a Debian based OS based on the stable release, both configurations
should be close enough so that you won't run into issues.


Intended Public
---------------

This project was first and foremost created to be used inside of Liip, but you are more than
welcome to use it for personal projects or anywhere else you'd like to.


Requirements
============

* Vagrant >= 1.8.4
* Git >= 1.0

You also need a virtualization solution, either one of these:

* Virtualbox >= 4.3
* LXC >= 1.0 & vagrant-lxc >= 1.0.0.alpha.2

Optional dependencies:

* [vagrant-hostmanager](https://github.com/devopsgroup-io/vagrant-hostmanager) A Vagrant plugin that manages /etc/hosts files. (will be automatically used if installed, make sure it's at least 1.5.0 if you have it)
* [vagrant-cachier](https://github.com/fgrehm/vagrant-cachier) A Vagrant plugin that share common package cache among similar VM instances.


Install Requirements
--------------------

### Debian Stretch (testing) and Ubuntu Xenial 16.04

Open a terminal and run:

```
sudo apt-get install vagrant vagrant-lxc vagrant-cachier
vagrant plugin install vagrant-hostmanager
```

#### Older Debian and Ubuntu versions

Go to https://www.vagrantup.com/downloads.html to download and install the latest Vagrant version.
Then open a terminal and run:

```
sudo apt-get install lxc redir    # this is needed for LXC provider
vagrant plugin install vagrant-lxc vagrant-cachier vagrant-hostmanager
```

### Mac OS X

Download and install [https://www.vagrantup.com/downloads.html](the latest Vagrant version).

Download and install [https://www.virtualbox.org/wiki/Downloads](the latest VirtualBox version).

Then open a terminal and run:

```
vagrant plugin install vagrant-cachier vagrant-hostmanager
```

You can also use `cask` to help with the installation:

```
brew cask install vagrant virtualbox
```

### Windows

Install Virtualbox and Vagrant (>= 1.8.4) using the binaries available on their respective websites.

Also make sure that `core.autocrlf` is set to `input` (recommended) or at least `true` so that you don't get issues
with Windows line-endings in the files that are in your box. You can set it by running the following command:

`git config --global core.autocrlf input`

For example if you get the following error when trying to provision the box:

```
TASK [base : ensure base packages are installed] *******************************

failed: [default] (item=[u'locales', u'procps', u'command-not-found', u'bash-completion', u'zsh', u'bzip2', u'unzip', u'vim', u'ack-grep', u'highlight', u'libxml2-utils', u'build-essential', u'wget', u'openssh-server', u'sudo', u'imagemagick', u'iputils-ping', u'ncurses-term', u'python-pycurl']) => {"failed": true, "item": ["locales", "procps", "command-not-found", "bash-completion", "zsh", "bzip2", "unzip", "vim", "ack-grep", "highlight", "libxml2-utils", "build-essential", "wget", "openssh-server", "sudo", "imagemagick", "iputils-ping", "ncurses-term", "python-pycurl"], "module_stderr": ">>> /etc/sudoers.d/sudo-passwordless: syntax error near line 1 <<<\nsudo: parse error in /etc/sudoers.d/sudo-passwordless near line 1\nsudo: no valid sudoers sources found, quitting\nsudo: unable to initialize policy plugin\n", "module_stdout": "", "msg": "MODULE FAILURE", "parsed": false}
```

That's because the sudoers file that gets copied in the box has the wrong format. Enabling `core.autocrlf` will fix the
issue.


Usage
=====

Drifter is going to be installed into your project as a git submodule. So if your project is not using Git as VCS,
start by creating a git repo:

```
cd my-project && git init
```

Then to install Drifter, simply run the following command:

```
curl -sS https://raw.githubusercontent.com/liip/drifter/master/install.sh | /bin/bash
```

This will create a `Vagrantfile` in your root and a `virtualization` folder
containing configuration files. You now have to follow those two steps:

* edit `virtualization/parameters.yml` to set parameters related to your project
* edit `virtualization/playbook.yml` to configure what to install in your box

You now just have to launch your Vagrant box and start hacking!

```
vagrant up
```


Customization
-------------

You can customize what seems to us to be the most important options through two files:

* `virtualization/parameters.yml` for all project related parameters. Any value in this
file will be passed to Ansible as a variable. You can override any role default values
through this file. You can find details about possible parameters and values later in
this documentation.

* `virtualization/playbook.yml` for provisioning. You can control which roles are
used to build your box. This allows you to control what is installed in your box.

If those two mechanisms are not enough for you, you can also modify the `Vagrantfile`, but
be aware that the risk of botching things up is far greater.

Currently you do not have a lot of control, but we will glad to add anything making sense
to this file. Feel free to ask and we will comply ;)

Contributing
------------

Before publishing your contributions please test your roles with the playground. To do so, go to the `playground`
directory, enable any role you need in `playbook.yml` and set any parameter you want in `parameters.yml` and then run
`vagrant up`. The box will use the roles of your working copy.

Please don't commit any change to the playground, unless you're fixing something in the playground.
