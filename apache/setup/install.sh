#!/bin/bash

# Preamble derived from the prepare.sh script from https://github.com/phusion/baseimage-docker.
# Thank you, phusion, for all the lessons learned.

MYSQL_ROOT_PW='ChangeMe'

export DEBIAN_FRONTEND=noninteractive

function do_apt_install() {
    apt-get install -y --no-install-recommends $*
}

# Use a proxy if we have one set up
/setup-apache/apt_setproxy on

# update indices
apt-get update

# Copy new apps files into /apps
cp -av /setup-apache/apps/* /apps
chown -R runapps: /apps

# Remove sample application and irrelevant templates
rm /apps/chaperone.d/200-userapp.conf
rm /apps/bin/sample_app

# Normal install steps
do_apt_install apache2 apache2-utils
a2enmod include cgi		# these are needed by the sample site (SSI, wow, blast from the past!)

# Clean up apt
apt-get clean
/setup-apache/apt_setproxy off
rm -rf /var/lib/apt/lists/*
rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup

# Do other cleanups
rm -r /setup-apache
rm -rf /tmp/* /var/tmp/*
rm -f `find /apps -name '*~'`
echo done.
