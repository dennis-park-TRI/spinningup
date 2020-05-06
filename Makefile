REPO_NAME = spinningup
WORKSPACE = /workspace/$(REPO_NAME)
DOCKER_IMAGE = $(REPO_NAME):latest

DOCKER_OPTS = \
	-it \
	--rm \
	-e DISPLAY=${DISPLAY} \
	-v /data:/data \
	-v /tmp:/tmp \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	--shm-size=1G \
	--network=host \
	--privileged \

DOCKER_BUILD_ARGS = \
	--build-arg WORKSPACE=$(WORKSPACE)

docker-build:
	nvidia-docker build \
	$(DOCKER_BUILD_ARGS) \
	-f ./Dockerfile \
	-t $(DOCKER_IMAGE) .

docker-dev:
	nvidia-docker run --name $(REPO_NAME) \
	$(DOCKER_OPTS) \
 	-e NVIDIA_DRIVER_CAPABILITIES=all \
	-v $(PWD):$(WORKSPACE) \
	$(DOCKER_IMAGE) bash

clean:
	find . -name "*.pyc" | sudo xargs rm -f && \
	find . -name "__pycache__" | sudo xargs rm -rf
	sudo rm -rf build/ *.egg-info/ **/*.so
