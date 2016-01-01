
The %(DEFAULT_LAUNCHER) script is a quick-start for launching
the %(PARENT_IMAGE) image.

When you launch the container, there will be a default Django sample site
visible at http://%(CONFIG_EXT_HOSTNAME)%(CONFIG_EXT_HTTP_PORT:|80||:%(CONFIG_EXT_HTTP_PORT))/

To get this message again:
   docker run -i --rm %(PARENT_IMAGE) --task get-help LAUNCHER

Or, for geeneral help on the image itself:
   docker run -i --rm %(PARENT_IMAGE) --task get-help
