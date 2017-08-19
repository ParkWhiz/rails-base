FROM ruby:2.3.3

RUN \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    liblwgeom-2.1.4 \
    postgresql-9.4 \
    postgresql-9.4-plv8 \
    postgresql-9.4-postgis-2.1 \
    postgresql-client-9.4 \
    redis-server \
    software-properties-common \
    sudo && \
  curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
  add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable" && \
  apt-get update && \
  apt-get install -y docker-ce && \
  service postgresql start && \
  sudo -u postgres createuser -d -s root && \
  service postgresql stop && \
  rm -rf /var/lib/apt/lists/*

CMD /bin/bash
