#!/bin/bash
# System-prep tasks for nginx

puser=${USER:-www-data}

function dolog() { logger -t mysql.sh -p info $*; }

if [ $CONTAINER_INIT == 1 ]; then
  dolog setting nginx user permissions for "$puser"
  # Ngnix simply refuses to start unless it can write to /var/log/nginx.  Nobody seems to complain,
  # but i think this is because people don't try running nginx in userspace very often.
  sudo bash -c "mv /var/log/nginx /var/log/nginx-dist; mkdir /var/log/nginx; chown -R $puser: /var/log/nginx; chmod 777 /var/log/nginx"
fi
