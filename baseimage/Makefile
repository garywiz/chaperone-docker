include ../include/make.inc

IMAGE_NAME = chaperone-baseimage

.PHONY: binaries

build: binaries

rebuild: binaries

binaries: setup/lib/setproctitle-install.tar.gz

setup/lib/setproctitle-install.tar.gz:
	./setup/create-binaries.sh	

clean:
	rm -rf ./setup/lib
	rm -rf `find . -name '*~'`
