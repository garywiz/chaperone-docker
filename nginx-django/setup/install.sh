#!/bin/bash

# Preamble derived from the prepare.sh script from https://github.com/phusion/baseimage-docker.
# Thank you, phusion, for all the lessons learned.

/setup-np/apt_setproxy on

add-apt-repository ppa:nginx/stable

apt-get update
apt-get install -y nginx openssl libpython3.4
pip3 install django

# Copy new apps files into /apps
cp -a /setup-np/apps/* /apps

# Install prebuilt binaries
(cd /; tar xzf /setup-np/lib/uwsgi-install.tar.gz)

# Remove any stray files, then compile all python files so there are .pyc equivalents
rm -rf `find /apps -name '*~' -o -name '__pycache__'`
python3 -m compileall -f -q /apps/www

mv /setup-np/this_version.inc /apps/etc/version.inc
chown -R runapps: /apps

# Remove sample application from chaperone.d
rm /apps/chaperone.d/200-userapp.conf
rm /apps/bin/sample_app

# Clean up apt
apt-get clean
/setup-np/apt_setproxy off
rm -rf /var/lib/apt/lists/*
rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup

# Do other cleanups
rm -r /setup-np
rm -rf /tmp/* /var/tmp/* /var/cache/apk/*
rm -f `find /apps -name '*~'`
echo done.
