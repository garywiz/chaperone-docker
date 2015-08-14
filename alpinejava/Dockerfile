FROM chapdev/chaperone-alpinebase:latest
#MAINTAINER Gary Wisniewski <garyw@blueseastech.com>

ADD setup/ /setup-alpinejava/
RUN /setup-alpinejava/install.sh

# Note underscore
ENV _PARENT_IMAGE="chapdev/chaperone-alpinejava"

ENTRYPOINT ["/usr/local/bin/chaperone"]
