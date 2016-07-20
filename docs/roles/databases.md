# MySQL

Install and set up a MySQL server and then create the configured user and database.

The database administrative user is "root" with the "root" password.

This role must be included before the Django one if both are present in order for the
Django role to be able to configure the database correctly.

## Parameters

* **database_name** : the name of the database to create, set in parameters.yml
* **database_user**: the name of the user, defaults to the database name
* **database_password**: the password of the user, defaults to the database name

# PostgreSQL

Install and set up a PostgreSQL server and then create the configured user and database.

This role must be included before the Django one if both are present in order for the
Django role to be able to configure the database correctly.

## Parameters

* **database_name** : the name of the database to create, set in parameters.yml
* **database_user**: the name of the user, defaults to the database name
* **database_password**: the password of the user, defaults to the database name

# PostGIS
