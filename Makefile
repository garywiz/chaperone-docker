NAME = garywiz/chaperone-baseimage
VERSION = 0.1.5.0		# C.C.C.X where C.C.C is chaperone version used in this release
TARGET =

.PHONY: all build-baseimage build-lamp

all: build-lamp

rebuild:
	(make TARGET=rebuild all)

build-baseimage:
	(cd baseimage; make $(TARGET))

build-lamp: build-baseimage
	(cd lamp; make $(TARGET))
