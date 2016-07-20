# Java

Install a Java Runtime Environment using the OpenJDK Debian package.

# JDK

TODO

# Maven

# Solr

Create a "solr" user, then download and extract the given Solr package in the box.

Solr is then launched automatically using the Supervisor role.

## Parameters

* **solr_base_dir** : Solr base directory, this is not directly used by the role, defaults to "/opt/solr"
* **solr.url** : The Solr package to use, defaults to "http://archive.apache.org/dist/lucene/solr/3.5.0/apache-solr-3.5.0.tgz"
* **solr.install_dir** : Solr installation directory, defaults to the solr_base_dir
* **solr.config_dir** : Solr configuration directory, defaults to "solr_base_dir/example/"

# ElasticSearch

TODO

