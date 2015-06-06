NAME = garywiz/chaperone-baseimage
VERSION = 0.1.5.0		# C.C.C.X where C.C.C is chaperone version used in this release

.PHONY: all build binaries

all: build

build:   binaries
	$(DOCKER_BUILD)

rebuild: binaries
	$(DOCKER_REBUILD)
	docker build -t $(NAME):$(VERSION) --no-cache=true --rm image
	docker tag -f $(NAME):$(VERSION) $(NAME):latest

binaries: setup/bin/setproctitle-install.tar.gz

setup/bin/setproctitle-install.tar.gz:
	./setup/create-binaries.sh	
