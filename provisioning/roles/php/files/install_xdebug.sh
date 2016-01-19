#!/bin/bash

set -e

wget https://pecl.php.net/get/xdebug-2.4.0RC3.tgz
tar -xzf xdebug-2.4.0RC3.tgz
cd xdebug-2.4.0RC3

phpize
./configure
make
sudo make install


sudo sh -c "echo zend_extension=xdebug.so > /etc/php/7.0/mods-available/xdebug.ini"

cd /etc/php/7.0/cli/conf.d

sudo ln -s ../../mods-available/xdebug.ini

if [[ -d  /etc/php/7.0/fpm/conf.d ]]
then
    cd /etc/php/7.0/fpm/conf.d
    sudo ln -s ../../mods-available/xdebug.ini
fi


