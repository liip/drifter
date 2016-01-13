Create boxes
============

## LXC

```
git clone https://github.com/team-rawbot/vagrant-lxc-base-boxes
cd vagrant-lxc-base-boxes
make jessie
```

If you're getting errors when trying to install the base packages, check your
default LXC config (`/etc/lxc/default.conf`) and adapt it to your setup:

```
lxc.network.type = veth
lxc.network.link = lxcbr0
lxc.network.flags = up
```

## VirtualBox

Install [veewee](https://github.com/jedi4ever/veewee/) and then:

```
git clone https://github.com/team-rawbot/veewee-definitions definitions
veewee vbox build liip-jessie64
veewee vbox export liip-jessie64
```
