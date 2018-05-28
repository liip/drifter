<p align="center">
  <img width="400" height="400" src="https://raw.githubusercontent.com/liip/drifter/master/docs/images/logo.png" alt="drifter logo"/>
</p>

Drifter
=======

Drifter is a framework to help provision developer boxes using Ansible and Vagrant.


Installation
------------

Make sure your system meets the [requirements](https://liip-drifter.readthedocs.io/en/stable/requirements.html) and
run the following command from inside your project directory:

```
curl -sS https://raw.githubusercontent.com/liip/drifter/master/install.sh | /bin/bash
```

This will install Drifter in the `virtualization/drifter` directory. You can then customize the roles you want to use
and the project configuration by editing the `virtualization/playbook.yml` and `virtualization/parameters.yml` files.
Then run `vagrant up` to get your box up and running.

Documentation
-------------

Detailed installation instructions and roles documentation are available in
[the documentation](https://liip-drifter.readthedocs.io/en/latest/#usage).
