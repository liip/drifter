# -*- mode: ruby -*-
# vi: set ft=ruby :

# This Vagrantfile contains some configuration option that you can
# tweak for your project.
# It then loads the "main" Vagrantfile from the submodule.

require 'yaml'

class CustomConfig
  # Those accessors will be used by the Vagrantfile
  attr_accessor :project_name  # project name (currently unused by the Vagrant file)
  attr_accessor :hostname      # main hostname of the box
  attr_accessor :hostnames     # alternative hostnames (array)
  attr_accessor :box_ip        # IP of the box

  attr_accessor :ansible_local # use 'ansible_local' provisionner ?
  attr_accessor :playbook      # path to the playbook
  attr_accessor :extra_vars    # extra variables to pass to Ansible

  attr_accessor :lxc_box_url   # name of the virtualbox box
  attr_accessor :lxc_box_name  # url of the virtualbox box
  attr_accessor :vbox_box_url  # name of the lxc box
  attr_accessor :vbox_box_name # url of the lxc box
  
  # Retrieve the values of 'virtualization/parameters.yml' so that
  # they can be used by Vagrant. If you need to change those values
  # prefer editing the parameters.yml file instead.
  def initialize
    parameters_file = ENV.fetch('VIRTUALIZATION_PARAMETERS_FILE', 'virtualization/parameters.yml')
    config = YAML::load(File.open(parameters_file))

    @lxc_box_url = config['lxc_box_url'] || "http://vagrantbox-public.liip.ch/liip-jessie64-lxc.box"
    @lxc_box_name = config['lxc_box_name'] || 'jessie64-lxc'    
    @vbox_box_url = config['vbox_box_url'] || 'http://vagrantbox-public.liip.ch/liip-jessie64.box'
    @vbox_box_name = config['vbox_box_name'] || 'jessie64'
    
    @project_name = config['project_name'] || "example"
    @hostname = config['hostname'] || "#{@project_name}.lo"
    @hostnames = config['hostnames'] || Array.new
    @box_ip = config['box_ip'] || "10.10.10.10"

    @ansible_local = true
    @playbook = config['playbook'] || "virtualization/playbook.yml"
    @extra_vars = {}
  end

  # Modify this if you need to determine a list from hostnames
  # from a file for example.
  def load_aliases
    @hostnames
  end

  def get(name, default = nil)
    if self.respond_to?(name)
      self.send(name)
    elsif default.nil?
      raise "[CONFIG ERROR] '#{name}' cannot be found and no default provided."
    else
      default
    end
  end
end

load 'virtualization/drifter/Vagrantfile'

