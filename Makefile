.PHONY: all build-baseimage build-lamp

all: build-lamp

rebuild:
	(make TARGET=rebuild all)

build-baseimage:
	(cd baseimage; make $(TARGET))

build-lamp: build-baseimage
	(cd lamp; make $(TARGET))
