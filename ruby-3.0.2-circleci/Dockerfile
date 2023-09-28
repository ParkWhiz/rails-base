FROM parkwhiz/rails-base:3.0.2_20210812134927
MAINTAINER ParkWhiz <dev@parkwhiz.com>

WORKDIR /


# ---------------------
# -- Installing Docker.
# ---------------------

# https://docs.docker.com/engine/install/debian/
RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends lsb-release jq && \
  curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
  apt-get update && \
  apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io && \
  rm -rf /var/lib/apt/lists/*

RUN \
  export PHANTOM_JS="phantomjs-2.1.1-linux-x86_64" && \
  wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2 &&\
  tar xvjf $PHANTOM_JS.tar.bz2 && \
  mv $PHANTOM_JS /usr/local/share && \
  ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin && \
  chmod +x /usr/local/bin/phantomjs
