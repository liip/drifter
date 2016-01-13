Drifter
=======

Drifter is a framework to help provision developer boxes using Ansible and Vagrant.

Requirements
------------

* Vagrant >= 1.6.2 (on Windows you need >= 1.8.1)
* Ansible >= 1.7.2 (starting with Vagrant 1.8.1 this dependency is optional)

You also need a virtualization solution, either one of those :

* Virtualbox >= 4.3
* LXC >= 1.0 & vagrant-lxc >= 1.0.0.alpha.2

Optional dependencies :

* vagrant-hostmanager >= 1.5.0 (will be automatically used if installed, make sure it's at least 1.5.0 if you have it)

Documentation
-------------

You can find the complete documentation on Read The Docs : http://liip-drifter.rtfd.org/

TL;DR;
------

To install it in your project, simply run the following in your project root :

```
curl -sS https://raw.githubusercontent.com/liip/drifter/master/install.sh | /bin/bash
```

This will create a `Vagrantfile` in your root and a `virtualization` folder
containing configuration option. You now have to follow those two steps :

* edit `virtualization/parameters.yml` to set parameters related to your project
* edit `virtualization/playbook.yml` to configure what to install in your box

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
