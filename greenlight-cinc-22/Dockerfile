FROM ruby:latest
MAINTAINER ParkWhiz <dev@parkwhiz.com>

WORKDIR /

# -------------------
# -- Installing CINC.
# -------------------

RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends lsb-release && \
  curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
  apt-get install -y --no-install-recommends awscli jq

RUN \
  curl -L https://omnitruck.cinc.sh/install.sh | bash -s -- -P cinc-workstation -v 22
