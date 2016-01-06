# Integrating with Gitlab CI

(These instructions are specifically for the Liip Gitlab CI, but may be used on other Gitlab CI's as well)

To make it easy to run tests on the Gitlab CI runners, this packages provides some general purpose scripts, so you don't have to reinvent the wheel all the time.

## Setup

### Copy some files

Copy the following files to some location (we have a /scripts/ folder, but you can choose any directory)

````
SCRIPTS_FOLDER=./scripts/
cp virtualization/rawbot-virtualization/ci/templates/gitlab-ci.yml .gitlab-ci.yml
cp virtualization/rawbot-virtualization/ci/templates/gitlabci.sh $SCRIPTS_FOLDER/gitlabci.sh
cp virtualization/rawbot-virtualization/ci/templates/test.sh $SCRIPTS_FOLDER/test.sh
````

If you choose a different folder than ./scripts/ then adjust also `.gitlab-ci.yml` and `$SCRIPTS_FOLDER/gitlabci.sh`

### Add your tests

Put your test scripts into `$SCRIPTS_FOLDER/test.sh` and they should be run the next time you push something to gitlab (also make sure you enable one of the go-based gitlab runners for your project, the ones labeled with "go", "shell", and "lxc")

You can also use any other file, but then adjust the env variable `CI_TEST_SCRIPT` in  $SCRIPTS_FOLDER/gitlabci.sh

## Customization

### Not provisioning all the time....

If you want to avoid that the ci runners do call the provisioning all the time, add a file in `virtualization/provisionbuild.dat` to your project, with eg.

````
date +%Y%m%d%H%M%S > virtualization/provisionbuild.dat
````

The Gitlab CI scripts will now only do provisioning, when that file has a different content (or start from scratch)

### Global project cache

On each runner, there's a global project cache (shared with all projects), which can be mounted, uncomment `export DO_GLOBAL_PROJECTS_CACHE=true` in `$SCRIPTS_FOLDER/gitlabci.sh` and that will be mounted into `/home/vagrant/.projects_cache`. We for example add the php composer cache dir there into `/home/vagrant/.projects_cache/composer_cache`, so that not every project has to download the same project all over again.

NPM would maybe be another canditate.

As this is shared with all projects, be careful where to put things there.








