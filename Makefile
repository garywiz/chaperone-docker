TARGETS=baseimage apache lamp lemp alpinebase
SHELL=/bin/bash

.PHONY: all build rebuild clean push

all build rebuild test:
	for sf in $(TARGETS); do (cd $$sf; $(MAKE) $@) || break; done

clean:
	for sf in $(TARGETS); do (cd $$sf; $(MAKE) $@) || break; done
	rm -rf `find . -name '*~'` test_logs

push:   test
	for sf in $(TARGETS); do echo docker push chapdev/chaperone-$$sf; done
