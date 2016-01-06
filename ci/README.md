# Integrating with Gitlab CI

(These instructions are specifically for the Liip Gitlab CI, but may be used on other Gitlab CI's as well)

To make it easy to run tests on the Gitlab CI runners, this packages provides some general purpose scripts, so you don't have to reinvent the wheel all the time.

## Setup

### Using the gitlabci role

The automatic way. Just uncomment/add the folloing line in your `playbook.yml` and the needed files will be created automatically on the next provsioning (if they don't exist already)

````
    - { role: gitlabci }
````

It installs the following files (which should be added to git afterwards)

#### .gitlab-ci.yml

The config file for Gitlab CI, it tells the CI what exactly to run

#### scripts/gitlabci.sh

The script called first by the gitlab runner. It updates the submodules and then calls `./virtualization/rawbot-virtualization/ci/start.sh`, which does start vagrant, provisions it and calls your actual test script. 

#### scripts/run_tests.sh

This is where your actually test calls go. This is run within your vagrant box.

#### virtualization/provisionbuild.dat

To prevent provisioning on the ci runners all the time and save lots of time, provisioning is only run, when this file changes. Therefore if you change something in your provisioning scripts, also changes this file to a different value (doesn't matter which one, as long as it's different, but some kind of timestamp assures that it's different)

If you don't add this file to your project, then provisioning will be run every time a ci build is started.

#### Using a different folder than scripts/

If you prefer to install those files in a different folder than scripts/ you can add the following line in your `parameters.yml`, eg:

```
ci_scripts_folder: bin/
```

You can also adjust the files afterwards and uncomment the gitlabci role in `playbook.yml` again (otherwise the files will be created again after each provisioning)


### Installing it manually

Copy the following files to some location (we have a /scripts/ folder, but you can choose any directory)

````
SCRIPTS_FOLDER=./scripts/
cp virtualization/rawbot-virtualization/provisioning/roles/gitlabci/templates/gitlab-ci.yml .gitlab-ci.yml
cp virtualization/rawbot-virtualization/provisioning/roles/gitlabci/templates/gitlabci.sh $SCRIPTS_FOLDER/gitlabci.sh
cp virtualization/rawbot-virtualization/provisioning/roles/gitlabci/files/run_tests.sh $SCRIPTS_FOLDER/run_tests.sh
date +%Y%m%d%H%M%S > virtualization/provisionbuild.dat
````

And adjust `.gitlab-ci.yml` and `$SCRIPTS_FOLDER/gitlabci.sh` with the corrects paths.

## Add your tests

Put your test scripts into `$SCRIPTS_FOLDER/run_tests.sh` and they should be run the next time you push something to gitlab (also make sure you enable one of the go-based gitlab runners for your project, the ones labeled with "go", "shell", and "lxc")

You can also use any other file, but then adjust the env variable `CI_TEST_SCRIPT` in  $SCRIPTS_FOLDER/gitlabci.sh

## Customization


### Global project cache

On each runner, there's a global project cache (shared with all projects), which can be mounted, uncomment `export DO_GLOBAL_PROJECTS_CACHE=true` in `$SCRIPTS_FOLDER/gitlabci.sh` and that will be mounted into `/home/vagrant/.projects_cache`. We for example add the php composer cache dir there into `/home/vagrant/.projects_cache/composer_cache`, so that not every project has to download the same project all over again.

NPM would maybe be another canditate.

As this is shared with all projects, be careful where to put things there.








