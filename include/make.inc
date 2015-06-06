DOCKER_BUILD=docker build -t $(NAME):$(VERSION) --rm image; docker tag -f $(NAME):$(VERSION) $(NAME):latest
DOCKER_REBUILD=docker build -t $(NAME):$(VERSION) --no-cache=true --rm image; docker tag -f $(NAME):$(VERSION) $(NAME):latest
