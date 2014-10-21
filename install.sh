#!/bin/sh -x

# this script is used to install the virtualization capabilities in a new project

BASE=$(pwd)
VIRTDIR="virtualization"
REPODIR="rawbot-virtualization"

mkdir $VIRTDIR

git submodule add git@github.com:team-rawbot/rawbot-virtualization.git $VIRTDIR/$REPODIR

cp $VIRTDIR/$REPODIR/provisioning/playbook.yml.dist $VIRTDIR/playbook.yml
cp $VIRTDIR/$REPODIR/VagrantfileExtra.dist $VIRTDIR/VagrantfileExtra

ln -s $VIRTDIR/$REPODIR/Vagrantfile Vagrantfile

cat << EOF > $VIRTDIR/parameters.yml
project_name: "test"
hostname: "{{ project_name }}.lo"
hostnames: []
EOF
