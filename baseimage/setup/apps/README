This is a self-contained system directory managed by Chaperone.

Everything is here: configuration, log files, user data.

You can:

- Put this directory on a shared volume so you can do development (chaplocal does
  this for you if you want).
- Copy it back to /apps to create production instances.

The idea is to isolate all system configuration in a "mini-environment" here in
the apps directory rather than trying to cajole the many installed services in
the container to operate differently than they may be originally configured
by the distro.

So, for example, you'll find all your logs here in ./var/log.   The logging
strategy is up to you, but initially syslog and chaperone errors will be sent to
stdout, while other types of informational messages get stored in log files.
See 010-start.conf for the logging configuration.

All of this can be changed, and this environment is not dictated by chaperone.
It's just a starting point defined by chaperone-baseimage and chaperone-lamp
to get things started.
