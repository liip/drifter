# Change Log

All notable changes to this project will be documented in this file.

This project try to follows [Semantic Versioning](http://semver.org/) since the version 1.0.0.

For migration information, you can always have a look at https://liip-drifter.readthedocs.io/en/latest/migrations/.

## [Unreleased]

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

## [FirstBlood] - 2014-09-26

Hackish try to do something using Docker to achieve the same purpose as today.
The idea was fairly quickly abandoned because it was too complicated to manage
the fact that we have people on multiple platforms.

Some of the roles still survives today, so not everything was lost ;)

## Added
- Roles : Apache, PHP

[Unreleased]: https://github.com/liip/drifter/compare/v1.0.2...HEAD
[1.0.2]: https://github.com/liip/drifter/compare/v1.0.1...v1.0.2
[1.0.1]: https://github.com/liip/drifter/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/liip/drifter/compare/v0.5.1...v1.0.0
[0.5.1]: https://github.com/liip/drifter/compare/v0.5.0...v0.5.1
[0.5.0]: https://github.com/liip/drifter/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/liip/drifter/compare/v0.3.0...v0.4.0
[0.3.0]: https://github.com/liip/drifter/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/liip/drifter/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/liip/drifter/compare/ce825ff5a860fe8ccffb6ac3277a9278f7685a74...v0.1.0
[FirstBlood] : https://github.com/liip/drifter/commit/ce825ff5a860fe8ccffb6ac3277a9278f7685a74
