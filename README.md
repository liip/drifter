RawBot Docker
=============

This repository is a template to ease creating development environment for the RawBot team @ Liip Lausanne.

It contains :

* A wrapper script used to managed the environment
* A script to build a base Docker image based on a Debian environment
* A Dockerfile template to create a Docker image for a project
* Ansible playbooks templates to provision the image based on the needs (PHP, Django, etc)
* A Vagrant box to run the docker images on OS X and Windows (see https://github.com/liip/dockerbox)

Overview
========

In order to streamline our project setups and to ease the "entry cost" for a new squad member, we
decided as a team to use a common virtualized development environment.

An utility shell script (`container`) is used to manage the whole virtualized development environment.

Requirements
============

You must have docker and python-docker installed.

Linux (Debian & Unbuntu)
------------------------

```
apt-get install -y docker.io python-docker
```

Max OS X
--------

TODO

Windows
-------

TODO

Use it on your projects
=======================


Rational
========

LXC containers works great on Linux hosts, however they are not available on Mac OS X or Windows.
We tried using Vagrant, but quickly hit the wall with performance issues for project having lot
of small files accessed on each request.

It was decided to develop a custom solution to this based on Docker. We are still using Vagrant to
create a virtual machine on OSes that don't support Docker natively, but we launch *one* VM to host
multiple Docker instances thus reducing the performance cost.

One of the bottleneck of Vagrant also being the filesystem sharing, having only one VM launched allows
to fine-tune the sharing only one time and benefits from that in all development environement.

Docker image
============

Instead of using images not known to be safe from the Docker Registry ( https://registry.hub.docker.com/ ),
we try as much as possible to use images build by us. There is multiple reasons to do so :

* We use provisioning anyway
* Guarantee to know what is in the image
* Tailor-made base image to our need


Dockerfile
==========

The Dockerfile is an example that can most of the time be copied as is to the project root directory.

Its goal is to build a tailor made image for the project using Ansible provisioning to install all
necessary software packages and do required configuration.

Ansible
=======

Ansible is used for two different things.

Managing images
---------------

The `container` wrapper scripts uses mutliple Ansible playbook located in the `ansible` directory.

Provisioning
------------

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

Vagrant is used to managed the virtual machine lauched as a host on OSes that don't have native
Docker support. More information can be found in dockerbox/README.md
