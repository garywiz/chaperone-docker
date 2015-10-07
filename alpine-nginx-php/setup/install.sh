#!/bin/bash

# Preamble derived from the prepare.sh script from https://github.com/phusion/baseimage-docker.
# Thank you, phusion, for all the lessons learned.

apk add --update nginx php-fpm php-cli php-sqlite3 openssl

# Copy new apps files into /apps
cp -av /setup-np/apps/* /apps
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
