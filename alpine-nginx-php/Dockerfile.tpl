FROM chapdev/chaperone-alpinebase:latest
#MAINTAINER Gary Wisniewski <garyw@blueseastech.com>

ADD setup/ /setup-np/
RUN /setup-np/install.sh

EXPOSE 8080 8443
