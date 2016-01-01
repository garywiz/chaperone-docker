#!/bin/bash

[ $VAR_INIT != 1 ] && exit

# Only do the following if the VAR directory is being set up

cd $APPS_DIR/www/django_sample
./manage.py migrate

# Create superuser with username=admin and password=ChangeMe
./manage.py createsuperuser --username=admin --email=admin@example.com --noinput
./manage.py shell <<EOF
from django.contrib.auth.models import User
u = User.objects.get(username__exact='admin')
u.set_password('ChangeMe')
u.save()
EOF
