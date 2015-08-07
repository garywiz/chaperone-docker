#!/bin/bash
# Startup nginx
#
# Note that all of the .tpl files are copied to locations in ${VAR_DIR}
# since nginx does not consistently support environment variables within configs.

mkdir -p $VAR_DIR/etc $VAR_DIR/sites.d $VAR_DIR/log/nginx

tpl_envcp --overwrite --strip .tpl $APPS_DIR/etc/*.tpl $VAR_DIR/etc
tpl_envcp --overwrite --strip .tpl $APPS_DIR/www/sites.d/*.tpl $VAR_DIR/sites.d

/usr/sbin/nginx -c $VAR_DIR/etc/nginx.conf
