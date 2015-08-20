
The %(DEFAULT_LAUNCHER) script is a quick-start for launching
containers from the %(PARENT_IMAGE) image.

To get this message again:
   docker run -i --rm %(PARENT_IMAGE) --task get-help LAUNCHER

Or, for geeneral help on the image itself:
   docker run -i --rm %(PARENT_IMAGE) --task get-help
