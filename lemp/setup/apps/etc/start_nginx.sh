#!/bin/bash
# Startup nginx
#
# Note that all of the .tpl files are copied to locations in ${APPS_DIR}/var
# since nginx does not consistently support environment variables within configs.

mkdir -p ${APPS_DIR}/var/etc ${APPS_DIR}/var/sites.d ${APPS_DIR}/var/log/nginx

envcp --overwrite --strip .tpl ${APPS_DIR}/etc/*.tpl ${APPS_DIR}/var/etc
envcp --overwrite --strip .tpl ${APPS_DIR}/www/sites.d/*.tpl ${APPS_DIR}/var/sites.d

/usr/sbin/nginx -c ${APPS_DIR}/var/etc/nginx.conf
