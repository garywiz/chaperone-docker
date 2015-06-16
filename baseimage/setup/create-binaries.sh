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

docker run -i -v $absdir/setup:/setup --rm=true ubuntu:14.04 <<EOF

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
mkdir /setup/lib

echo Copy them to our shared mount bin...
cd dist
cp -v setproctitle-*.gz /setup/lib/setproctitle-install.tar.gz
chown -R --reference /setup/create-binaries.sh /setup/lib

EOF
