#!/bin/sh -x

# this script is used to install the virtualization capabilities in a new project
# it is used the following way

BASE=$(pwd)
VIRTDIR="virtualization"
REPODIR="rawbot-docker"
VIRTIBIN="container"

mkdir $VIRTDIR

git submodule add git@github.com:team-rawbot/rawbot-docker.git $VIRTDIR/$REPODIR

cp $VIRTDIR/$REPODIR/provisioning/playbook.yml.dist $VIRTDIR/playbook.yml

cd $VIRTDIR
ln -s $REPODIR/Dockerfile Dockerfile
cd $BASE

cat << EOF > $VIRTIBIN
#!/bin/sh

cd $VIRTDIR/$REPODIR
./container "\$@"
EOF
chmod +x $VIRTIBIN

cat << EOF > $VIRTDIR/parameters.yml
project_name: "test"
hostname: "{{ project_name }}.lo"
hostnames: []
EOF
