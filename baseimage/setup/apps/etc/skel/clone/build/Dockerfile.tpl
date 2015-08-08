FROM %(PARENT_IMAGE)
ADD . /setup/
#Used to specify the default chaplocal image
#ENV _PARENT_IMAGE="$IMAGE"
RUN /setup/build/install.sh
