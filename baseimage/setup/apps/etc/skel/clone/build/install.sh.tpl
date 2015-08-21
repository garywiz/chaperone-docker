#!/bin/bash

cd /setup

# remove existing chaperone.d and startup.d from /apps so none linger
rm -rf /apps; mkdir /apps

# copy everything from setup to the root /apps except Dockerfile rebuild materials
echo copying application files to /apps ...
tar cf - --exclude ./build --exclude ./build.sh --exclude ./run.sh . | (cd /apps; tar xf -)

# update the version information
mv /setup/build/new_version.inc /apps/etc/version.inc

# Add additional setup commands for your production image here, if any.
# ...

# Clean up and assure permissions are correct

rm -rf /setup
chown -R runapps: /apps    # for full-container execution
