This directory contains a template for creating derivative images
based upon '%(PARENT_IMAGE)'.

Note that these build materials will NOT become a part of the newly created image.
Instead, new build materials will be created if somebody wants to use 'chaplocal'
to continue development.

To make a complete, ready-to-go image, you should do the following:

1.  Customize Dockerfile in the application root directory (our parent)

2.  Customize install.sh by adding any additional build commands.

3.  If you want to cater to developers who want to use this image, then
    modify the skeleton files in ../etc/skel as described below.

4.  Usually, you can just create a new .git project at in the same
    directory where your build.sh is located.

Modifying the Skelenton Files

The ../etc/skel directory contains skeleton template files which are used:
  * To output container-specific help using "--task get-help"
  * To create container-specific launchers using "--task get-launcher"
  * To create new development directories using 'chaplocal'.

At a minimum, you should modify: ../etc/skel/help and ../etc/skel/launcher
to reflect the needs of your container.

If you want to improve the experience for developers using your image, then
also modify the templates in ../etc/clone.  'chaplocal' uses these files when
it clones a new 'apps' directory for a developer.
