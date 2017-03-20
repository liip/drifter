Python
======

Install Pip and Virtualenv along with dev dependencies. Dependencies to
build the Pillow package are also installed.

Both Python 2 and Python are always installed, for example to facilitate
tests on multiple python version, the parameter below only change the
behavior of python related roles.

Parameters
----------

-  **python\_version**: Either version 2 or 3, defaults to "2"

Virtualenv
==========

Create a python virtual environment and install application requirements
via pip.

The virtual environment is automatically activated upon box login.

-  **pip\_requirement** : filename of the requirements file, defaults to
   "requirements/dev.txt"
-  **env\_root** : directory where the virtual environment must be
   created, defaults to "~/ENV"

Django
======

Uses the ``virtualenv`` role to create and install a virtual environment
for Django.

Configure database access via environment variable and then run
migrations (compatible with all Django version since 1.6).

You need to include either to ``mysql`` or ``postgresql`` roles before
this one.

This role depends on the Virtualenv and NGinx roles. The NGinx role is
configured to use the "django-site.js" site template on the port "8000".

Parameters
----------

-  **django\_root** : root directory of the Django project, default to
   the "root\_directory" variable defined in parameters.yml
-  **django\_version** : django version, the django version actually
   installed is decided via the requirements, this is only to determine
   how to perform migrations, default to "1.8"

Flask
=====

Uses the ``virtualenv`` role to create and install a virtual environment
for Flask.
