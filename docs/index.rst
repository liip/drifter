*******
Drifter
*******

Drifter is a framework to help provision developer boxes using Ansible
and Vagrant.


Goals
=====

-  Streamline our project setups
-  Ease the "entry cost" for a new squad member
-  Easy to use
-  Lean: small codebase, easy to maintain and extend, focus only on
   Debian and Ubuntu
-  Be adopted by Liip as a whole

The idea behind the framework
=============================

The idea is to have a common ground for each project that can be
improved over time, each project benefiting from the improvements.

This repository aims to contain multiples Ansible roles to manage the
various part of the development stack needed to work on the various
projects of Liip. If a someone need new roles, it is highly recommended
that they are added to the common pool if they are deemed reusable.

Each squad can tailor its box to its need by modifying the Ansible
playbook which should ultimately only contain role inclusion to maximize
reuse.

When installed, Drifter creates a parameters file to hold various
information about your project, a playbook file where you can choose
what to install and finally a Vagrantfile where you can modify some
Vagrant related parameters before the "main" Vagrantfile is included.
This should offer enough flexibility for every project.

What this framework is not ?
============================

This framework does not aim to provide a way to deploy staging and
production servers for your project. The roles are written with a
development box in mind and are thus not fit for server provisioning.
There are absolutely no security issues taken into consideration.

However, if your server is using a Debian based OS based on the stable
release, both configurations should be close enough so that you won't
run into issues.

Intended Public
===============

This project was first and foremost created to be used inside of Liip,
but you are more than welcome to use it for personal projects or
anywhere else you'd like to.



.. toctree::
    :caption: Getting Started
    :maxdepth: 2

    requirements
    usage
    customization
    contributing

.. toctree::
    :caption: Roles
    :maxdepth: 2


    roles/system
    roles/webservers
    roles/databases
    roles/php
    roles/python
    roles/ruby
    roles/java
    roles/webpack
    roles/gulp
    roles/browsers
    roles/others

.. toctree::
    :caption: Tips & Tricks
    :maxdepth: 1

    tips/php
    tips/ci


.. toctree::
    :caption: Other Info
    :maxdepth: 2

    roadmap
    boxes
    migrations
