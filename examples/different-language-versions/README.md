# Using different language versions

Sometimes you want to test (locally or on the CI) with different language versions. For example PHP 5.6 and PHP 7.0 (or Python 2.x and Python 3.x). 

To enable this, add the following to your `Vagrantfile` in the class `CustomConfig` after the other `attr_accessor`:

```
  attr_accessor :box_ip_70        # IP of the box for PHP 7.0

```

And then in the `initialize` method 
```

    @box_ip_70 = config['box_ip_70'] || "10.10.10.12"

    if ARGV[1] == "php-7.0"
        @extra_vars = {php_version: 7.0}
    else
        @extra_vars = {php_version: 5.6}
    end
```

and at the lower end of `Vagrantfile`

```


Vagrant.configure('2') do |config|
  config.vm.define 'php-5.6', primary: true do |vmconfig|
  end

  config.vm.define 'php-7.0', autostart: false do |vmconfig|
    vmconfig.vm.hostname = "#{custom_config.get('project_name')}-70.lo"
    vmconfig.vm.network :private_network, ip: custom_config.get('box_ip_70')
  end
end
```

The `@extra_vars` in the `initialize` method will be sent to your ansible playbook. And our `php` role already knows what to do, when those are set.

You can also add the following to `parameters.yml` to keep it consistent:

```
box_ip_70: "10.10.11.14"
```

Now you can start both boxes with

```
vagrant up php-5.6
vagrant up php-7.0
```

To test those on the CI, write your `.gitlab-ci.yml` the following way:

```
before_script:
  - mkdir -p ../${PWD##*/}.vagrant
  - ln -s ../${PWD##*/}.vagrant .vagrant

variables:
  VAGRANT_DEFAULT_PROVIDER: lxc

php56:
  tags:
    - shell
  script: "./scripts/gitlabci.sh php-5.6"
  stage: test

php70:
  tags:
    - shell
  script: "./scripts/gitlabci.sh php-7.0"
```

Also make sure, the env variable `VIRTUALBOX_NAME` is set to $1 in `scripts/gitlabci.sh`


The full files can be also found in this directoy: 

* [Vagrantfile](Vagrantfile)
* [.gitlab-ci.yml](gitlab-ci.yml)
* [gitlabci.sh](gitlabci.sh)

    
