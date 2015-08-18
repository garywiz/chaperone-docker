#!/bin/bash
#Extracted from %(PARENT_IMAGE) on %(`date`)

# Run as interactive: ./%(DEFAULT_LAUNCHER) [options)
#          or daemon: ./%(DEFAULT_LAUNCHER) -d [options)

IMAGE="%(PARENT_IMAGE)"
INTERACTIVE_SHELL="/bin/bash"

# You can specify the external host and ports for Apache here.  These variables
# are also passed into the container so that any application code which does redirects
# can use these if need be.

EXT_HOSTNAME=%(CONFIG_EXT_HOSTNAME:-localhost)
EXT_HTTP_PORT=%(CONFIG_EXT_HTTP_PORT:-8080)
EXT_HTTPS_PORT=%(CONFIG_EXT_HTTPS_PORT:-8443)

# Uncomment to enable SSL and specify the certificate hostname
#EXT_SSL_HOSTNAME=secure.example.com

PORTOPT="-p $EXT_HTTP_PORT:8080 -p $EXT_HTTPS_PORT:8443"

# If this directory exists and is writable, then it will be used
# as attached storage
STORAGE_LOCATION="$PWD/%(IMAGE_BASENAME)-storage"
STORAGE_USER="$USER"

# The rest should be OK...

if [ "$1" == '-d' ]; then
  shift
  docker_opt="-d $PORTOPT"
  INTERACTIVE_SHELL=""
else
  docker_opt="-t -i -e TERM=$TERM --rm=true $PORTOPT"
fi

docker_opt="$docker_opt \
  -e CONFIG_EXT_HOSTNAME=$EXT_HOSTNAME \
  -e CONFIG_EXT_HTTPS_PORT=$EXT_HTTPS_PORT \
  -e CONFIG_EXT_HTTP_PORT=$EXT_HTTP_PORT"

[ "$EXT_SSL_HOSTNAME" != "" ] && docker_opt="$docker_opt -e CONFIG_EXT_SSL_HOSTNAME=$EXT_SSL_HOSTNAME"

if [ "$STORAGE_LOCATION" != "" -a -d "$STORAGE_LOCATION" -a -w "$STORAGE_LOCATION" ]; then
  docker_opt="$docker_opt -v $STORAGE_LOCATION:/apps/var"
  chap_opt="--create $STORAGE_USER:/apps/var"
  echo Using attached storage at $STORAGE_LOCATION
fi

docker run $docker_opt $IMAGE $chap_opt $* $INTERACTIVE_SHELL
