***
PHP
***

PHP Debugging with Drifter & PHPStorm
=====================================

As said earlier, the PHP role installs php-xdebug which is configured to
try to connect to any listener on the host.

If you are using Chrome and PHPStorm, debugging a script can be easily done:

1° Install the (Xdebug helper chrome extension)\ `2 <https://chrome.google.com/webstore/detail/xdebug-helper/eadndfjplgieldjbigjakmdgkmoaaaoc>`__
2° In your browser address bar, click on the little bug and select "Debug"
3° In PHPStorm, open the "Run" menu and select "Start Listen for PHP Debug connection"
4° Reload the page in your browser
5° A dialog should open in PHPStorm to ask you which file you want to debug, choose the entry point of your application
