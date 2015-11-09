include include/version.inc

TARGETS=baseimage apache lamp lemp alpinebase alpinejava alpine-nginx-php centosbase
SHELL=/bin/bash

.PHONY: all build rebuild clean push push-only test

all build rebuild test:
	for sf in $(TARGETS); do (cd $$sf; $(MAKE) $@) || break; done

clean:
	for sf in $(TARGETS); do (cd $$sf; $(MAKE) $@) || break; done
	rm -rf `find . -name '*~'` `find . -name '_temp_' -type d` test_logs

push:   test
	for sf in $(TARGETS); do docker push $(IMAGE_NAMESPACE)/chaperone-$$sf; done

push-only:
	for sf in $(TARGETS); do docker push $(IMAGE_NAMESPACE)/chaperone-$$sf; done
