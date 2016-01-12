# Using different box vms

If you not only want to test against different language version (as in [different-language-versions](../different-language-versions)), but also using different Virtualbox images, then it's a little bit more complicated.

You may need to do this, if you want to test against PHP 5.5 (not available on Jessie) and PHP 5.6/7.0, which this example is about.



To enable this, add the following to your `Vagrantfile` in the class `CustomConfig` after the other `attr_accessor`:

```
  attr_accessor :lxc_box_url
  attr_accessor :lxc_box_name
  attr_accessor :vbox_box_url
  attr_accessor :vbox_box_name
  attr_accessor :box_ip_55        # IP of the box for PHP 5.5
  attr_accessor :box_ip_70        # IP of the box for PHP 7.0

```

And then in the `initialize` method 


```

@lxc_box_url = config['lxc_box_url'] || "http://vagrantbox-public.liip.ch/liip-jessie64-lxc.box"
@lxc_box_name = config['lxc_box_name'] || 'jessie64-lxc'

@vbox_box_name = config['vbox_box_name'] || 'jessie64'
@vbox_box_url = config['vbox_box_url'] || 'http://vagrantbox-public.liip.ch/liip-jessie64.box'
@box_ip_70 = config['box_ip_70'] || "10.10.10.12"
@box_ip_55 = config['box_ip_55'] || "10.10.10.11"
@box_ip = config['box_ip'] || "10.10.10.10"

if ARGV[1] == "php-7.0"
    @extra_vars = {php_version: 7.0}
elsif ARGV[1] == "php-5.5"
    @extra_vars = {php_version: 5.5}
    @vbox_box_name = 'wheezy64'
    @vbox_box_url = 'http://vagrantbox-public.liip.ch/liip-wheezy64.box'
    @lxc_box_name = "wheezy64-lxc"
    @lxc_box_url = "http://vagrantbox-public.liip.ch/liip-wheezy64-lxc.box"
else
    @extra_vars = {php_version: 5.6}
end
```

and at the lower end of `Vagrantfile` again

```
Vagrant.configure('2') do |config|

  config.vm.define 'php-5.5', autostart: false do |vmconfig|
      vmconfig.vm.hostname = "#{custom_config.get('project_name')}-55.lo"
      vmconfig.vm.network :private_network, ip: custom_config.get('box_ip_55')
  end  

  config.vm.define 'php-7.0', autostart: false do |vmconfig|
    vmconfig.vm.hostname = "#{custom_config.get('project_name')}-70.lo"
    vmconfig.vm.network :private_network, ip: custom_config.get('box_ip_70')
  end

  config.vm.define 'php-5.6', primary: true do |vmconfig|
  end

end
```

The `@extra_vars` in the `initialize` method will be sent to your ansible playbook. And our `php` role already knows what to do, when those are set.

You can also add the following to `parameters.yml` to keep it consistent:

```
box_ip_55: "10.10.11.13"
box_ip_70: "10.10.11.14"
```

Now you can start all three boxes with

```
vagrant up php-5.5
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

php55:
  tags:
    - shell
  script: "./scripts/gitlabci.sh php-5.5"
  stage: test

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

    
