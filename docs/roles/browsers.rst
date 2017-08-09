*************
Browser Roles
*************

Browser roles are available for frontend testing. They all depend on
the role xvfb, which is a headless X server, except for Phantomjs.

Firefox
=======

Install Firefox with Geckodriver to be used with selenium.

Parameters
----------

- **firefox_version**: The version of Firefox to be installed, defaults to *latest*. Should be greater than 47.0. The
  full list of supported versions can be found on the `Firefox releases page
  <https://ftp.mozilla.org/pub/firefox/releases/>`_.

Chrome
======

Install Chrome with Chromedriver to be used with selenium.

There are no parameters available for this one, as they don't really provide
older versions. Therefore, always the newest Chrome browser will be installed.

PhantomJS
=========

Install PhantomJS.

Parameters
----------

- **phantomjs_version**: The version of PhantomJS to be installed, defaults to *2.1.1*. The full list of supported
  versions can be found on the `PhantomJS releases page <http://phantomjs.org/releases.html>`_.

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
- pytest-xvfb (When you want to use firefox or chrome)

In order to run your tests, you can simply invoke pytest. By default the
Firefox webdriver will be used, but it's possible to change this with the
option --splinter-webdriver=chrome. More info available
`on the pytest-splinter project page <https://github.com/pytest-dev/pytest-splinter>`_.
