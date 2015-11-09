FROM chapdev/chaperone-alpinebase:latest
#MAINTAINER Gary Wisniewski <garyw@blueseastech.com>

ADD setup/ /setup-alpinejava/
RUN /setup-alpinejava/install.sh

ENTRYPOINT ["/usr/local/bin/chaperone"]
