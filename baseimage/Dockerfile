FROM ubuntu:14.04
#MAINTAINER Gary Wisniewski <garyw@blueseastech.com>

ADD setup/ /setup-baseimage/
RUN /setup-baseimage/install.sh

# Environment Variables

# _CHAP_OPTIONS - Used instead entrypoint args so that any default can be overridden by CMD
ENV _CHAP_OPTIONS="--config apps/chaperone.d --default-home / --user runapps"

ENTRYPOINT ["/usr/local/bin/chaperone"]
