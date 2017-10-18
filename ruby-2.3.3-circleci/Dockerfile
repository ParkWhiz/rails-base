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
    nodejs \
    postgresql-9.4 \
    postgresql-9.4-plv8 \
    postgresql-9.4-postgis-2.1 \
    postgresql-client-9.4 \
    software-properties-common \
    nano \
    sudo && \
  wget -O phantomjs-2.1.1-linux-x86_64.tar.bz2 "https://bbuseruploads.s3.amazonaws.com/fd96ed93-2b32-46a7-9d2b-ecbc0988516a/downloads/396e7977-71fd-4592-8723-495ca4cfa7cc/phantomjs-2.1.1-linux-x86_64.tar.bz2?Signature=%2Bgz4y5Xpi5%2F2l%2BKWTKH5YCLGILU%3D&Expires=1508283133&AWSAccessKeyId=AKIAIQWXW6WLXMB5QZAQ&versionId=null&response-content-disposition=attachment%3B%20filename%3D%22phantomjs-2.1.1-linux-x86_64.tar.bz2%22" && \
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
