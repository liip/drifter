Create boxes
============

Current way
-----------

Used for the current boxes available on
https://vagrantbox-public.liip.ch/

See https://gitlab.liip.ch/liip/drifter-base-boxes

Ansible
~~~~~~~

If you plan on using the ``ansible_local`` provisioner, ``ansible`` must
be installed in the box with at least a version of 1.9.0 otherwise the
roles won't work.

Other way (older, may still work)
---------------------------------

LXC
~~~

::

    git clone https://github.com/team-rawbot/vagrant-lxc-base-boxes
    cd vagrant-lxc-base-boxes
    make jessie

If you're getting errors when trying to install the base packages, check
your default LXC config (``/etc/lxc/default.conf``) and adapt it to your
setup:

::

    lxc.network.type = veth
    lxc.network.link = lxcbr0
    lxc.network.flags = up

VirtualBox
~~~~~~~~~~

Install `veewee <https://github.com/jedi4ever/veewee/>`__ and then:

::

    git clone https://github.com/team-rawbot/veewee-definitions definitions
    veewee vbox build liip-jessie64
    veewee vbox export liip-jessie64
