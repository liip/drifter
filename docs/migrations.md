# Migrations instructions

## Version 1.0.0

### Old Vagrantfile format

The support for the old Vagrantfile format has been removed in this version. You should follow the steps detailed in the
migration from 0.1.0 to 0.2.0 if you haven't done it already.

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
