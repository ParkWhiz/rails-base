FROM fluent/fluentd:v1.19-debian
MAINTAINER ParkWhiz <dev@parkwhiz.com>

WORKDIR /

USER root

RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends lsb-release jq curl

RUN fluent-gem install fluent-plugin-sampling-filter fluent-plugin-gelf-hs
