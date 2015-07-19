#!/bin/bash

puser=${USER:-www-data}

function dolog() { logger -t phpmyadmin.sh -p info $*; }

if [ $CONTAINER_INIT == 1 ]; then
  dolog setting phpmyadmin user permissions for "$puser"
  sudo bash -c "chown -R $puser: /var/lib/phpmyadmin/tmp; chgrp --reference /var/lib/phpmyadmin/tmp /var/lib/phpmyadmin/*.php"
  sudo bash -c "chgrp --reference /var/lib/phpmyadmin/tmp \`find /etc/phpmyadmin -group www-data\`"
fi
