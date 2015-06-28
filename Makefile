.PHONY: all build-baseimage build-lamp build-lemp

all: build-baseimage build-lamp build-lemp

rebuild:
	(make TARGET=rebuild all)

build-baseimage:
	(cd baseimage; make $(TARGET))

build-lamp: build-baseimage
	(cd lamp; make $(TARGET))

build-lemp: build-baseimage
	(cd lemp; make $(TARGET))

clean:
	(cd baseimage; make clean)
	(cd lamp; make clean)
	rm -rf `find . -name '*~'`
