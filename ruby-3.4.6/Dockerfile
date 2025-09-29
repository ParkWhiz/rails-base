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

# We need a newer version of postgress
RUN curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc| gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg && \
  echo $(lsb_release -cs) && \
  sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && \
  apt update && \
  apt install -y --no-install-recommends
