include ../include/make.inc

IMAGE_NAME = chaperone-baseimage

.PHONY: all build binaries

all: build

build:   binaries
	$(DOCKER_BUILD)

rebuild: binaries
	$(DOCKER_REBUILD)

binaries: setup/lib/setproctitle-install.tar.gz

setup/lib/setproctitle-install.tar.gz:
	./setup/create-binaries.sh	

clean:
	rm -rf ./setup/lib
	rm -rf `find . -name '*~'`
