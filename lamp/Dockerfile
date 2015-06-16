FROM chapdev/chaperone-baseimage:latest
#MAINTAINER Gary Wisniewski <garyw@blueseastech.com>

ADD setup/ /setup-lamp/
RUN /setup-lamp/install.sh

# Note underscore
ENV _PARENT_IMAGE="chapdev/chaperone-lamp"

EXPOSE 8080
