FROM chapdev/chaperone-baseimage:latest
#MAINTAINER Gary Wisniewski <garyw@blueseastech.com>

ADD setup/ /setup-nginx-mysql/
RUN /setup-nginx-mysql/install.sh

# Note underscore
ENV _PARENT_IMAGE="chapdev/chaperone-nginx-mysql"

EXPOSE 8080
EXPOSE 8443
