*************
Browser Roles
*************

Browser roles are available for frontend testing. They all depend on
the role xvfb, which is a headless X server.


Firefox
=======

Install Firefox with Geckodriver to be used with selenium.


Parameters
----------

* **firefox\_version** : The
  [version](https://ftp.mozilla.org/pub/firefox/releases/) of Firefox to
  be installed, defaults to 'latest'. Should be greater than 47.0.:w



Chrome
======

Install Chrome with Chromedriver to be used with selenium.

There are no parameters available for this one, as they don't really provide
older versions. Therefore, always the newest Chrome browser will be installed.


Example usage with pytest and splinter
======================================

This is the recommended way to use those browser for testing in python with
*pytest*. *pytest-splinter* is a pytest plugin that provides easy access to
several webdrivers.

First, you have to install some packages via pip
(see :ref:`virtualenv-reference-label` for instruction on how to properly do
this):

- pytest
- pytest-splinter
- pytest-xvfb


In order to run your tests, you can simply invoke pytest. By default the
Firefox webdriver will be used, but it's possible to change this with the
option --splinter-webdriver=chrome.
