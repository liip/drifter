***************
Webserver Roles
***************

Apache
======

This roles installs Apache and the required virtual host configuration
for your project.

Except for a static website, it should not be used directly because it
is automatically included by other roles, for example PHP-Apache.

Parameters
----------

To be completed

NGinx
=====

Install the NGinx web server and configure a virtual host based on the
given site template. Except if you need to serve only static files, you
should not have to include this role yourself, the Django or PHP-FPM
roles do it automatically with the correct parameters.

The server logs are stored in
``/var/log/nginx/<hostname>.(error|access).log``.

You can have your own site template in your project directory,
for example `virtualization/templates/nginx.j2` and extend one of the
default templates provided:

.. code-block:: jinja

    {% extends "nginx/templates/default-site.j2" %}

    {% block extra %}
        {{ super() }}

        # Here goes your custom Nginx rules
    {% endblock %}

Then set the ``site_template`` parameter to ``nginx.j2`` when including the nginx role (or any other that depend
on the nginx role):

.. code-block:: yaml

    roles:
        - { role: nginx, site_template: nginx.j2 }


If you want to use roles that include nginx, such as php-fpm, make sure you use the right parameter name (check the
docs):

.. code-block:: yaml

    roles:
        - { role: php-fpm, nginx_site_template: nginx.j2 }


Parameters
----------

-  **site_template** : The virtual host template to use, defaults to
   "default-site.j2" for static websites only, possible values are:

  -  ``default-site.j2``
  -  ``django-site.j2`` Site template for Django
  -  ``drupal6-site.j2`` Site template for Drupal6
  -  ``drupal7-site.j2`` Site template for Drupal7
  -  ``drupal8-site.j2`` Site template for Drupal8
  -  ``php-site.j2`` Site template for generic PHP
  -  ``silex-site.j2`` Site template for Silex
  -  ``symfony2-site.j2`` Site template for Symfony2

-  **index** : what file do we use as an index ? defaults to 'false'
-  **static_host** : Which static host to use for Django projects ?
   defaults to "false".
-  **static_dir** : Which static URL dir to use for Django projects ?
   defaults to "false".
-  **static_fs_dir** : Which static filesystem dir to use for Django
   projects ? defaults to "".
-  **expire_time** : Expiration time of static files, defaults to "6h"
