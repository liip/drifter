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

You can chose any ``solr`` version available via download. However the
provided start command might need some adjustment.

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
