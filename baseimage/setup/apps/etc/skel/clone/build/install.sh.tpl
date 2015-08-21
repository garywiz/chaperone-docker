#!/bin/bash

cd /setup

# remove existing chaperone.d and startup.d from /apps so none linger
rm -rf /apps; mkdir /apps

# copy everything from setup to the root /apps except Dockerfile rebuild materials
echo copying application files to /apps ...
tar cf - --exclude ./build --exclude ./build.sh --exclude ./run.sh . | (cd /apps; tar xf -)

# update the version information
mv /setup/build/new_version.inc /apps/etc/version.inc

# If there is an 100-install.sh executable script available in startup.d, then incorporate
# it into our image build and comment them out so the next build documents, but does not
# include them.

if [ -x startup.d/100-install.sh ]; then
  # Execute these
  ./startup.d/100-install.sh BUILD
  # Comment them out so the install file can be incrementally used again.
  sed -r '/AFTER THIS LINE/,$ s/^[ \t]*[^# \t].*/#\0/' startup.d/100-install.sh >/apps/startup.d/100-install.sh
fi

# Add additional setup commands for your production image here, if any.  However, the best
# way is to put things in 100-install.sh.
# ...

# Clean up and assure permissions are correct

rm -rf /setup
chown -R runapps: /apps    # for full-container execution
