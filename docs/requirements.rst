************
Requirements
************

-  Vagrant >= 1.8.4
-  Git >= 1.0

You also need a virtualization solution, either one of these:

-  Virtualbox >= 4.3
-  LXC >= 1.0 & vagrant-lxc >= 1.0.0.alpha.2

Optional dependencies:

-  `vagrant-hostmanager <https://github.com/devopsgroup-io/vagrant-hostmanager>`__
   A Vagrant plugin that manages /etc/hosts files. (will be
   automatically used if installed, make sure it's at least 1.5.0 if you
   have it)
-  `vagrant-cachier <https://github.com/fgrehm/vagrant-cachier>`__ A
   Vagrant plugin that share common package cache among similar VM
   instances.

Install Requirements
====================

Debian Stretch (testing) and Ubuntu Xenial 16.04
------------------------------------------------

Open a terminal and run::

    sudo apt-get install vagrant vagrant-lxc vagrant-cachier
    vagrant plugin install vagrant-hostmanager

Older Debian and Ubuntu versions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Go to https://www.vagrantup.com/downloads.html to download and install
the latest Vagrant version. Then open a terminal and run::

    sudo apt-get install lxc redir    # this is needed for LXC provider
    vagrant plugin install vagrant-lxc vagrant-cachier vagrant-hostmanager

Mac OS X
--------

Download and install
`https://www.vagrantup.com/downloads.html <the%20latest%20Vagrant%20version>`__.

Download and install
`https://www.virtualbox.org/wiki/Downloads <the%20latest%20VirtualBox%20version>`__.

Then open a terminal and run::

    vagrant plugin install vagrant-cachier vagrant-hostmanager

You can also use ``cask`` to help with the installation:::

    brew cask install vagrant virtualbox

Windows
-------

Install Virtualbox and Vagrant (>= 1.8.4) using the binaries available
on their respective websites.

Also make sure that ``core.autocrlf`` is set to ``input`` (recommended)
or at least ``true`` so that you don't get issues with Windows
line-endings in the files that are in your box. You can set it by
running the following command:

``git config --global core.autocrlf input``

For example if you get the following error when trying to provision the
box::

    TASK [base : ensure base packages are installed] *******************************

    failed: [default] (item=[u'locales', u'procps', u'command-not-found', u'bash-completion', u'zsh', u'bzip2', u'unzip', u'vim', u'ack-grep', u'highlight', u'libxml2-utils', u'build-essential', u'wget', u'openssh-server', u'sudo', u'imagemagick', u'iputils-ping', u'ncurses-term', u'python-pycurl']) => {"failed": true, "item": ["locales", "procps", "command-not-found", "bash-completion", "zsh", "bzip2", "unzip", "vim", "ack-grep", "highlight", "libxml2-utils", "build-essential", "wget", "openssh-server", "sudo", "imagemagick", "iputils-ping", "ncurses-term", "python-pycurl"], "module_stderr": ">>> /etc/sudoers.d/sudo-passwordless: syntax error near line 1 <<<\nsudo: parse error in /etc/sudoers.d/sudo-passwordless near line 1\nsudo: no valid sudoers sources found, quitting\nsudo: unable to initialize policy plugin\n", "module_stdout": "", "msg": "MODULE FAILURE", "parsed": false}

That's because the sudoers file that gets copied in the box has the
wrong format. Enabling ``core.autocrlf`` will fix the issue.

