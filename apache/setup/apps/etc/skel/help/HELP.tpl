Help for Image: %(PARENT_IMAGE) Version %(IMAGE_VERSION) 
     Chaperone: %(`chaperone --version | awk '/This is/{print $5}'`)
         Linux: %(`cat /etc/issue | head -1 | sed -e 's/Welcome to //' -e 's/ \\.*$//'`)

This image contains a minimally-configured Apache server as a starting
point.

When you launch the container, there will be a default sample site
visible at http://%(CONFIG_EXT_HOSTNAME)%(CONFIG_EXT_HTTP_PORT:|80||:%(CONFIG_EXT_HTTP_PORT))/
(Assuming you haven't changed the default port.)

If you are a developer, the best way to learn about this image is to create a 
local development directory.  You can do this automatically using the
'chaplocal' command, which will guide you to the next step:

  $ docker run -i --rm %(PARENT_IMAGE) --task get-chaplocal | sh

You can extract also ready-made startup scripts for this image by running
the following command:

  $ docker run -i --rm %(PARENT_IMAGE) --task get-launcher | sh

Startup scripts have the option of working with attached storage.
Each script is self-documenting and has configuration variables
at the beginning of the script itself.
