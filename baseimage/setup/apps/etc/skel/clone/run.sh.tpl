#!/bin/bash
#Developer's startup script
#Created by chaplocal on %(`date`)

IMAGE="%(PARENT_IMAGE)"
INTERACTIVE_SHELL="/bin/bash"

EXT_HOSTNAME=localhost

# Uncomment to hardcode ports for startup.  Command line still overrides.
#PORTOPT="-p x:y -p x:y"

usage() {
  echo "Usage: run.sh [-d] [-p port#] [-h] [extra-chaperone-options]"
  echo "       Run $IMAGE as a daemon or interactively (the default)."
  echo "       First available port will be remapped to $EXT_HOSTNAME if possible."
  exit
}

if [ "$CHAP_SERVICE_NAME" != "" ]; then
  echo run.sh should be executed on your docker host, not inside a container.
  exit
fi

cd ${0%/*} # go to directory of this file
APPS=$PWD
cd ..

options="-t -i -e TERM=$TERM --rm=true"
shellopt="/bin/bash --rcfile $APPS/bash.bashrc"

while getopts ":-dp:n:" o; do
  case "$o" in
    d)
      options="-d"
      shellopt=""
      ;;
    n)
      options="$options --name $OPTARG"
      ;;
    p)
      PORTOPT="-p $OPTARG"
      ;;      
    -) # first long option terminates
      break
      ;;
    *)
      usage
      ;;
  esac
done
shift $((OPTIND-1))

# remap ports according to the image, and tell the container about the lowest numbered
# port used.

DOCKER_CMD=$(docker version >/dev/null 2>&1 && echo docker || echo 'sudo docker')

if [ "$PORTOPT" == "" ]; then
  exposed=`$DOCKER_CMD inspect $IMAGE | sed -ne 's/^ *"\([0-9]*\)\/tcp".*$/\1/p' | sort -u`
  ncprog=`which nc 2>/dev/null`
  if [ "$exposed" != "" -a "$ncprog" != "" ]; then
    PORTOPT=""
    for PORT in $exposed; do
      if ! $ncprog -z $EXT_HOSTNAME $PORT; then
	 [ "$PORTOPT" == "" ] && PORTOPT="--env CONFIG_EXT_PORT=$PORT"
         PORTOPT="$PORTOPT -p $PORT:$PORT"
	 echo "Port $PORT available at $EXT_HOSTNAME:$PORT ..."
      fi
    done
  else
    if [ "$exposed" != "" ]; then
      echo "Note: '/bin/nc' not installed, so cannot detect port usage on this system."
      echo "      Use '$0 -p x:y' to expose ports."
    fi
  fi
fi

# Run the image with this directory as our local apps dir.
# Create a user with a uid/gid based upon the file permissions of the chaperone.d
# directory.

MOUNT=${PWD#/}; MOUNT=/${MOUNT%%/*} # extract user mountpoint
SELINUX_FLAG=$(sestatus 2>/dev/null | fgrep -q enabled && echo :z)

$DOCKER_CMD run $options -v $MOUNT:$MOUNT$SELINUX_FLAG $PORTOPT --env CONFIG_EXT_HOSTNAME=$EXT_HOSTNAME $IMAGE \
   --create $USER:$APPS/chaperone.d --config $APPS/chaperone.d $* $shellopt
