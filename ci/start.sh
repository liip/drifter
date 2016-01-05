#!/bin/bash

set -e

echo -e "\nStarting the build..."

function finish() {
    echo -e "\033[31mBuild failed, cleanup\e[0m\n- Stop vagrant"
    cleanup
    echo -e "\n\033[31mBuild NOT successfull\e[0m"
    exit $1
}

function cleanup() {
   vagrant halt -f
}

trap finish EXIT SIGHUP SIGINT SIGTERM

if [[ $DO_GLOBAL_PROJECTS_CACHE && $GITLAB_CI ]];
then
    echo -e "- Create projects cache dir"
    mkdir -p /home/gitlab-runner/projects_cache/
fi

echo -e "- Start vagrant"

if [ -f ./virtualization/provisionbuild.dat ]
then
    vagrant up --provider lxc --no-provision
    echo -e "- Check if provisioning is needed"
    vagrant ssh -c "if [ -f /home/vagrant/provisionbuild.last ]; then cp /home/vagrant/provisionbuild.last /vagrant/virtualization/provisionbuild.last; fi"
    LASTPROVISION=$(if [ -f ./virtualization/provisionbuild.last ]; then cat ./virtualization/provisionbuild.last; else date; fi) # date == make sure provisioning is run, when that file doesn't exist
    THISPROVISION=$(if [ -f ./virtualization/provisionbuild.dat ]; then cat ./virtualization/provisionbuild.dat; else echo ""; fi)
    if [ "$LASTPROVISION" != "$THISPROVISION" ]
    then
      vagrant provision
      vagrant ssh -c "echo $THISPROVISION > /home/vagrant/provisionbuild.last"
    fi
else
    vagrant up --provider lxc --provision
fi
    
echo -e "- Start ssh-agent"
. ./virtualization/rawbot-virtualization/ci/ssh-agent.sh

if [ -f $CI_TEST_SCRIPT ]; 
then
    echo -e "- Run $CI_TEST_SCRIPT"
    vagrant ssh -c "cd /vagrant && $CI_TEST_SCRIPT"
else
    echo -e "\033[31mNo test script found ($CI_TEST_SCRIPT) \e[0m"
fi

trap - EXIT SIGHUP SIGINT SIGTERM

cleanup

if [[ -z $GITLAB_CI ]]; then
    echo -e "\n\e[32mBuild successful\e[0m"
fi