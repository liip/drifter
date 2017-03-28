**********
Ruby Roles
**********

Ruby
====

Install ``rbenv`` along with ``Bundler``. Complete the installation with
the ``bundle install`` command if a Gemfile is found in the project root
directory.

Parameters
----------

-  **ruby\_version**: this should be the exact version name (such as
   2.3.3). Find a list of accepted version with ``rbenv install -l``.
   Default is 2.4.0

Rails
=====

Simply add roles ``nodejs`` and ``ruby`` in your playbook.yml. Note that
rails will not be installed unless specified in your Gemfile.

Using mysql or postgres? then include ``mysql`` or ``postgresql`` role
before ``ruby``.

In the box, run ``rails server``, then open your browser on
http://<hostname>:3000. See <hostname> in your ``parameters.yml``.
