# Base

This roles installs various useful software like vim, ack-grep, etc. It also put some
configuration files of the vagrant user home directory.

It should always be included to have a common environment in all vagrant boxes.

# Git

Install Git and some sane configuration and sync the username and e-mail from the host.

[Fancy-diff](https://github.com/so-fancy/diff-so-fancy) is also installed by default and
you can opt-in to sync your git configuration on each `vagrant up`.

## Parameters

* **fancy_diff** : install fancy-diff
* **sync_git_with_host** : sync your host git config on each `vagrant up`

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
* **environment_vars** : environment vars you want to set

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
changed, you will need to re import the CA certificate into your trust store and in the meantime you
might get errors from your browser. Chrome for example produce a pretty confusing error message about
an attacker trying to steal your credentials.

# SSH

Disable SSH strict host key checking if `ssh_no_stricthostkeychecking` is set to true in the parameters.

Also add the github and gitlab.liip.ch host key to the `kwown_host` file.

## Parameters

* **ssh_no_stricthostkeychecking** : if set to true, disable SSH strict host key checking

# Redis

To be completed.

# RabbitMQ

To be completed.

# LogStash
