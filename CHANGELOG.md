## 1.0.7 (2015-08-21)

Improvements:

- Improved derivative build methdology so that the `./build.sh` script automatically assures the derivative image has all the capabilities of the parent image, tweaking all references in templates to point to the new derivative.  Much nicer and simpler.
- Added a lean and mean `alpinejava` image that has the full Oracle JDK installed with Python 3 as well.  So much smaller than equivalent images.

Bug Fixes:

- Alpine-based images did not start `startup.d` scripts in lexicographic order.  Fixed.
- PID files were moved into `/tmp` to eliminate some permission errors with some attached storage scenarios.

## 1.0.6 (2015-08-11)

Bug Fixes:

- Changed chaplocal and run.sh templates to support the file permissions weirdness
  present on OSX ([#1, @bitsofalex](https://github.com/garywiz/chaperone-docker/issues/1))
- chaplocal home directories may now be in /home or /Users and removed any container-specific
  dependence on where the entire app hierarchy is located.

Other changes:

- Updated to newest chaperone which adds support for --create-user name:/path so that user
  identity can be based upon the permissions set for a given path.
- Changed the names of some environment variables in apps scripts to be more compatible
  with the OSX environment, including using the default 'localhost' as the external
  hostname instead of 'hostname -s'
