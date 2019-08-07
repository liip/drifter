**************
Database Roles
**************

MySQL
=====

Install and set up a MySQL server and then create the configured user
and database.

The database administrative user is "root" with the "root" password.

This role must be included before the Django or PHP one if both are
present so that the correct extension and configuration could be made.

Parameters
----------

-  **database\_name** : the name of the database to create, set in
   parameters.yml
-  **database\_user**: the name of the user, defaults to the database
   name
-  **database\_password**: the password of the user, defaults to the
   database name
-  **mysql\_version**: the MySQL version to install, defaults to 5.6 and
   supports 5.6, 5.7 and 8.0 (more info on
   http://dev.mysql.com/downloads/repo/apt/)
-  **mysql\_character\_set**: the database character set, defaults to "latin1"
-  **mysql\_collation**: the database collation, defaults to "latin1_swedish_ci"

PostgreSQL
==========

Install and set up a PostgreSQL server and then create the configured
user and database.

This role must be included before the Django or PHP one if both are
present so that the correct extension and configuration could be made.

Parameters
----------

-  **database\_name** : the name of the database to create, set in
   parameters.yml
-  **database\_user**: the name of the user, defaults to the database
   name
-  **database\_password**: the password of the user, defaults to the
   database name
-  **database\_template**: the template to use, defaults to "template0"
-  **database\_encoding**: character encoding, defaults to UTF-8
-  **database\_lc\_collate**: database collation, defaults to
   en\_US.UTF-8
-  **database\_lc\_ctype**: database ctype, defaults to en\_US.UTF-8

PostGIS
=======
Install and set up a PostgreSQL server with the PostGIS extension enabled.

The `postgres` role is declared as a dependency and does not need to be activated explicitly in `playbook.yml`.

For each of the supported OS, this role installs the recommended PostgreSQL/PostGIS combination package:
-  **Debian 8 (Jessie)**: postgresql-9.4-postgis-2.1
-  **Debian 9 (Stretch)**: postgresql-9.6-postgis-2.3
-  **Ubuntu 14 (trusty)**: postgresql-9.3-postgis-2.1
-  **Ubuntu 16 (xenial)**: postgresql-9.5-postgis-2.2

MemCached
=========

To be completed.
