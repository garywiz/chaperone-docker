## 1.0.6 (2015-08-11)

Bug fixes:

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
