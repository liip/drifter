# -*- mode: ruby -*-
# vi: set ft=ruby :

# This file should allow you to edit Vagrant related options Feel free
# to modify it to avoid having your own project dependent Vagrantfile.
# If the provided possibilities are not enough for you, please get in
# touch so we can find a common solution !

require 'yaml'

class CustomConfig
  # Those accessors will be used by the Vagrantfile
  attr_accessor :project_name
  attr_accessor :hostname
  attr_accessor :hostnames
  attr_accessor :box_ip

  # Retrieve the values of 'virtualization/parameters.yml' so that
  # they can be used by Vagrant. If you need to change those values
  # prefer editing the parameters.yml file instead.
  def initialize
    config = YAML::load(File.open('virtualization/parameters.yml'))

    @project_name = config['project_name'] || "rawbot"
    @hostname = config['hostname'] || "#{@project_name}.lo"
    @hostnames = config['hostnames'] || Array.new
    @box_ip = config['box_ip'] || "10.10.10.10"
  end

  # Modify this if you need to determine a list from hostnames
  # from a file for example.
  def load_aliases
    @hostnames
  end
end
