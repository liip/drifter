#!/bin/sh -x

# this script is used to install the virtualization capabilities in a new project
# Modify with care as the README tells users to run the latest version of the script
# but we checkout the latest tag, so you might run in issues when you try to copy
# or use files that are not yet tagged.

BASE=$(pwd)
VIRTDIR="virtualization"
REPODIR="drifter"

mkdir $VIRTDIR

git submodule add https://github.com/liip/drifter.git $VIRTDIR/$REPODIR

cd $VIRTDIR/$REPODIR
LATEST_COMMIT=$(git rev-list --tags --max-count=1)
LATEST=$(git describe --tags $LATEST_COMMIT)
git checkout $LATEST

cd $BASE

cp $VIRTDIR/$REPODIR/provisioning/playbook.yml.dist $VIRTDIR/playbook.yml
cp $VIRTDIR/$REPODIR/parameters.yml.dist $VIRTDIR/parameters.yml
cp $VIRTDIR/$REPODIR/ansible.cfg.dist ansible.cfg
cp $VIRTDIR/$REPODIR/Vagrantfile.dist Vagrantfile
