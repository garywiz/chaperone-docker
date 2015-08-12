# Bash start-up file, created by chaplocal

export PROMPT_DIRTRIM=2
cd $APPS_DIR

echo ""
echo "Now running inside container. Directory is: $APPS_DIR"
echo ""

port=${CONFIG_EXT_HTTP_PORT:-${CONFIG_EXT_PORT:-}}
if [ "$port" != "" -a "$HTTPD_SERVER_NAME" != "" ]; then
  echo "The default '$HTTPD_SERVER_NAME' site is running at http://$CONFIG_EXT_HOSTNAME:$port/"
  echo ""
fi
