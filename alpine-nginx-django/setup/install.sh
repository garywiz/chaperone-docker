#!/bin/bash

# Preamble derived from the prepare.sh script from https://github.com/phusion/baseimage-docker.
# Thank you, phusion, for all the lessons learned.

apk --update add nginx openssl uwsgi-python3
pip3 install django

# Copy new apps files into /apps
cp -a /setup-np/apps/* /apps

# Remove any stray files, then compile all python files so there are .pyc equivalents
rm -rf `find /apps -name '*~' -o -name '__pycache__'`
python3 -m compileall -f -q /apps/www

mv /setup-np/this_version.inc /apps/etc/version.inc
chown -R runapps: /apps

# Remove sample application from chaperone.d
rm /apps/chaperone.d/200-userapp.conf
rm /apps/bin/sample_app

# Do other cleanups
rm -r /setup-np
rm -rf /tmp/* /var/tmp/* /var/cache/apk/*
rm -f `find /apps -name '*~'`
echo done.
