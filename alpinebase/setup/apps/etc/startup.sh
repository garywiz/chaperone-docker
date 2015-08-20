#!/bin/bash
# A quick script to initialize the system.  This is not equivalent
# to the classic /etc/init.d type initailization, but more of a preparation
# phase so that services have what they need to run.

# We publish two variables for use in startup scripts:
#
#   CONTAINER_INIT=1   if we are initializing the container for the first time
#   VAR_INIT=1         if we are initializing the $VAR_DIR for the first time
#
# Both may be relevant, since it's possible that the $VAR_DIR may be on a mount point
# so it can be reused when starting up containers which refer to it.

function dolog() { logger -t startup.sh -p info $*; }
function critlog() { logger -t startup.sh -p crit $*; }

var_setup_file="$VAR_DIR/run/var_setup.done"
cont_setup_file="/container_setup.done"

export CONTAINER_INIT=0
export VAR_INIT=0

# Assure anything lingering that might interfere with restart is gone
rm -rf /tmp/*.pid /tmp/*.sock

if [ ! -f $cont_setup_file ]; then
    dolog "initializing container for the first time"
    CONTAINER_INIT=1
    sudo bash -c "date >$cont_setup_file"
fi

if [ ! -f $var_setup_file ]; then
    dolog "initializing $VAR_DIR for the first time"
    VAR_INIT=1
    mkdir -p $VAR_DIR >&/dev/null
    if [ ! -w $VAR_DIR ]; then
	critlog "$VAR_DIR is not writable by user '$USER' -- cannot complete set-up"
	exit 1
    fi
    mkdir -p $VAR_DIR/run $VAR_DIR/log
    chmod 777 $VAR_DIR/run $VAR_DIR/log
    date >$var_setup_file
fi

if [ -d $APPS_DIR/startup.d ]; then
  for sf in $( find $APPS_DIR/startup.d -type f -perm +100 \! -name '*~' | sort ); do
    dolog "running $sf..."
    $sf
  done
fi

if [ "$SECURE_ROOT" == "1" -a $CONTAINER_INIT == 1 ]; then
  dolog locking down root account
  sudo passwd -l root
  sudo sed '/NOPASSWD/ d' -i /etc/sudoers
fi
