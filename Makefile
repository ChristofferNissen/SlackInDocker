launch:
	slack-wrapper slack

kill-container:
	podman kill slack

build:
	podman build . -t docker.io/stifstof/slack:latest

install:
	podman run -it --rm \
	--volume ./bin:/target \
	docker.io/stifstof/slack:latest install

uninstall:
	podman run -it --rm \
	--volume ./bin:/target \
	docker.io/stifstof/slack:latest uninstall

push:
	podman push docker.io/stifstof/slack:latest

# convenience jobs

reinstall:
	make uninstall
	make build
	make install

add-to-path:
	export PATH=$PATH:~/Documents/git/docker-slack-desktop/bin