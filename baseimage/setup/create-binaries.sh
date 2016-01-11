#!/bin/bash

# This is NOT run during the docker image build, but is here for convenience because it is part of
# a pre-build setp.  Some installations require gcc and all the development tools, which adds 100MB or
# more to the image!  Hate that!  So, what we do in the Makefile is this:
#
#  	docker run -i ubuntu:14.04 --rm=true <image/setup/create-binaries.in >image/setup/binaries.out
#
# It runs a separate container, builds the binary packages, then includees them in a root-extractable
# bundle.  Since this is the same architecture as used by the image build, all should be compatible.

# Find our absolute directory so we can mount ./setup
cd ${0%/*}/..
absdir=$PWD
echo $absdir

zflag=$(sestatus 2>/dev/null | fgrep -q enabled && echo :z)
docker run -i -v $absdir/setup:/setup$zflag --rm=true ubuntu:14.04 /bin/bash <<"EOF"

# Obtain UID of the mounted volume so we don't copy as root
uid=`ls -l / | awk '/setup$/{print $3}'`
useradd -u $uid usetup

# Use a proxy if we have one
/setup/apt_setproxy on

echo Install all development tools...
apt-get update
apt-get install -y git python3-dev

echo Build binary versions of needed modules...
mkdir /build
git clone https://github.com/dvarrazzo/py-setproctitle.git
cd py-setproctitle
python3 setup.py bdist

ls -lR dist
echo Copy them to our shared mount bin...
cd dist
su usetup -c 'mkdir -p /setup/lib; cp -v setproctitle-*.gz /setup/lib/setproctitle-install.tar.gz'

EOF
