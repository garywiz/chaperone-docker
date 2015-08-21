BASENAME = chaperone-alpinebase

include ../include/make.inc

build:   binaries

rebuild: binaries

binaries: setup/lib/setproctitle-install.tar.gz

setup/lib/setproctitle-install.tar.gz:
	./setup/create-binaries.sh	

clean:
	rm -rf ./setup/lib
	rm -rf `find . -name '*~'`
