#!/bin/sh -x

# this script is used to install the virtualization capabilities in a new project
# it is used the following way

VIRTDIR="virtualization"
VIRTIBIN="container"

git submodule add git@github.com:team-rawbot/rawbot-docker.git $VIRTDIR

cp $VIRTDIR/provisioning/playbook.yml.dist virt-playbook.yml

ln -s $VIRTDIR/Dockerfile Dockerfile

cat << EOF > $VIRTIBIN
#!/bin/sh

cd $VIRTDIR
./container "\$@"
EOF
chmod +x $VIRTIBIN

cat << EOF > virt-parameters.yml
ip_suffix: 10 # This is the IP suffix to use (it must be unique accross projects)
image_repository: 'liip' # This is the image repository
image_name: 'test' # This is the name of the docker image
EOF
