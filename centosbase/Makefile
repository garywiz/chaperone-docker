BASENAME = chaperone-centosbase

include ../include/make.inc

.PHONY: binaries

build: binaries

rebuild: binaries

binaries: setup/lib/setproctitle-install.tar.gz

setup/lib/setproctitle-install.tar.gz:
	./setup/create-binaries.sh	

clean:
	rm -rf ./setup/lib
	rm -rf `find . -name '*~'`
