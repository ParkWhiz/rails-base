FROM ruby:3.1.2-buster
LABEL org.opencontainers.image.authors="ParkWhiz <dev@parkwhiz.com>"

WORKDIR /

# ------------------------------
# -- Installing common packages.
# ------------------------------

RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends \
  autoconf bison curl git ruby-dev build-essential \
  libpcre3-dev file imagemagick nginx nodejs postgresql \
  postgresql-client default-mysql-server libreadline6-dev \
  libpq-dev pkg-config bzip2 ca-certificates libffi-dev \
  libgmp-dev libssl-dev libyaml-dev procps zlib1g-dev \
  apache2 dirmngr gnupg vim && \
  rm -rf /var/lib/apt/lists/*
