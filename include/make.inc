this_file := $(abspath $(lastword $(MAKEFILE_LIST)))
export TOPLEV_DIR := $(subst /include/make.inc,,$(this_file))

# Note that version.inc must be generic and compatible with both shells and Makefiles,
# so it contains nothing fancy.
include $(TOPLEV_DIR)/include/version.inc

NAME = $(IMAGE_NAMESPACE)/$(IMAGE_NAME)
VERSION = $(IMAGE_VERSION)-$(IMAGE_ARCH)

this_file := $(abspath $(lastword $(MAKEFILE_LIST)))
PATH := $(TOPLEV_DIR)/bin:$(PATH)

DOCKER_BUILD=tar czh . | docker build -t $(NAME):$(VERSION) --rm -; docker tag -f $(NAME):$(VERSION) $(NAME):latest
DOCKER_REBUILD=tar czh . | docker build -t $(NAME):$(VERSION) --no-cache=true --rm -; docker tag -f $(NAME):$(VERSION) $(NAME):latest

RUN_TESTS=test-driver tests $(IMAGE_NAME) $(TOPLEV_DIR)/test_logs

.PHONY: all build test

all: build

build:
	$(DOCKER_BUILD)

rebuild:
	$(DOCKER_REBUILD)

test:
	$(RUN_TESTS)
