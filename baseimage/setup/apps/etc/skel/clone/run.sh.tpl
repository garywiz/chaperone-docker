#!/bin/bash
#Developer's startup script
#Created by chaplocal on %(`date`)

usage() {
  echo "Usage: run.sh [-d] [-p port#] [-h] [extra-chaperone-options]"
  echo "       Run $IMAGE as a daemon or interactively (the default)."
  echo "       First available port will be remapped to $DOCKERHOST if possible."
  exit
}

IMAGE="%(PARENT_IMAGE)"
INTERACTIVE_SHELL="/bin/bash"

# Uncomment to include port settings
#PORTOPT="-p x:y"

EXT_HOSTNAME=$(hostname -f)

# Uncomment to hardcode ports for startup.  Command line still overrides.
#PORTOPT="-p x:y -p x:y"

if [ "$CHAP_SERVICE_NAME" != "" ]; then
  echo run.sh should be executed on your docker host, not inside a container.
  exit
fi

cd ${0%/*} # go to directory of this file
APPS=$PWD
cd ..

options="-t -i -e TERM=$TERM --rm=true"
shellopt="/bin/bash --rcfile $APPS/bash.bashrc"

while getopts ":-dp:" o; do
  case "$o" in
    d)
      options="-d"
      shellopt=""
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

if [ "$PORTOPT" == "" ]; then
  exposed=`docker inspect $IMAGE | sed -ne 's/^ *"\([0-9]*\)\/tcp".*$/\1/p' - | sort -u`
  if [ "$exposed" != "" -a -x /bin/nc ]; then
    PORTOPT=""
    for PORT in $exposed; do
      if ! /bin/nc -z $DOCKERHOST $PORT; then
	 [ "$PORTOPT" == "" ] && PORTOPT="--env CONFIG_EXT_PORT=$PORT"
         PORTOPT="$PORTOPT -p $PORT:$PORT"
	 echo "Port $PORT available at $DOCKERHOST:$PORT ..."
      fi
    done
  else
    if [ "$exposed" != "" ]; then
      echo "Note: '/bin/nc' not installed, so cannot detect port usage on this system."
      echo "      Use '$0 -p x:y' to expose ports."
    fi
  fi
fi

# Extract our local UID/GID
myuid=`id -u`
mygid=`id -g`

# Run the image with this directory as our local apps dir.
# Create a user with uid=$myuid inside the container so the mountpoint permissions
# are correct.

docker run $options -v /home:/home $PORTOPT --env CONFIG_EXT_HOSTNAME=$EXT_HOSTNAME $IMAGE \
   --create $USER/$myuid --config $APPS/chaperone.d $* $shellopt
