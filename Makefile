NAME = garywiz/chaperone-baseimage
VERSION = 0.1.5.0		# C.C.C.X where C.C.C is chaperone version used in this release

.PHONY: all build

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm image
