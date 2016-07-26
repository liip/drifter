#!/bin/bash

# this script is used to install the virtualization capabilities in a new project
# Modify with care as the README tells users to run the latest version of the script
# but we checkout the latest tag, so you might run in issues when you try to copy
# or use files that are not yet tagged.

BASE=$(pwd)
VIRTDIR="virtualization"
REPODIR="drifter"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

rollback()
{
    echo -e "${RED}An error occured. Aborting.${NC}"
    rm -Rf $VIRTDIR/$REPODIR
    # this might lead to some confusing error output, but if we didn't reach
    # the file copying stage it will leave the directory in a cleaner state.
    if [ -d $VIRTDIR ]; then
        rmdir --ignore-fail-on-non-empty $VIRTDIR
    fi
}

trap 'rollback' 0

# exit on first error
set -e

mkdir $VIRTDIR

echo -n -e "Cloning Drifter into $VIRTDIR/$REPODIR : ${RED}"
git submodule add -q https://github.com/liip/drifter.git $VIRTDIR/$REPODIR > /dev/null
echo -e "${GREEN}OK${NC}."

cd $VIRTDIR/$REPODIR
LATEST_COMMIT=$(git rev-list --tags --max-count=1)
LATEST=$(git describe --tags $LATEST_COMMIT)
echo -n -e "Using version $LATEST : ${RED}"
git checkout -q $LATEST > /dev/null
echo -e "${GREEN}OK${NC}."

cd $BASE

echo -n -e "Copying default configuration inside the project : ${RED}"
cp $VIRTDIR/$REPODIR/provisioning/playbook.yml.dist $VIRTDIR/playbook.yml
cp $VIRTDIR/$REPODIR/parameters.yml.dist $VIRTDIR/parameters.yml
cp $VIRTDIR/$REPODIR/ansible.cfg.dist ansible.cfg
cp $VIRTDIR/$REPODIR/Vagrantfile.dist Vagrantfile
echo -e "${GREEN}OK${NC}."

echo
echo -e "You can now configure Drifter by modifying the following files : "
echo -e "\t * ${VIRTDIR}/playbook.yml   : to configure what needs to be installed inside the box"
echo -e "\t * ${VIRTDIR}/parameters.yml : for project parameters"

# remove error handler
trap : 0
