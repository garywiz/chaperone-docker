#!bin/bash

# Preamble derived from the prepare.sh script from https://github.com/phusion/baseimage-docker.
# Thank you, phusion, for all the lessons learned.

export LC_ALL=C
export DEBIAN_FRONTEND=noninteractive

function do_apt_install() {
    apt-get install -y --no-install-recommends $*
}

# Use a proxy if we have one set up
/setup/apt_setproxy on

## Temporarily disable dpkg fsync to make building faster.
if [[ ! -e /etc/dpkg/dpkg.cfg.d/docker-apt-speedup ]]; then
	echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/docker-apt-speedup
fi

## Prevent initramfs updates from trying to run grub and lilo.
## https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
## http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594189
export INITRD=no

## Enable Ubuntu Universe and Multiverse.
sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list
sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list
apt-get update

## Fix some issues with APT packages.
## See https://github.com/dotcloud/docker/issues/1024
dpkg-divert --local --rename --add /sbin/initctl
ln -sf /bin/true /sbin/initctl

## Replace the 'ischroot' tool to make it always return true.
## Prevent initscripts updates from breaking /dev/shm.
## https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
## https://bugs.launchpad.net/launchpad/+bug/974584
dpkg-divert --local --rename --add /usr/bin/ischroot
ln -sf /bin/true /usr/bin/ischroot

## Install HTTPS support for APT.
do_apt_install apt-transport-https ca-certificates

## Install add-apt-repository
do_apt_install software-properties-common

## Upgrade all packages.
apt-get dist-upgrade -y --no-install-recommends

## Fix locale.
do_apt_install language-pack-en
locale-gen en_US
update-locale LANG=en_US.UTF-8 LC_CTYPE=en_US.UTF-8

# Miscellaneous useful utilities
do_apt_install nano curl less vim psmisc

# Install prebuilt binaries
(cd /; tar xzf /setup/lib/setproctitle-install.tar.gz)

# Install pip and chaperone
do_apt_install python3-pip
pip3 install chaperone

# Now, just so there is no confusion, create a new, empty /var/log directory so that any logs
# written will obviously be written by the current container software.  Keep the old one so
# it's there for reference so we can see what the distribution did.
cd /var
mv log log-dist
mkdir log
chmod 775 log
chown root.syslog log

# Customize some system files
cp /setup/dot.bashrc /root/.bashrc

# Allow unfettered root access by users. This is done so that apps/init.d scripts can
# have unfettered access to root on their first startup to configure userspace files
# if needed (see mysql in chaperone-lamp for an example).  At the end of the first startup
# this is then locked down by apps/etc/init.sh.
passwd -d root
sed -i 's/nullok_secure/nullok/' /etc/pam.d/common-auth

# Create default /apps directory
cp -a /setup/apps /

# Clean up apt
apt-get clean
/setup/apt_setproxy off
rm -rf /var/lib/apt/lists/*
rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup

# Do other cleanups
rm -rf /setup
rm -rf /tmp/* /var/tmp/*
rm -f `find /apps -name '*~'`
