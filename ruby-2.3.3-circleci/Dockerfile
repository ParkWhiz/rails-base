FROM ruby:2.3.3

RUN \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y \
    liblwgeom-2.1.4 \
    postgresql-9.4 \
    postgresql-9.4-plv8 \
    postgresql-9.4-postgis-2.1 \
    postgresql-client-9.4 \
    redis-server \
    sudo && \
  service postgresql start && \
  sudo -u postgres createuser -d -s root && \
  service postgresql stop && \
  rm -rf /var/lib/apt/lists/*

CMD /bin/bash
