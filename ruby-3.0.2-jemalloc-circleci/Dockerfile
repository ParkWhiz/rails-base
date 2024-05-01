FROM parkwhiz/rails-base:3.0.2-circleci_20210813120627
MAINTAINER ParkWhiz <dev@parkwhiz.com>

# ------------------------------
# -- Installing jemalloc for apps to configure on their own.
# ------------------------------

RUN apt-get update && \
  apt-get install -y --no-install-recommends libjemalloc2 && \
  rm -rf /var/lib/apt/lists/*

