# Python

Install Pip and Virtualenv along with dev dependencies. Dependencies to build the
Pillow package are also installed.

# Django

Create a python virtual environment and install application requirements via pip.
Also configure database access via environment variable and then run migrations
(compatible with Django 1.6 & 1.7).

The virtual environment is automatically activated upon box login.

This role depends on the Python and NGinx roles. The NGinx role is configured to
use the "django-site.js" site template on the port "8000".

## Parameters

* **requirement** : filename of the requirements file, the file must be located in the project "requirements" directory, default "base"
* **django_root** : root directory of the Django project, default to the "root_directory" variable defined in parameters.yml
* **env_root** : directory where the virtual environment must be created, default to "~/ENV"
* **django_version** : django version, the django version actually installed is decided via the requirements, this is only to determine how to perform migrations, default to "1.8"
