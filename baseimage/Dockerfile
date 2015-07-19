FROM ubuntu:14.04
#MAINTAINER Gary Wisniewski <garyw@blueseastech.com>

ADD setup/ /setup-baseimage/
RUN /setup-baseimage/install.sh

# Environment Variables

# _CHAP_OPTIONS - Used instead entrypoint args so that any default can be overridden by CMD
# _PARENT_IMAGE - Sometimes container service "helpers" may want to know what image they were
#                 built from.  (get-chaplocal is an example) 
#		  The _ prefix keeps these from polluting our environment.

ENV _CHAP_OPTIONS="--config apps/chaperone.d --default-home / --user runapps" _PARENT_IMAGE="chapdev/chaperone-baseimage"
ENTRYPOINT ["/usr/local/bin/chaperone"]
