FROM ruby:2.3.3

# Drop EOL repositories
RUN sed -i '/jessie-updates/d' /etc/apt/sources.list

RUN \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y \
    apt-transport-https \
    ca-certificates \
    cmake \
    curl \
    gnupg2 \
    liblwgeom-2.1.4 \
    nodejs \
    postgresql-9.4 \
    postgresql-9.4-plv8 \
    postgresql-9.4-postgis-2.1 \
    postgresql-client-9.4 \
    software-properties-common \
    nano \
    sudo && \
  wget -O phantomjs-2.1.1-linux-x86_64.tar.bz2 "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2" && \
  tar -xvf phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
  cd phantomjs-2.1.1-linux-x86_64/bin && \
  ln -s `pwd`/phantomjs /usr/local/bin/phantomjs && \
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
