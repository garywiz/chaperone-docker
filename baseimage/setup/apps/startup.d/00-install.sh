#!/bin/bash

# This script makes it easy to build "derivative containers" which have additional
# requirements installed.  Skip down to the bottom, where you can see examples of
# what to do.
#
# These additional installs will be applied BOTH when you execute your container
# for the first time, as well as when you build a new derivative container 
# using ../build.sh.

# No need to change the following.... head down below...

if [ "$1" != "BUILD" ]; then
  # CONTAINER STARTUP MODE 
  INSTALL_LOG=$APPS_DIR/var/log/install.log
  # Re-run this script as root, but only container initialization
  [ "$CONTAINER_INIT" == "1$1" ] && su -c "$0 GO" >$INSTALL_LOG 2>&1
  [ "$1" != "GO" ] && exit
  log_startup="logger -p warn Installing additional software (progress in $INSTALL_LOG)"
else
  # DOCKERFILE BUILD MODE
  log_startup="echo Installing 00-install.sh requirements"
fi

##############################################################################################
# Add additional packages AFTER THIS LINE (Do not remove this line, build scripts expect it) #
# Delete or change anything you want below.                                                  #
##############################################################################################

# Might be useful to uncomment this preamble ...
#$log_startup
#apt-get update

# For example, to install django...
# apt-get install -y python-pip#
# pip install django
