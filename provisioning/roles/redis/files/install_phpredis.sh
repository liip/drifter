#!/bin/bash

set -e

git clone git@github.com:phpredis/phpredis.git

cd phpredis

git checkout php7

phpize

./configure

make

sudo make install

cd ..

rm -rf phpredis

sudo sh -c "echo extension=redis.so > /etc/php/7.0/mods-available/redis.ini"

cd /etc/php/7.0/cli/conf.d

sudo ln -s ../../mods-available/redis.ini

cd /etc/php/7.0/fpm/conf.d

sudo ln -s ../../mods-available/redis.ini


