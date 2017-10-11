**********
Java Roles
**********

Java
====

Installs a Java Runtime Environment using the OpenJDK Debian package.

Parameters
----------

-  **java_jre_version**: JRE version to install, defaults to 7. Set
   your version according to your needs and your Linux distribution.
-  **java_jre_package**: default is ``openjdk-{{ java_jre_version }}-jre``.

JDK
===

Installs a Java Development Kit using the OpenJDK Debian package.

Parameters
----------

-  **java_jdk_version**: JDK version to install, defaults to 7. Set
   your version according to your needs and your Linux distribution.
-  **java_jdk_package**: default is ``openjdk-{{ java_jdk_version }}-jdk``.

Maven
=====

Installs Maven via ``apt-get``.

Solr
====

Install ``solr`` via the tarballs available on the Apache repository.

A specific user is created and ``solr`` is automatically started at boot
using ``supervisor``.

You can choose any ``solr`` version (compatible with Java7) via download.
However the provided start command might need some adjustment.

To create a Solr core, use both the ``solr_core_name`` and ``solr_core_conf``
parameter.

Parameters
----------

Those parameters controls base feature for ``solr``. There's also a list
below of "internal" parameters that you'll might need to tweak if you
want to use a version different than 4.X or 5.X

-  **solr_version**: Solr version to install, defaults to 5.3.1. You
   should be able to use all 5.X and 4.X version, but some tuning might
   be needed.
-  **solr_base_dir**: Solr base directory, this is not directly used
   by the role, defaults to `/opt/solr`.
-  **solr_install_dir**: Solr installation directory, defaults to ``{{ solr_base_dir }}``.
-  **solr_config_dir**: Solr configuration directory, defaults to
   `/opt/solr/server/solr`.
-  **solr_port**: defaults to 8984.
-  **solr_core_name**: Create a new Solr core/index with such name; by
   default no indexes are created. If this parameter is defined, ``solr_core_conf``
   must be defined as well.
-  **solr_core_conf**: Specifies the Solr core/index configuration folder
   to use for the index, it will be symlinked to the `conf` folder of the index.
   Refer to `the documentation <http://lucene.apache.org/solr/>`_ for the file structure
   required by Solr. Example: ``solr_core_conf=/vagrant/solr/conf``.

ElasticSearch
=============

To be completed
