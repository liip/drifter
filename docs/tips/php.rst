***
PHP
***

PHP Debugging with Drifter & PHPStorm
=====================================

As said earlier, the PHP role installs php-xdebug which is configured to
try to connect to any listener on the host.

If you are using Chrome and PHPStorm, debugging a script can be done by following these steps:

#. Install the `Xdebug helper chrome extension
   <https://chrome.google.com/webstore/detail/xdebug-helper/eadndfjplgieldjbigjakmdgkmoaaaoc>`_
#. In your browser address bar, click on the little bug and select "Debug"
#. In PHPStorm, open the "Run" menu and select "Start Listen for PHP Debug
   connection"
#. Reload the page in your browser
#. A dialog should open in PHPStorm to ask you which file you want to debug,
   choose the entry point of your application
