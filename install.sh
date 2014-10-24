#!/bin/sh -x

# this script is used to install the virtualization capabilities in a new project

BASE=$(pwd)
VIRTDIR="virtualization"
REPODIR="rawbot-virtualization"

mkdir $VIRTDIR

git submodule add git@github.com:team-rawbot/rawbot-virtualization.git $VIRTDIR/$REPODIR

cp $VIRTDIR/$REPODIR/provisioning/playbook.yml.dist $VIRTDIR/playbook.yml
cp $VIRTDIR/$REPODIR/VagrantfileExtra.rb.dist $VIRTDIR/VagrantfileExtra.rb
cp $VIRTDIR/$REPODIR/parameters.yml.dist $VIRTDIR/parameters.yml

ln -s $VIRTDIR/$REPODIR/Vagrantfile Vagrantfile

cd $VIRTDIR
ln -s $VIRTDIR/$REPODIR/provisioning/roles roles
cd ..

cat << EOF > $VIRTDIR/ansible.cfg
roles_path = ./$REPODIR
EOF
