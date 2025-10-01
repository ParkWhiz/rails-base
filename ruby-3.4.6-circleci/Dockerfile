FROM parkwhiz/rails-base:ruby-3.4.6_20250930095710
LABEL org.opencontainers.image.authors="ParkWhiz <dev@parkwhiz.com>"

WORKDIR /

# ---------------------
# -- Installing Docker.
# ---------------------

# https://docs.docker.com/engine/install/debian/
RUN \
  curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
  apt-get update && \
  apt-get install -y --no-install-recommends postgresql-client-17 docker-ce docker-ce-cli cmake containerd.io wget && \
  rm -rf /var/lib/apt/lists/*

RUN \
  export PHANTOM_JS="phantomjs-2.1.1-linux-x86_64" && \
  wget https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_JS.tar.bz2 &&\
  tar xvjf $PHANTOM_JS.tar.bz2 && \
  mv $PHANTOM_JS /usr/local/share && \
  ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin && \
  chmod +x /usr/local/bin/phantomjs
