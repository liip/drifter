#!/bin/sh 

export CI_TEST_SCRIPT=./scripts/test.sh

#if you want to use a global cache dir which is used
# across all projects (even not your own), enable this
# can for example be used with composer cache

# export DO_GLOBAL_PROJECTS_CACHE=true

echo "- Update submodules"
git submodule update --init

./virtualization/rawbot-virtualization/ci/start.sh