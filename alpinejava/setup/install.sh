#!bin/sh

# Install Java requirements
apk add --update openjdk7-jre

# Copy new apps files into /apps
cp -av /setup-alpinejava/apps/* /apps
chown -R runapps: /apps

echo done.
