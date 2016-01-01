include include/version.inc

# targets1 are all prefixed with the namespace/chaperone-
targets1=baseimage apache lamp lemp alpinebase alpinejava centosbase

# targets2 are just prefixed with namespace/
targets2=alpine-nginx-php alpine-nginx-django

TARGETS=$(targets1) $(targets2)
DHREPOS=$(foreach name,$(targets1),$(IMAGE_NAMESPACE)/chaperone-$(name)) \
	$(foreach name,$(targets2),$(IMAGE_NAMESPACE)/$(name))

SHELL=/bin/bash

.PHONY: all build rebuild clean push push-only test

all build rebuild test:
	for sf in $(TARGETS); do (cd $$sf; $(MAKE) $@) || break; done

clean:
	for sf in $(TARGETS); do (cd $$sf; $(MAKE) $@) || break; done
	rm -rf `find . -name '*~'` `find . -name '_temp_' -type d` test_logs

push:   test
	for sf in $(DHREPOS); do docker push $$sf; done

push-only:
	for sf in $(DHREPOS); do docker push $$sf; done
