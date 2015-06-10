IMAGE_NAMESPACE=chapdev
IMAGE_VERSION=1.0-U14		# image version 

DOCKER_BUILD=docker build -t $(NAME):$(VERSION) --rm .; docker tag -f $(NAME):$(VERSION) $(NAME):latest
DOCKER_REBUILD=docker build -t $(NAME):$(VERSION) --no-cache=true --rm .; docker tag -f $(NAME):$(VERSION) $(NAME):latest
