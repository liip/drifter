*************************
Running and writing tests
*************************

The ``box`` pytest fixture allows you to get a full fledged Vagrant box (powered by LXC). Start by provisioning it, and then run commands in the box using the ``execute`` method::

  def test_mysql_role_installs_mysql(box):
      box.provision(roles=['mysql'], parameters={'mysql_version': '5.7'})
      assert '5.7' in box.execute('mysql --version')

By default boxes use a specific Debian image (refer to ``tests/conftest.py`` for the exact distribution). You can specify the OS to use by passing the ``os`` argument to the ``provision`` method::

  def test_mysql_role_installs_mysql_on_ubuntu(box):
      box.provision(roles=['mysql'], parameters={'mysql_version': '5.7'}, os='drifter/trusty64-base')
      assert '5.7' in box.execute('mysql --version')


To run the tests, start by installing the requirements::

  pip3 install pytest pyyaml

And then execute the ``pytest`` command to run the tests. Test boxes are automatically discarded when the test run is over so you don't have to clean anything.

Running a specific test / debugging
===================================

When a test fails, you can either re-run only the failing tests by passing the ``--lf`` option to pytest, or by using the ``-k`` option, followed by a part of the name of the test (for example ``pytest -k mysql_role_installs``).

If you want to break at a failing test (for example to spawn a shell into the box and check what's going on), add the ``--pdb`` option to pytest and, once you're into pdb, retrieve the box id::

  (Pdb) p box.box.get_lxc_id()
  drifter-base-boxes_default_1519465979666_71466

Then run ``lxc-attach -n drifter-base-boxes_default_1519465979666_71466`` to get a shell to the box. Once you're done, use the ``q`` command to exit the debugger and destroy the box.

Passwordless tests running
==========================

To run the tests without any password (useful for CI integration), add the following to your sudoers (replace `johndoe` by your user name)::

  johndoe ALL=(ALL) NOPASSWD: /usr/binlxc-info -iH -n *, /usr/bin/lxc-start -n *, /usr/bin/lxc-stop -k -n *, /usr/bin/lxc-attach -n * -- *, /usr/bin/lxc-copy -s -B overlayfs -n * -N *, /usr/bin/lxc-stop -k -n *, /usr/bin/lxc-destroy -n *
