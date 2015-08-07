# Variables commonly defined in get-* tasks, so that they can be
# available in templates.  See bin/get-help and bin/get-launcher.

source $APPS_DIR/etc/version.inc
export IMAGE_VERSION IMAGE_ARCH

# The image name, without the prefix.
export IMAGE_BASENAME=${PARENT_IMAGE/*chapdev\/chaperone-/}

# The name of the default launcher (this is what run-IMAGE.sh.tpl gets delivered as)
export DEFAULT_LAUNCHER=run-$IMAGE_BASENAME.sh

# Used by get-launcher turn .tpl pathnames into the basename delivered.

function transform_filename() { 
  base=$(basename $1)
  [ "$base" == "run-IMAGE.sh.tpl" ] && echo $DEFAULT_LAUNCHER && return
  echo "${base%.tpl}"
}
