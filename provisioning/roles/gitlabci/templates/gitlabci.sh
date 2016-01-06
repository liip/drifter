#!/bin/sh 

export CI_TEST_SCRIPT={{ ci_scripts_folder }}run_tests.sh

# if you want to use a global cache dir which is used
# across all projects (even not your own), enable this
# can for example be used with composer cache

# export DO_GLOBAL_PROJECTS_CACHE=true

# In the case we have windows hosts, then we copied
# the Vagrantfile into our root dir and don't have 
# a symlink, we check later, if they are the same
# If you don't want this check, uncomment the following

# export DONT_CHECK_VAGRANTFILE_SAMENESS=true 

echo "- Update submodules"
git submodule update --init

./virtualization/rawbot-virtualization/ci/start.sh