#!bin/bash

# Preamble derived from the prepare.sh script from https://github.com/phusion/baseimage-docker.
# Thank you, phusion, for all the lessons learned.

. /setup-baseimage/buildenv.inc

export LC_ALL=C

df
yum update -y
yum install -y sudo passwd nano openssl
df

# open up all sudo commands to all users.  See apps/etc/startup.sh.  If SECURE_ROOT is set, then
# startup will lock down root after the container is initialized and running.

echo "ALL ALL=NOPASSWD: ALL" >>/etc/sudoers    

# Install python
mkdir /setup-baseimage/build; cd /setup-baseimage/build
curl -O http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
rpm -ivh epel-release-*
yum install -y python34
curl -s "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
python3.4 get-pip.py

# set up symlinks
cd /usr/bin
ln -s python3.4 python3

# Install prebuilt binaries
(cd /; tar xzf /setup-baseimage/lib/setproctitle-install.tar.gz)
df

# Install chaperone
$BUILD_CHAPERONE_INSTALL # normally 'pip3 install chaperone' located in buildenv.inc

# Now, just so there is no confusion, create a new, empty /var/log directory so that any logs
# written will obviously be written by the current container software.  Keep the old one so
# it's there for reference so we can see what the distribution did.
cd /var
mv log log-dist
mkdir log
chmod 775 log
chown root log

# Customize some system files
cp /setup-baseimage/dot.bashrc /root/.bashrc

# Allow unfettered root access by users. This is done so that apps/startup.d scripts can
# have unfettered access to root on their first startup to configure userspace files
# if needed (see mysql in chaperone-lamp for an example).  At the end of the first startup
# this is then locked down by apps/etc/init.sh.
passwd -d root
sed -i 's/nullok_secure/nullok/' /etc/pam.d/common-auth

# Create default /apps directory and version file
cp -a /setup-baseimage/apps /
cp /setup-baseimage/this_version.inc /apps/etc/version.inc

# Set up runapps user

groupadd -g 901 runapps
useradd -g runapps -u 901 --no-create-home --home-dir / runapps
chown -R runapps: /apps

# Do final cleanups
cd /
yum clean
rm -rf /setup-baseimage
rm -rf /tmp/* /var/tmp/*
rm -f `find /apps -name '*~'`

df

echo done.
