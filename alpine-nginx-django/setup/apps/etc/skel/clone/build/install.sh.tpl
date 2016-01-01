#!/bin/bash

cd /setup

# remove existing chaperone.d and startup.d from /apps so none linger
rm -rf /apps; mkdir /apps

# copy everything from setup to the root /apps except Dockerfile rebuild materials
echo copying application files to /apps ...
tar cf - --exclude ./build --exclude ./build.sh --exclude ./run.sh . | (cd /apps; tar xf -)

# Update the version information, if a replacement exists
[ -f /setup/build/new_version.inc ] && mv /setup/build/new_version.inc /apps/etc/version.inc

# Django Extensions
#
# This build uses Python3, so you'll need to install any Django extensions from PyPi using
# the pip3 command.  You may also need to add additional Alpine linux packages, listed here:
# https://pkgs.alpinelinux.org/packages?name=php-%25&repo=all&arch=x86_64&maintainer=all

## Uncomment and customize...
# pip3 install django-registration ...
# ...
# apk --update add xxx

# Add additional setup commands for your production image here, if any.
# ...

# Clean up and assure permissions are correct

rm -rf /setup
chown -R runapps: /apps    # for full-container execution
