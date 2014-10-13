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
docker:
    image_repository: 'liip' # This is the image repository
    image_name: 'test' # This is the name of the docker image
hostname: "{{ docker.image_name }}.docker.lo"
hostnames: []
EOF
