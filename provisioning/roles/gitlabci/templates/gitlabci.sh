#!/bin/sh 

export CI_TEST_SCRIPT={{ ci_scripts_folder }}run_tests.sh

# if you don't want to use a global cache dir which is used
# across all projects (even not your own), disable .this
# can for example be used with php composer cache

export DO_GLOBAL_PROJECTS_CACHE=true


# if you want to destroy and up the box instead of "provision" if provisionbuild.dat changes
# uncomment this line
# export PROVISION_UPDATE_MODE="destroy"

echo "- Update submodules"
git submodule update --init

export VIRTUALBOX_NAME=$1

./virtualization/drifter/ci/start.sh
