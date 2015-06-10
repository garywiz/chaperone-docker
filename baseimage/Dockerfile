FROM ubuntu:14.04
MAINTAINER Gary Wisniewski <garyw@blueseastech.com>

ADD setup/ /setup/
RUN /setup/install.sh

# We use the environment variable instead of entrypoint args so that any default can be overridden by CMD
ENV CHAP_OPTIONS --config apps/chaperone.d

ENTRYPOINT ["/usr/local/bin/chaperone"]
