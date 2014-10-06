# This is a sample  Dockerfile to build a new image used for a development environment.
# Once you have copied this file to your project directory and adapted it, you can build your image with :
# sudo docker build -t="liip:<project>" .

FROM debian:wheezy
MAINTAINER Gilles Crettenand <gilles.crettenand@liip.ch>

ENV DEBIAN_FRONTEND noninteractive

# set sources
RUN rm -f /etc/apt/sources.list && ( \
      echo "deb http://ftp.ch.debian.org/debian/ wheezy main contrib non-free" && \
      echo "deb http://ftp.ch.debian.org/debian/ wheezy-updates main contrib non-free" && \
      echo "deb http://security.debian.org/ wheezy/updates main contrib non-free" \
    ) > /etc/apt/sources.list.d/wheezy.list && \
    echo "deb http://ftp.ch.debian.org/debian/ wheezy-backports main contrib non-free" > /etc/apt/sources.list.d/backports.list

# update packages and install ansible
RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y ansible apt-utils

# copy provisioning files
ADD ./rawbot-docker/provisioning ./provisioning
ADD ./virt-playbook.yml ./provisioning/playbook.yml

# provision the image
RUN ( echo '[docker]' && echo 'localhost' ) > /etc/ansible/hosts && ansible-playbook ./provisioning/playbook.yml --connection=local

# clean up
RUN apt-get clean

# shared folders
VOLUME /exports
WORKDIR /exports
