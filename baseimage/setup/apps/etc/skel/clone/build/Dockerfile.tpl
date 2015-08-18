FROM %(PARENT_IMAGE)
ADD . /setup/
#Used to specify the default chaplocal image
#ENV _PARENT_IMAGE="%(PARENT_IMAGE)"
RUN /setup/build/install.sh
