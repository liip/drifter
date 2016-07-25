# Java

Installs a Java Runtime Environment using the OpenJDK Debian package. Currently installs the version 7.

# JDK

Installs a Java Development Kit using the OpenJDK Debian package. Currently installs the version 7.

# Maven

Installs Maven via `apt-get`.

# Solr

Install `solr` via the tarballs available on the Apache repository.

A specific user is created and `solr` is automatically started at boot using `supervisor`.

You can chose any `solr` version available via download. However the provided start command might need
some adjustment.

## Parameters

Those parameters controls base feature for `solr`. There's also a list below of "internal" parameters that you'll might
need to tweak if you want to use a version different than 4.X or 5.X

* **solr_version**: Solr version to install, defaults to 5.3.1. You should be able to use all 5.X and 4.X version, but some tuning might be needed.
* **solr_base_dir**: Solr base directory, this is not directly used by the role, defaults to "/opt/solr"
* **solr.install_dir**: Solr installation directory, defaults to the <solr_base_dir>
* **solr.config_dir**: Solr configuration directory, defaults to "<solr_base_dir>/<solr_base_config_dir>/solr/"
* **solr_port**: defaults to 8984

## Internal Parameters

* **solr_base_url_filename**: "{{ 'apache-' if (solr_version | version_compare('4.1.0', '<')) else '' }}"
* **solr_base_config_dir**: "{{ 'example' if  (solr_version | version_compare('5.0.0', '<')) else 'server' }}"
* **solr_url**: "http://archive.apache.org/dist/lucene/solr/{{ solr_version }}/{{ solr_base_url_filename }}solr-{{ solr_version }}.tgz"
* **solr_command**: command used by `supervisor` to launch `solr`

# ElasticSearch

To be completed
