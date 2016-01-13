# Base

This roles installs various useful software like vim, ack-grep, etc. It also put some
configuration files of the vagrant user home directory.

It should always be included to have a common environement in all vagrant boxes.

# Supervisor

Install Supervisor so that you can manage long lived processes inside the box.
A config file based on the parameters is also created for your service.

The service are automatically started on boot and restarted if they fail.

If you need multiple services, just include the role multiple times with the various parameters.

## Parameters

* **service_name** : name of the service
* **user** : user to use to launch the service
* **command** : the command to launch
* **root_directory** : the base directory for the service

# Java

Install a Java Runtime Environment using the OpenJDK Debian package.

# Ruby

Install Ruby gem integration for Debian and dev dependencies.

Any Debian ruby package should then be also recognized as a Gem. You can however
continue to install Gems using the `gem` utility if you need a specific version
or an unavailable package.


# tmpfs

Configure a path to be mounted as a tmpfs (ie : in memory filesystem).

This can be used to speed up application, for example by putting their log directory in memory
thus avoiding costly network transfers for shared directories.

## Parameters

* **mount_path** : the path to replace with a tmpfs

# SSL

If you set the `ssl` parameter to true in your `parameters.yml` file, ansible will create a
Certification Authority (CA) and then create and sign SSL certificates for all hosts configured
for your project.

The CA certificate will then be copied to your project `root_directory`. If you add this
certificate to your trust store, you should be able to access your websites with HTTPS without
any error messages from most browsers.

If the role is activated, both Apache and NGinx will be configured to use the created certificates.

WARNING: if the certificate is regenerated because you did a `vagrant destroy` or the hostname
changed, you will need to reimport the CA certificate into your trust store and in the meantime you
might get errors from your browser. Chrome for example produce a pretty confusing error message about
an attacker trying to steal your credentials.
