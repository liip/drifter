# MySQL

Install and set up a MySQL server and then create the configured user and database.

The database administrative user is "root" with the "root" password.

This role must be included before the Django or PHP one if both are present so that
the correct extension and configuration could be made.

## Parameters

* **database_name** : the name of the database to create, set in parameters.yml
* **database_user**: the name of the user, defaults to the database name
* **database_password**: the password of the user, defaults to the database name

# PostgreSQL

Install and set up a PostgreSQL server and then create the configured user and database.

This role must be included before the Django or PHP one if both are present so that
the correct extension and configuration could be made.

## Parameters

* **database_name** : the name of the database to create, set in parameters.yml
* **database_user**: the name of the user, defaults to the database name
* **database_password**: the password of the user, defaults to the database name
* **database_template**: the template to use, defaults to "template0"
* **database_encoding**: character encoding, defaults to UTF-8
* **database_lc_collate**: database collation, defaults to en_US.UTF-8
* **database_lc_ctype**: database ctype, defaults to en_US.UTF-8

# PostGIS

To be completed.

# MemCached

To be completed.
