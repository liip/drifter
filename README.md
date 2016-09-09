Drifter
=======

Drifter is a framework to help provision developer boxes using Ansible and Vagrant.


Documentation
-------------

You can find the complete documentation on Read The Docs : https://liip-drifter.readthedocs.io/


Project kickoff
---------------

To install Drifter in your project, simply run the following in your project root:

```
curl -sS https://raw.githubusercontent.com/liip/drifter/master/install.sh | /bin/bash
```

This will create a `Vagrantfile` in your root and a `virtualization` folder
containing configuration option. You now have to follow those two steps :

* edit `virtualization/parameters.yml` to set parameters related to your project
* edit `virtualization/playbook.yml` to configure what to install in your box

You now just have to launch your Vagrant box and start hacking :

```
vagrant up
```
