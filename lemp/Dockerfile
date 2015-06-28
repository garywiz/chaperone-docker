FROM chapdev/chaperone-baseimage:latest
#MAINTAINER Gary Wisniewski <garyw@blueseastech.com>

ADD setup/ /setup-lemp/
RUN /setup-lemp/install.sh

# Note underscore
ENV _PARENT_IMAGE="chapdev/chaperone-lemp"

EXPOSE 8080
EXPOSE 8443
