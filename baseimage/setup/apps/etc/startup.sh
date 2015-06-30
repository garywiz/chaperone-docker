#!/bin/bash
# A quick script to initialize the system.  This is not equivalent
# to the classic /etc/init.d type initailization, but more of a preparation
# phase so that services have what they need to run.

# We publish two variables for use in startup scripts:
#
#   CONTAINER_INIT=1   if we are initializing the container for the first time
#   APPS_INIT=1        if we are initializing the $APPS_DIR for the first time
#
# Both may be relevant, since it's possible that the $APPS_DIR may be on a mount point
# so it can be reused when starting up containers which refer to it.

function dolog() { logger -t startup.sh -p info $*; }

apps_startup_file="$APPS_DIR/var/run/apps_startup.done"
cont_startup_file="/container_startup.done"

export CONTAINER_INIT=0
export APPS_INIT=0

if [ ! -f $cont_startup_file ]; then
    dolog "initializing container for the first time"
    CONTAINER_INIT=1
    sudo bash "date >$cont_startup_file"
fi

if [ ! -f $apps_startup_file ]; then
    dolog "initializing $APPS_DIR for the first time"
    APPS_INIT=1
    mkdir -p $APPS_DIR/var/run $APPS_DIR/var/log
    chmod 777 $APPS_DIR/var/run $APPS_DIR/var/log
    date >$apps_startup_file
fi

if [ -d $APPS_DIR/startup.d ]; then
  for sf in $( find $APPS_DIR/startup.d -type f -executable \! -name '*~' ); do
    dolog "running $sf..."
    $sf
  done
fi

if [ "$SECURE_ROOT" == "1" -a $CONTAINER_INIT == 1 ]; then
  dolog locking down root account
  sudo passwd -l root
  sudo sed '/NOPASSWD/ d' -i /etc/sudoers
fi
