**********
Java Roles
**********

Java
====

Installs a Java Runtime Environment using the OpenJDK Debian package.
Currently installs the version 7.

JDK
===

Installs a Java Development Kit using the OpenJDK Debian package.
Currently installs the version 7.

Maven
=====

Installs Maven via ``apt-get``.

Solr
====

Install ``solr`` via the tarballs available on the Apache repository.

A specific user is created and ``solr`` is automatically started at boot
using ``supervisor``.

You can chose any ``solr`` version (compatible with Java7) via download.
However the provided start command might need some adjustment.

To create a Solr core use both the ``solr_core_name`` and ``solr_core_conf``
parameter.

Parameters
----------

Those parameters controls base feature for ``solr``. There's also a list
below of "internal" parameters that you'll might need to tweak if you
want to use a version different than 4.X or 5.X

-  **solr\_version**: Solr version to install, defaults to 5.3.1. You
   should be able to use all 5.X and 4.X version, but some tuning might
   be needed.
-  **solr\_base\_dir**: Solr base directory, this is not directly used
   by the role, defaults to "/opt/solr"
-  **solr.install\_dir**: Solr installation directory, defaults to the
-  **solr.config\_dir**: Solr configuration directory, defaults to
   "//solr/"
-  **solr\_port**: defaults to 8984

-  **solr\_core\_name**: Create a new Solr core/index with such name; by
   default no indexes are created. Both this parameter and the ``solr_core_conf``
   must be defined.
-  **solr\_core\_conf**: Specifies the Solr core/index configuration folder
   to use for the index, it will be symlink to the `conf` folder of the index,
   refer to http://lucene.apache.org/solr/ documentation for the file-structure
   required by Solr.
   Example: `solr_core_conf=vagrant/solr/conf`.

Internal Parameters
-------------------

-  **solr\_base\_url\_filename**: "{{ 'apache-' if (solr\_version \|
   version\_compare('4.1.0', '<')) else '' }}"
-  **solr\_base\_config\_dir**: "{{ 'example' if (solr\_version \|
   version\_compare('5.0.0', '<')) else 'server' }}"
-  **solr\_url**: "http://archive.apache.org/dist/lucene/solr/{{
   solr\_version }}/{{ solr\_base\_url\_filename }}solr-{{ solr\_version
   }}.tgz"
-  **solr\_command**: command used by ``supervisor`` to launch ``solr``

ElasticSearch
=============

To be completed
