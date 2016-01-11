#!/bin/bash

set -e

git clone https://github.com/phpredis/phpredis.git

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

sudo ln -fs ../../mods-available/redis.ini

