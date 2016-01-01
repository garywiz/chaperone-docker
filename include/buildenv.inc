# Build environment variables, linked from each setup directory.

BUILD_CHAPERONE_INSTALL="pip3 install chaperone"

# Use to build images with a custom version of Chaperone, usually for pre-release testing purposes.  This loads
# chaperone from a webserver running in another container, usually the chaperone/sandbox/distserv server, but
# can access the source distribution from anywhere.
#BUILD_CHAPERONE_INSTALL="pip3 install http://`ip route | awk '/default via/{print $3}'`:9980/dist/chaperone-0.3.4.tar.gz"
