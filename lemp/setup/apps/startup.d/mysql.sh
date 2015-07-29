#!/bin/bash

distdir=/var/lib/mysql
vardbdir=$VAR_DIR/mysql

function dolog() { logger -t mysql.sh -p info $*; }

if [ $CONTAINER_INIT == 1 ]; then
    dolog "hiding distribution mysql files in /etc so no clients see them"
    sudo bash -c "cd /etc; mv my.cnf my.cnf-dist; mv mysql mysql-dist; mv $distdir $distdir-dist" >&/dev/null
fi

if [ $VAR_INIT == 1 ]; then
    if [ ! -d $vardbdir ]; then
	dolog "copying distribution $distdir to $vardbdir"
	sudo bash -c "cp -a $distdir-dist $vardbdir; chown -R ${USER:-mysql} $vardbdir"
    else
	dolong "existing $vardbdir found when initializing $VAR_DIR for the first time, not changed."
    fi
fi
