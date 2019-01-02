************
Python Roles
************

Python
======

Install Pip and Virtualenv along with dev dependencies. Dependencies to
build the Pillow package are also installed.

Both Python 2 and Python 3 are always installed, for example to facilitate
tests on multiple python version, the parameter below only change the
behavior of python related roles.

Parameters
----------

-  **python_version**: version of Python to use. Can be 2 or 3, defaults to "3"
-  **pip_version** : the version of pip to install in the virtual environment. Defaults to 9.0.1.
-  **setuptools_version** : the version of setuptools to install in the virtual environment. Defaults to 28.8.0.
-  **python3_install_from_source**: whether to install Python from source (true) or use the distribution version (false). Defaults to false
-  **python3_source_version**: Python version like 3.5.5, defaults to "3.6.5"

.. _virtualenv-reference-label:

Virtualenv
==========

Create a python virtual environment and install application requirements
via pip. The environment will also get `pip-tools <https://github.com/jazzband/pip-tools>`_ installed.

The virtual environment is automatically activated upon box login.

-  **pip\_requirements** : filename of the requirements file, defaults to
   "requirements/dev.txt"
-  **env\_root** : directory where the virtual environment must be
   created, defaults to "~/ENV"
-  **pip\_requirements\_dir** : name of the requirements directory that contain the `.in` files. If set, Drifter will
   run ``pip-compile`` on these files upon provisioning.
-  **pip_tools\_version** : the version of pip-tools to install in the virtual environment. Defaults to 1.8.2.

Django
======

Uses the ``virtualenv`` or the ``pipenv`` role (depending on the
``django_use_pipenv`` parameter) to create and install a virtual
environment for Django.

Configure database access via environment variable and then run
migrations.

You need to include either to ``mysql`` or ``postgresql`` roles before
this one.

This role depends on the Virtualenv and NGinx roles. The NGinx role is
configured to use the "django-site.js" site template on the port "8000".

Parameters
----------

- **django_root** : root directory of the Django project, default to
   the "root_directory" variable defined in parameters.yml
- **django_use_pipenv**: whether to use Pipenv to install requirements. Defaults to false.

Flask
=====

.. note::

    This module is deprecated and will be removed in a future version. Using the :ref:`virtualenv-reference-label` role
    will achieve the same result.

Uses the ``virtualenv`` role to create and install a virtual environment
for Flask.
