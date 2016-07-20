#!/bin/bash

set -e

wget https://pecl.php.net/get/imagick-3.4.0RC4.tgz
tar -xzf imagick-3.4.0RC4.tgz
cd imagick-3.4.0RC4

sudo apt-get install pkg-config php7.0-dev libmagickwand-6.q16-dev
phpize
./configure
make
sudo make install

rm -rf imagick-*

sudo sh -c "echo extension=imagick.so > /etc/php/7.0/mods-available/imagick.ini"

cd /etc/php/7.0/cli/conf.d

sudo ln -s ../../mods-available/imagick.ini

if [[ -d  /etc/php/7.0/fpm/conf.d ]]
then
    cd /etc/php/7.0/fpm/conf.d
    sudo ln -s ../../mods-available/imagick.ini
fi


