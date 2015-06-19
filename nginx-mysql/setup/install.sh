#!/bin/bash

# Preamble derived from the prepare.sh script from https://github.com/phusion/baseimage-docker.
# Thank you, phusion, for all the lessons learned.

MYSQL_ROOT_PW='ChangeMe'

export DEBIAN_FRONTEND=noninteractive

function do_apt_install() {
    apt-get install -y --no-install-recommends $*
}

# Use a proxy if we have one set up
/setup-nginx-mysql/apt_setproxy on

# add nginx repo, update indices
apt-key add /setup-nginx-mysql/nginx_signing.key
add-apt-repository ppa:nginx/stable
apt-get update

# Copy new apps files into /apps
cp -av /setup-nginx-mysql/apps/* /apps

# Remove sample application from chaperone.d
rm /apps/chaperone.d/200-userapp.conf
rm /apps/bin/sample_app

# Normal install steps
do_apt_install nginx

debconf-set-selections <<< "debconf debconf/frontend select Noninteractive"

debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_ROOT_PW"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PW"
debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password password $MYSQL_ROOT_PW"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $MYSQL_ROOT_PW"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $MYSQL_ROOT_PW"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $MYSQL_ROOT_PW"
debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none"

do_apt_install -y mysql-server
/usr/bin/mysqld_safe &		# doesn't start because of rc policy, but this fixes it

# Install phpmyadmin.  Actual setup occurs at first boot, since it depends on what user we run the container
# as.
do_apt_install phpmyadmin
php5enmod mcrypt

# Commonly used php stuff
do_apt_install php-pear

# Clean up apt
apt-get clean
/setup-nginx-mysql/apt_setproxy off
rm -rf /var/lib/apt/lists/*
rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup

# Do other cleanups
rm -r /setup-nginx-mysql
rm -rf /tmp/* /var/tmp/*
rm -f `find /apps -name '*~'`
echo done.
