include .env

launch:
	slack-wrapper slack

kill-container:
	${CONTAINER_ENGINE} kill slack

build:
	${CONTAINER_ENGINE} build -t docker.io/stifstof/slack:latest -f Containerfile .

build-no-cache:
	${CONTAINER_ENGINE} build --no-cache -t docker.io/stifstof/slack:latest -f Containerfile .

install:
	${CONTAINER_ENGINE} run -it --rm \
	--volume ${PWD}/bin:/target \
	docker.io/stifstof/slack:latest install

uninstall:
	${CONTAINER_ENGINE} run -it --rm \
	--volume ${PWD}/bin:/target \
	docker.io/stifstof/slack:latest uninstall

# convenience jobs

push:
	echo ${DOCKERHUB_STIFSTOF_PW} | ${CONTAINER_ENGINE} login docker.io -u stifstof --password-stdin
	${CONTAINER_ENGINE} push docker.io/stifstof/slack:latest

reinstall:
	make uninstall
	make build
	make install

create-empty-config-folders:
	mkdir ~/.config/Slack

# system setup

add-to-path:
	export PATH=$PATH:/home/cn/Documents/git/docker-slack-desktop/bin

podman_runtime:
	rm -f .env
	echo "CONTAINER_ENGINE=podman" >> .env

docker_runtime:
	rm -f .env
	echo "CONTAINER_ENGINE=docker" >> .env

current_runtime:
	cat .env
