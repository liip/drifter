*************
Customization
*************

You can customize what seems to us to be the most important options
through two files:

-  ``virtualization/parameters.yml`` for all project related parameters.
   Any value in this file will be passed to Ansible as a variable. You
   can override any role default values through this file. You can find
   details about possible parameters and values later in this
   documentation.

-  ``virtualization/playbook.yml`` for provisioning. You can control
   which roles are used to build your box. This allows you to control
   what is installed in your box.

If those two mechanisms are not enough for you, you can also modify the
``Vagrantfile``, but be aware that the risk of botching things up is far
greater.

Currently you do not have a lot of control, but we will glad to add
anything making sense to this file. Feel free to ask and we will comply
;)
