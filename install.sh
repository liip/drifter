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
    echo -e "${RED}An error occurred. Aborting.${NC}"
    if [ -d $VIRTDIR ]; then
        rm -rf $VIRTDIR
    fi
}

echo_abort()
{
    echo -e "${RED}Aborting.${NC}"
}

git_status=$(git status --porcelain 2>/dev/null)
git_status_exit_code=$?

# exit on first error
set -e

if [ $git_status_exit_code -eq 128 ]; then
    echo "The current directory $(pwd) doesn't seem to be a git repository."
    while true; do
        read -p "Do you want to run 'git init'? [Yn] " git_init
        case $git_init in
            Y|y|"" ) git init; break;;
            N|n ) echo_abort; exit 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
    echo
else
    if [ "$git_status" != "" ] && echo "$git_status" | grep -q -v '^??'; then
        echo -e "${RED}Your directory contains staged modifications. Please unstage them or stash them.${NC}"
        exit 1
    fi
fi

if [ -e $VIRTDIR ]; then
    echo "A directory named 'virtualization' already exists."
    while true; do
        read -p "Do you want to wipe it out and reinstall Drifter? [yN] " wipe
        case $wipe in
            Y|y ) rm -rf $VIRTDIR; break;;
            N|n|"" ) echo_abort; exit 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
    echo
fi

if ! grep -q .vagrant .gitignore 1> /dev/null 2>&1; then
    echo /.vagrant/ >> .gitignore
    git add .gitignore
fi

trap 'rollback' 0

mkdir "$VIRTDIR"

echo -n -e "Cloning Drifter into $VIRTDIR/$REPODIR : ${RED}"
git submodule add -q https://github.com/liip/drifter.git "$VIRTDIR/$REPODIR" > /dev/null
echo -e "${GREEN}OK${NC}."

cd "$VIRTDIR/$REPODIR"
LATEST=$(git tag | tail -n1)
LATEST_COMMIT=$(git show-ref -s $LATEST)
echo -n -e "Using version $LATEST : ${RED}"
git checkout -q $LATEST > /dev/null
echo -e "${GREEN}OK${NC}."

cd "$BASE"

echo -n -e "Copying default configuration inside the project : ${RED}"
cp "$VIRTDIR/$REPODIR/provisioning/playbook.yml.dist" "$VIRTDIR/playbook.yml"
cp "$VIRTDIR/$REPODIR/parameters.yml.dist" "$VIRTDIR/parameters.yml"
cp "$VIRTDIR/$REPODIR/ansible.cfg.dist" "ansible.cfg"
cp "$VIRTDIR/$REPODIR/Vagrantfile.dist" "Vagrantfile"
echo -e "${GREEN}OK${NC}."

echo -n -e "Adding new files to git : ${RED}"
git add -f ansible.cfg Vagrantfile virtualization/parameters.yml virtualization/playbook.yml virtualization/drifter
echo -e "${GREEN}OK${NC}."
echo -n -e "Committing : ${RED}"
git commit -m "Install Drifter" > /dev/null
echo -e "${GREEN}OK${NC}."

echo
echo -e "You can now configure Drifter by modifying the following files : "
echo -e "\t * ${VIRTDIR}/playbook.yml   : to configure what needs to be installed inside the box"
echo -e "\t * ${VIRTDIR}/parameters.yml : for project parameters"

# remove error handler
trap : 0
