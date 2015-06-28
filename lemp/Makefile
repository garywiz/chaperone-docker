include ../include/make.inc

IMAGE_NAME = chaperone-lemp

.PHONY: all build binaries

all: build

build:
	$(DOCKER_BUILD)

rebuild:
	$(DOCKER_REBUILD)

clean:
	rm -rf `find . -name '*~'`
