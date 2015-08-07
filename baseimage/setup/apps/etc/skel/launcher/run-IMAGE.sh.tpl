#!/bin/bash
#Extracted from %(PARENT_IMAGE) on %(`date`)

# Run as interactive: ./%(DEFAULT_LAUNCHER) [options]
#          or daemon: ./%(DEFAULT_LAUNCHER) -d [options]

IMAGE="%(PARENT_IMAGE)"
INTERACTIVE_SHELL="/bin/bash"

# Uncomment to include port settings
#PORTOPT="-p x:y"

EXT_HOSTNAME=%(CONFIG_EXT_HOSTNAME:-$(hostname -f))

# If this directory exists and is writable, then it will be used
# as attached storage
STORAGE_LOCATION="$PWD/baseimage-storage"
STORAGE_USER="$USER"
STORAGE_UID=`id -u`

# The rest should be OK...

if [ "$1" == '-d' ]; then
  shift
  docker_opt="-d $PORTOPT"
  INTERACTIVE_SHELL=""
else
  docker_opt="-t -i -e TERM=$TERM --rm=true $PORTOPT"
fi


if [ "$STORAGE_LOCATION" != "" -a -d "$STORAGE_LOCATION" -a -w "$STORAGE_LOCATION" ]; then
  docker_opt="$docker_opt -v $STORAGE_LOCATION:/apps/var"
  chap_opt="--create $STORAGE_USER/$STORAGE_UID"
  echo Using attached storage at $STORAGE_LOCATION
fi

docker run $docker_opt $IMAGE $chap_opt $* $INTERACTIVE_SHELL
