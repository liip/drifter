# Apache

This roles installs Apache and the required virtual host configuration for your project.

Except for a static website, it should not be used directly because it is automatically
included by other roles, for example PHP-Apache.

## Parameters

To be completed

# NGinx

Install the NGinx web server and configure a virtual host based on the given site template.
Except if you need to serve only static files, you should not have to include this role
yourself, the Django or PHP-FPM roles do it automatically with the correct parameters.

The server logs are stored in `/var/log/nginx/<hostname>.(error|access).log`.

## Parameters

* **site_template** : The virtual host template to use, defaults to "default-site.j2" for
  static websites only, possible values are "default-site.j2", "django-site.j2" and "php-site.j2"
* **index** : what file do we use as an index ? defaults to 'false'
* **static_host** : Which static host to use for Django projects ? defaults to "false".
* **static_dir** : Which static URL dir to use for Django projects ? defaults to "false".
* **static_fs_dir** : Which static filesystem dir to use for Django projects ? defaults to "".
* **expire_time** : Expiration time of static files, defaults to "6h"
