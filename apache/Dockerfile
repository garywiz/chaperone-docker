FROM chapdev/chaperone-baseimage:latest
#MAINTAINER Gary Wisniewski <garyw@blueseastech.com>

ADD setup/ /setup-apache/
RUN /setup-apache/install.sh

# Note underscore
ENV _PARENT_IMAGE="chapdev/chaperone-apache"

EXPOSE 8080
