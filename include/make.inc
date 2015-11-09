this_file := $(abspath $(lastword $(MAKEFILE_LIST)))
export TOPLEV_DIR := $(subst /include/make.inc,,$(this_file))

# Note that version.inc must be generic and compatible with both shells and Makefiles,
# so it contains nothing fancy.
include $(TOPLEV_DIR)/include/version.inc

FULLNAME = $(IMAGE_NAMESPACE)/$(BASENAME)
VERSION = $(IMAGE_VERSION)-$(IMAGE_ARCH)

this_file := $(abspath $(lastword $(MAKEFILE_LIST)))
PATH := $(TOPLEV_DIR)/bin:$(PATH)

DOCKER_BUILD=\
     echo "IMAGE_NAME=$(FULLNAME)" | cat $(TOPLEV_DIR)/include/version.inc - >setup/this_version.inc; \
     [ -f Dockerfile.tpl ] && sed "s|FROM chapdev/|FROM $(IMAGE_NAMESPACE)/|" <Dockerfile.tpl >Dockerfile; \
     tar czh . | docker build -t $(FULLNAME):$(VERSION) --rm -; docker tag -f $(FULLNAME):$(VERSION) $(FULLNAME):latest; \
     rm setup/this_version.inc; \
     [ -f Dockerfile.tpl ] && rm Dockerfile
DOCKER_REBUILD=\
     echo "IMAGE_NAME=$(FULLNAME)" | cat $(TOPLEV_DIR)/include/version.inc - >setup/this_version.inc; \
     [ -f Dockerfile.tpl ] && sed "s|FROM chapdev/|FROM $(IMAGE_NAMESPACE)/|" <Dockerfile.tpl >Dockerfile; \
     tar czh . | docker build -t $(FULLNAME):$(VERSION) --no-cache=true --rm -; docker tag -f $(FULLNAME):$(VERSION) $(FULLNAME):latest; \
     rm setup/this_version.inc; \
     [ -f Dockerfile.tpl ] && rm Dockerfile

RUN_TESTS=test-driver tests $(IMAGE_NAMESPACE) $(BASENAME) $(TOPLEV_DIR)/test_logs

.PHONY: all build test

all: build

build:
	$(DOCKER_BUILD)

rebuild:
	$(DOCKER_REBUILD)

test:
	$(RUN_TESTS)
