launch:
	slack-desktop-wrapper slack

kill-container:
	docker kill slack-desktop

build:
	docker build . -t stifstof/slack-desktop:latest

install:
	docker run -it --rm \
	--volume /usr/local/bin:/target \
	stifstof/slack-desktop:latest install

uninstall:
	docker run -it --rm \
	--volume /usr/local/bin:/target \
	stifstof/slack-desktop:latest uninstall

# convenience jobs

reinstall:
	make uninstall
	make build
	make install
