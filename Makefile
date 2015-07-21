.PHONY: all build-baseimage build-lamp build-lemp build-apache build-alpinebase rebuild clean push

all: build-baseimage build-lamp build-lemp build-apache build-alpinebase

rebuild:
	(make TARGET=rebuild all)

build-baseimage:
	(cd baseimage; make $(TARGET))

build-lamp: build-baseimage
	(cd lamp; make $(TARGET))

build-lemp: build-baseimage
	(cd lemp; make $(TARGET))

build-apache: build-baseimage
	(cd apache; make $(TARGET))

build-alpinebase: build-alpinebase
	(cd alpinebase; make $(TARGET))

clean:
	(cd baseimage; make clean)
	(cd lamp; make clean)
	rm -rf `find . -name '*~'`

push:
	docker push chapdev/chaperone-baseimage
	docker push chapdev/chaperone-apache
	docker push chapdev/chaperone-lamp
	docker push chapdev/chaperone-lemp
	docker push chapdev/chaperone-alpinebase
