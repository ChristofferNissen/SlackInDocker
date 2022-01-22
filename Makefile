launch:
	slack-wrapper slack

kill-container:
	podman kill slack

build:
	podman build -t docker.io/stifstof/slack:latest .

build-no-cache:
	podman build --no-cache -t docker.io/stifstof/slack:latest .

install:
	podman run -it --rm \
	--volume ./bin:/target \
	docker.io/stifstof/slack:latest install

uninstall:
	podman run -it --rm \
	--volume ./bin:/target \
	docker.io/stifstof/slack:latest uninstall

# convenience jobs

push:
	echo ${DOCKERHUB_STIFSTOF_PW} | podman login docker.io -u stifstof --password-stdin
	podman push docker.io/stifstof/slack:latest

reinstall:
	make uninstall
	make build
	make install

create-empty-config-folders:
	mkdir ~/.config/Slack

add-to-path:
	export PATH=$PATH:/home/cn/Documents/git/docker-slack-desktop/bin
