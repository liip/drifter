# Change Log

All notable changes to this project will be documented in this file.

This project try to follows [Semantic Versioning](http://semver.org/) since the version 1.0.0.

For migration information, you can always have a look at https://liip-drifter.readthedocs.io/en/latest/migrations.html.

## Unreleased

### Added
- Virtualbox: allow use of Virtualbox shared folders besides nfs

### Changed
- Gulp role: Webpack now uses "cheap-module-source-map" as devtool
- php-xdebug role: add `xdebug_idekey` configuration option
- Nginx role: allow to extend templates from outside the templates directory

### Fixed
- Mysql role: use become to create database and user. Fixes problem on xenial
- PHP role: don't download surby.org gpg key, when not needed. Fixes problem on wheezy
- MySQL role: don't install mysql upstream repository if a newer version is already installed.
- Nginx role: fix Drupal templates and rewrite rule

## [1.3.0] - 2017-04-26

### Added
- Virtualenv role: add `pip_requirements_dir` option to automatically compile `.in` requirements
- PHP role: add support for PHP 7.1
- Gulp role: add `gulp_create_config` to make gulp.config.js file creation optional

### Fixed
- Webpack role: use absolute path for the output.path config value
- Nginx role: add X-Forwarded-Proto header in Rails site template

### Changed
- PHP role: change the packages repo from the discontinued dotdeb.org to deb.sury.org
- PHP role: xdebug and imagick for PHP 7.x are taken from the repo and not compiled anymore

## [1.2.0] - 2017-03-28

### Added
- Node role: add support for version 7.x
- Node role: install yarn when `nodejs_with_yarn` is set to `true`
- Gulp role: Specify SSL certificates in BrowserSync config when role SSL is installed
- Gulp role: Print WebPack/Sass compilation to the browser
- Ruby role: add instructions on how to setup Drifter for Rails projects
- Virtualbox: Set timesync-set-threshold to 10 seconds instead of the default 20 minutes
- Nginx role: add Rails template

### Changed
- PHP role: set `always_populate_raw_post_data` to -1 to avoid deprecation warnings
- Compass role: Deprecate because Compass is not maintained anymore
- Gulp role: Update WebPack to 2.2 and other various dependencies
- Gulp role: Autoprefixer now uses Browserslist
- Gulp role: WebPack’s babel-loader now uses preset `env` by default
- Gulp role: WebPack config is now standard (export an object and not a function)
- Documentation: Converted the documentation language from Markdown to RestructuredText

### Fixed
- MySQL role: fix installation of MySQL packages by upgrading mysql-apt-config
- php-memcached role: Fix the memcached extension installation for debian
- MySQL role: improve upgrades of MySQL by executing mysql_upgrade

## [1.1.1] - 2017-02-02

### Fixed
- Ruby role: fix installation of Ruby by installing missing dependency

## [1.1.0] - 2017-02-01

### Added
- Nginx role: added Drupal templates (D6, D7 and D8)
- OpenLDAP (slapd) role

### Changed
- Base role: Set the cache valid-time for `apt-update cache` command to 1h
- Django role: generate ALLOWED_HOSTS file to comply with Django >= 1.9.11
- Ruby role: install with rbenv, Ruby version can be set with the `ruby_version` parameter. See documentation

### Fixed
- Composer role: don't reinstall on every provision
- Nginx role: use web_directory parameter for HTTPS root instead of root_directory
- The playground is working again

## [1.0.9] - 2016-12-02

### Changed
- Improve MySQL role to support different versions (parameter `mysql_version`)

### Fixed

- Try to use git_config instead of shell commands to prevent warnings
- Fix deprecated use of hosts variable in base role
- The `index` block in nginx templates now works correctly
- Fix solr config folder permissions and Supervisord restart on Wheezy
- Fix DotDeb key installation, see #130
- Remove maximum allowed request body size in Nginx configuration (fixes #136)
- Fix usage of HTTPS URLs (eg. in nodejs role) in boxes that use Python < 2.7.9 (eg. Ubuntu Trusty, Debian Wheezy)
  (fixes #140)

## [1.0.8] - 2016-10-04

### Fixed

- Use the correct package for Python 3 virtualenv on Ubuntu Trusty

## [1.0.7] - 2016-09-23

### Added
- Change the directory before loading Drifter's Vagrantfile so that Vagrant can be run from anywhere inside the project root

### Changed
- Interactive install script
- The IP is not defined by default anymore as vagrant does this automatically
- Upgrade Ansible to version 2.1.1 inside the box

### Fixed
- Set the permission of the solr data directory so that the core can correctly start
- Fix the default nginx vhost when setting up an index file
- Flush handlers at the end of relevent roles to ensure services are available
- Fix an error where the destination directory contains spaces
- Ensure git is installed before synching git config
- Ensure libpam-systemd installed and sshd configured to use it; this obviates the need to remove systemd

## [1.0.6] - 2016-08-12

### Added
- add the possibility to use PureScript to `gulp` role

### Fixed
- fix error due to change on the diff-so-fancy repo, now use a set version to avoid further issue
- fix error display when getting git config on the host
- escape double quotes in git exported config to avoid error when reimporting
- force creation of symlink for supervisor on wheezy to avoid errors

## [1.0.5] - 2016-07-27

### Fixed
- git config sync now works as expected (not syncing project config, and avoid config duplication on each provisioning). See #97

## [1.0.4] - 2016-07-27

### Changed
- specify install method and version for ansible when using `ansible_local` and it is not found in the box

### Fixed
- avoid install `fancy-diff` on each provisioning

## [1.0.3] - 2016-07-27

### Added
- `webpack` support to `gulp` role, only works on new boxes as the Gulpfile is not recreated

### Fixed
- remove the dependency for `git` on the `base` role since it's included via the playbook

## [1.0.2] - 2016-07-26

### Fixed
- force `.gitconfig` symlink creation if the file already exists

## [1.0.1] - 2016-07-26

### Fixed
- remove config `push.default = simple` for git since it caused issues on `Wheezy` and it's the default for Git > 2 anyway

## [1.0.0] - 2016-07-26

First stable release. As of now, Drifter will follow [Semantic Versioning](http://semver.org/).

This version contains a lot of BC breaks, please read https://liip-drifter.readthedocs.io/en/latest/migrations/#version-100.

Also, the requirements are bumped to Ansible 1.9 if you're not using `ansible_local`, and Vagrant 1.8.4.

### Added
- new `git` role, with config sync possibilities and diff-so-fancy.
- new `virtualenv` role

### Changed
- use `become` instead of `sudo` (requires Ansible 1.9)
- [BC] remove support for old Vagrant file deprecated in v0.2.0
- assume `ansible` is installed in the box and remove installation procedure
- improved documentation
- renamed `redis-php` and `memcached-php` roles to follow convention
- `flask` and `django` roles now use the new `virtualenv` role

## [0.5.1] - 2016-07-21

### Changed
- the install script now installs the latest tag instead of HEA
- error handling in install script

## [0.5.0] - 2016-07-21

### Added
- roles: gulp, logstash, rabbitmq, memcached & php-memcached

### Changed
- `ansible_local` now works with LXC
- new nginx template for silex
- use php alternative path to ease switching between versions
- possibility to install various NodeJS version
- use new JSON format for boxes, along with documentation for building them

### Fixed
- `ansible` installation in the box (multiple times ^^)
- PHP socket timeout fixes

## [0.4.0] - 2016-05-10

### Added
- use RTD for the documentation
- Gitlab CI roles
- use `vagrant-cachier` and linked clones for VB if installed

### Changed
- install php-redis along with PHP
- rename from "Rawbot Virtualization Framework" to "Drifter"
- improve "migration" from PHP5 to PHP7
- make provisioning less verbose
- enable port forwarding configuration

### Fixed
- issues with Ansible version 1.7.0
- detect LXC provisioner in more cases
- installation of `ansible_local`
- various bugfixing in roles

## [0.3.0] - 2016-01-12

### Changed
- Enable the use of `ansible_local` when possible

## [0.2.0] - 2016-01-12

First release trying to support Windows.

See https://liip-drifter.readthedocs.io/en/latest/migrations/#version-010-to-020.

## Changed
- remove use of symlinks for the various files
- Include Drifter's Vagrantfile into a "Config Vagrantfile" instead of copying the whole file into the project directory

## [0.1.0] - 2016-01-12

The first release was made long after the project start when people from outside
the Lausanne office started using it and we needed some kind of way to know which
version was used.

## Added
- Use of Vagrant
- Lots of roles : Java, Solr, Ruby, Compass, Django, Postgres, Nginx, NodeJS, SSL, ...

## Changed
- Multiple improvement on roles

## Fixed
- Probably lots of things

## [First Blood](https://github.com/liip/drifter/commit/ce825ff5a860fe8ccffb6ac3277a9278f7685a74) - 2014-09-26

Hackish try to do something using Docker to achieve the same purpose as today.
The idea was fairly quickly abandoned because it was too complicated to manage
the fact that we have people on multiple platforms.

Some of the roles still survives today, so not everything was lost ;)

## Added
- Roles : Apache, PHP

[Unreleased]: https://github.com/liip/drifter/compare/v1.3.0...HEAD
[1.3.0]: https://github.com/liip/drifter/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/liip/drifter/compare/v1.1.1...v1.2.0
[1.1.1]: https://github.com/liip/drifter/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/liip/drifter/compare/v1.0.9...v1.1.0
[1.0.9]: https://github.com/liip/drifter/compare/v1.0.8...v1.0.9
[1.0.8]: https://github.com/liip/drifter/compare/v1.0.7...v1.0.8
[1.0.7]: https://github.com/liip/drifter/compare/v1.0.6...v1.0.7
[1.0.6]: https://github.com/liip/drifter/compare/v1.0.5...v1.0.6
[1.0.5]: https://github.com/liip/drifter/compare/v1.0.4...v1.0.5
[1.0.4]: https://github.com/liip/drifter/compare/v1.0.3...v1.0.4
[1.0.3]: https://github.com/liip/drifter/compare/v1.0.2...v1.0.3
[1.0.2]: https://github.com/liip/drifter/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/liip/drifter/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/liip/drifter/compare/v0.5.1...v1.0.0
[0.5.1]: https://github.com/liip/drifter/compare/v0.5.0...v0.5.1
[0.5.0]: https://github.com/liip/drifter/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/liip/drifter/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/liip/drifter/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/liip/drifter/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/liip/drifter/compare/ce825ff5a860fe8ccffb6ac3277a9278f7685a74...v0.1.0
