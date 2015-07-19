#!/bin/bash

# Preamble derived from the prepare.sh script from https://github.com/phusion/baseimage-docker.
# Thank you, phusion, for all the lessons learned.

MYSQL_ROOT_PW='ChangeMe'

export DEBIAN_FRONTEND=noninteractive

function do_apt_install() {
    apt-get install -y --no-install-recommends $*
}

# Use a proxy if we have one set up
/setup-lamp/apt_setproxy on

# update indices
apt-get update

# Copy new apps files into /apps
cp -av /setup-lamp/apps/* /apps
chown -R runapps: /apps

# Remove sample application from chaperone.d
rm /apps/chaperone.d/200-userapp.conf
rm /apps/bin/sample_app

# Normal install steps
do_apt_install apache2 apache2-utils

debconf-set-selections <<< "debconf debconf/frontend select Noninteractive"

debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_ROOT_PW"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PW"
debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password password $MYSQL_ROOT_PW"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $MYSQL_ROOT_PW"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $MYSQL_ROOT_PW"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $MYSQL_ROOT_PW"
debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"

do_apt_install -y mysql-server
/usr/bin/mysqld_safe &		# doesn't start because of rc policy, but this fixes it

# Install phpmyadmin.  Actual setup occurs at first boot, since it depends on what user we run the container
# as.
do_apt_install phpmyadmin php5-cli
php5enmod mcrypt

# Commonly used php stuff
do_apt_install php-pear

# Properly shut down MySQL
mysqladmin -u root --password=$MYSQL_ROOT_PW shutdown

# Clean up apt
apt-get clean
/setup-lamp/apt_setproxy off
rm -rf /var/lib/apt/lists/*
rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup

# Do other cleanups
rm -r /setup-lamp
rm -rf /tmp/* /var/tmp/*
rm -f `find /apps -name '*~'`
echo done.
