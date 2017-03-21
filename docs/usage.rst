*****
Usage
*****

Drifter is going to be installed into your project as a git submodule.
So if your project is not using Git as VCS, start by creating a git
repo::

    cd my-project && git init

Then to install Drifter, simply run the following command::

    curl -sS https://raw.githubusercontent.com/liip/drifter/master/install.sh | /bin/bash

This will create a ``Vagrantfile`` in your root and a ``virtualization``
folder containing configuration files. You now have to follow those two
steps:

-  edit ``virtualization/parameters.yml`` to set parameters related to
   your project
-  edit ``virtualization/playbook.yml`` to configure what to install in
   your box

You now just have to launch your Vagrant box and start hacking!::

    vagrant up

