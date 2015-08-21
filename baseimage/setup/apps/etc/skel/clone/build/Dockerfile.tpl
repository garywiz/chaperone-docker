# This is a template Dockerfile for creating a new image.  
# See the README for a complete description of how you create derivative images.

FROM %(PARENT_IMAGE)
ADD . /setup/
RUN /setup/build/install.sh
