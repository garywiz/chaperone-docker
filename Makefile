.PHONY: all build-baseimage build-lamp build-lemp build-apache

all: build-baseimage build-lamp build-lemp build-apache

rebuild:
	(make TARGET=rebuild all)

build-baseimage:
	(cd baseimage; make $(TARGET))

build-lamp: build-baseimage
	(cd lamp; make $(TARGET))

build-lemp: build-baseimage
	(cd lemp; make $(TARGET))

build-apache: build-baseimage
	(cd apache; make $(TARGET))

clean:
	(cd baseimage; make clean)
	(cd lamp; make clean)
	rm -rf `find . -name '*~'`
