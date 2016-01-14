#!/bin/sh 

export CI_TEST_SCRIPT={{ ci_scripts_folder }}run_tests.sh

# if you don't want to use a global cache dir which is used
# across all projects (even not your own), disable .this
# can for example be used with php composer cache

export DO_GLOBAL_PROJECTS_CACHE=true

echo "- Update submodules"
git submodule update --init

export VIRTUALBOX_NAME=$1

./virtualization/drifter/ci/start.sh