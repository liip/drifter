# RMT - Release Management Tool

Install RMT in the box. Once done you can use it on the shell by running `RMT`
For more info on usage, go on https://github.com/liip/RMT#usage

# Solr

Create a "solr" user, then download and extract the given Solr package in the box.

Solr is then launched automatically using the Supervisor role.

## Parameters

* **solr_base_dir** : Solr base directory, this is not directly used by the role, defaults to "/opt/solr"
* **solr.url** : The Solr package to use, defaults to "http://archive.apache.org/dist/lucene/solr/3.5.0/apache-solr-3.5.0.tgz"
* **solr.install_dir** : Solr installation directory, defaults to the solr_base_dir
* **solr.config_dir** : Solr configuration directory, defaults to "solr_base_dir/example/"

