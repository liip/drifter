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
   Default is 2.4.1.
-  **ruby_build_version**: version of ruby-build to use. Default is v20190423.

Rails
=====

Simply add roles ``nodejs`` and ``ruby`` in your playbook.yml. Note that
rails will not be installed unless specified in your Gemfile.

Using mysql or postgres? then include ``mysql`` or ``postgresql`` role
before ``ruby``.

Run server
----------

You have two options. First, in the box, run ``rails server`` or ``puma``, then open your browser on
``http://{hostname}:3000``

Second option is to add the nginx role with the rails template::

    - { role: nginx, web_directory: "/vagrant/public", site_template: "rails-site.j2", proxy_port: 3000 }

Then you can just open ``http://{hostname}``.
