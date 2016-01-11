Help for Image: %(PARENT_IMAGE) Version %(IMAGE_VERSION) 
     Chaperone: %(`chaperone --version | awk '/This is/{print $5}'`)
         Linux: %(`( cat /etc/system-release 2>/dev/null || cat /etc/issue ) | head -1 | sed -e 's/Welcome to //' -e 's/ \\.*$//'`)

This is a minimal Chaperone image to use as a starting-point
for creating Docker containers.  It contains basic configuration templates,
as well as a sane method of starting scripts and related services.

This image won't do much by itself, but a good way to see how it is
built is to try:

  $ docker run -i -t --rm %(PARENT_IMAGE) /bin/bash

The above will start the container and put you in a 'bash' shell so you
can look around.

The entire "world" of the application will be located in the /apps

Take a look at the configuration files in /apps/chaperone.d to see how
the system is configured for startup.  There is also a sample application
(just a simple shell script) with a sample start-up script '200-userapp.conf'.

You can extract ready-made startup scripts for this image by running
the following command:

  $ docker run -i --rm %(PARENT_IMAGE) --task get-launcher | sh

If you are a developer and want to create your own local development
directory with this image as the infrastructure provider, use:

  $ docker run -i --rm %(PARENT_IMAGE) --task get-chaplocal | sh
