#!/bin/sh -x

# this script is used to install the virtualization capabilities in a new project

BASE=$(pwd)
VIRTDIR="virtualization"
REPODIR="drifter"

mkdir $VIRTDIR

git submodule add https://github.com/liip/drifter.git $VIRTDIR/$REPODIR

cd $VIRTDIR/$REPODIR
LATEST_COMMIT=$(git rev-list --tags --max-count=1)
LATEST=$(git describe --tags $LATEST_COMMIT)
git checkout $LATEST

cp $VIRTDIR/$REPODIR/provisioning/playbook.yml.dist $VIRTDIR/playbook.yml
cp $VIRTDIR/$REPODIR/parameters.yml.dist $VIRTDIR/parameters.yml
cp $VIRTDIR/$REPODIR/ansible.cfg.dist ansible.cfg
cp $VIRTDIR/$REPODIR/Vagrantfile.dist Vagrantfile
