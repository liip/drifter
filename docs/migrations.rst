**********************
Migration instructions
**********************

Version 2.0
===========

Ansible version
---------------

This version of Drifter requires Ansible version >= 2.7 installed. If you're
using ``ansible_local = true`` in your `Vagrantfile` (which is the default),
you'll need to make sure Ansible 2.7 is installed on the guest. To do that, open
the file ``virtualization/parameters.yml`` in your editor and add the
following::

  ansible_version: 2.7.0

Then run the provisioning using ``vagrant provision``, this should install the
correct Ansible version.

If you're using ``ansible_local = false``, you'll need to make sure the Ansible
version installed on the host is at least 2.7. Instructions will depend on how
you installed Ansible (OS package manager, pip, etc).


Version 1.0
===========

Ansible version and ``ansible_local``
-------------------------------------

Changes were made to the roles that requires to use of at least the
version 1.9.0 of ``ansible``. This means Debian stable users have to
install ``ansible`` via the
`Backports <https://backports.debian.org/Instructions/>`__ if they don't
want to use the ``ansible_local`` provisioner.

Also, the default is now ``ansible_local`` also for LXC and the Vagrant
version was bumped to 1.8.4 in this case to get rid of the bug that
caused issues before. This is the new recommanded provisioner.

Old Vagrantfile format
----------------------

The support for the old Vagrantfile format has been removed in this
version. You should follow the steps detailed in the migration from
0.1.0 to 0.2.0 if you haven't done it already.

Virtualbox and LXC URLs
-----------------------

It's not possible to specify separate boxes for LXC and Virtualbox via
Drifter anymore. You need to move to the new JSON box format in order to
be able to do it. You can have a look at
https://vagrantbox-public.liip.ch/drifter-jessie64-base.json for an
example.

The ``lxc_box_name``, ``lxc_box_url``, ``vbox_box_name`` and
``vbox_box_url`` have been removed in favor of ``box_name`` and
``box_url``.

Git
---

Git installation and configuration is now in its own role. It was added
to the ``playbook.yml.dist`` file, but existing project should also add
it to their playbook if they want to have git installed.

You should also have a look at the ``git`` role documentation inside the
System roles for the new features.

PHP roles names
---------------

``redis-php`` and ``memcached-php`` roles have been renamed to follow
the already in place convention. You'll now have to use ``php-redis``
and ``php-memcached``

Flash & Django roles
--------------------

The ``flask`` and ``django`` roles now use the new ``virtualenv`` role.
This means the parameter for the requirements is now named
``pip_requirements``.

The default value for this parameter has also been changed to
"requirements/dev.txt".

Version 0.1.0 to 0.2.0
======================

In order for the framework to work correctly on Windows, we removed the
symlinks to the Vagrantfile stored in the submodule. The content of the
VagrantfileExtra.rb is now in the Vagrantfile at your project root. This
new file then loads a more complete Vagrantfile that is in the
submodule.

In order to migrate, follow those steps (commands assume you are in your
project root directory) :

1. Remove the Vagrantfile symbolic link from the root :
   ``rm -f Vagrantfile``
2. Copy the VagrantfileExtra.rb file to your root and rename it :
   ``mv virtualization/VagrantfileExtra.rb Vagrantfile``
3. Add the ``get`` method to your ``CustomConfig`` class in the
   ``Vagrantfile`` (copy the snippet below inside the class)
4. Add the loading of the complete Vagrantfile to the project
   Vagrantfile :
   ``echo "load 'virtualization/drifter/Vagrantfile'" >> Vagrantfile``

   def get(name, default = nil) if self.respond\_to?(name)
   self.send(name) elsif default.nil? raise "[CONFIG ERROR] '#{name}'
   cannot be found and no default provided." else default end end
