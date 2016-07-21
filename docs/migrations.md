# Migrations instructions

## Version 1.0.0

### Ansible version and `ansible_local`

Changes were made to the roles that requires to use of at least the version 1.9.0 of `ansible`. This means Debian stable users
have to install `ansible` via the [Backports](https://backports.debian.org/Instructions/) if they don't want to use the
`ansible_local` provisioner.

Also, the default is now `ansible_local` also for LXC and the Vagrant version was bumped to 1.8.4 in this case to get rid of the
bug that caused issues before. This is the new recommanded provisioner.

### Old Vagrantfile format

The support for the old Vagrantfile format has been removed in this version. You should follow the steps detailed in the
migration from 0.1.0 to 0.2.0 if you haven't done it already.

### Virtualbox and LXC URLs

It's not possible to specify separate boxes for LXC and Virtualbox via Drifter anymore. You need to move to the new JSON
box format in order to be able to do it. You can have a look at https://vagrantbox-public.liip.ch/drifter-jessie64-base.json
for an example.

The `lxc_box_name`, `lxc_box_url`, `vbox_box_name` and `vbox_box_url` have been removed in favor of `box_name` and `box_url`.

## Version 0.1.0 to 0.2.0

In order for the framework to work correctly on Windows, we removed the symlinks to the Vagrantfile stored in the submodule.
The content of the VagrantfileExtra.rb is now in the Vagrantfile at your project root. This new file then loads a more
complete Vagrantfile that is in the submodule.

In order to migrate, follow those steps (commands assume you are in your project root directory) :

1. Remove the Vagrantfile symbolic link from the root : `rm -f Vagrantfile`
2. Copy the VagrantfileExtra.rb file to your root and rename it : `mv virtualization/VagrantfileExtra.rb Vagrantfile`
3. Add the `get` method to your `CustomConfig` class in the `Vagrantfile` (copy the snippet below inside the class)
4. Add the loading of the complete Vagrantfile to the project Vagrantfile : `echo "load 'virtualization/drifter/Vagrantfile'" >> Vagrantfile`

    def get(name, default = nil)
        if self.respond_to?(name)
            self.send(name)
        elsif default.nil?
            raise "[CONFIG ERROR] '#{name}' cannot be found and no default provided."
        else
            default
        end
    end
