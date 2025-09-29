FROM ruby:3.4.6-trixie
LABEL org.opencontainers.image.authors="ParkWhiz <dev@parkwhiz.com>"

WORKDIR /

# ------------------------------
# -- Installing common packages.
# ------------------------------

RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends autoconf bison curl git ruby-dev build-essential file imagemagick nginx nodejs default-mysql-server libreadline6-dev libpq-dev pkg-config bzip2 ca-certificates libffi-dev libgmp-dev libssl-dev libyaml-dev procps zlib1g-dev apache2 dirmngr gnupg vim libjemalloc2 gnupg2 lsb-release libgit2-dev && \
  rm -rf /var/lib/apt/lists/*
