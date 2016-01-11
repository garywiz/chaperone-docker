BASENAME = nginx-django

include ../include/make.inc

.PHONY: binaries

build: binaries

rebuild: binaries

binaries: setup/lib/uwsgi-install.tar.gz

setup/lib/uwsgi-install.tar.gz:
	./setup/create-binaries.sh	

clean:
	rm -rf ./setup/lib
	rm -rf `find . -name '*~' -o -name '__pycache__'`
