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

To be completed.

MemCached
=========

To be completed.
