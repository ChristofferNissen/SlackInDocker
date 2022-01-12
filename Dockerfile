FROM debian:latest
LABEL author=stifstof

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -qy \
  curl \
  ca-certificates \
  sudo \
  libxkbfile1 \
  gvfs-bin \
  libglib2.0-bin \
  trash-cli \
  kde-cli-tools \
  libatspi2.0-0 \
  xdg-utils \
  libxtst6 \
  libxss1 \
  libnss3 \ 
  libnotify4 \ 
  git \
  libayatana-appindicator3-1 \
  libgtk-3-0 \
  libpci-dev \
  firefox-esr \
  wget \
  libgl1 \
  mesa-utils \
  libgl1-mesa-glx

# Grab the slack client .deb
# ARG SLACK_URL=https://downloads.slack-edge.com/linux_releases/slack-desktop-4.23.0-amd64.deb
# RUN curl -sSL $SLACK_URL -o /tmp/slack.deb
COPY scripts/slack-desktop-4.23.0-amd64.deb /tmp/slack.deb

# Install the client .deb (Script modifies broken Dependency in Debian 11)
COPY scripts/install_slack.sh .
RUN ./install_slack.sh /tmp/slack.deb
COPY scripts/ /var/cache/slack-desktop/
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

# Cleanup
RUN rm /tmp/slack.deb \
  && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/sbin/entrypoint.sh"]