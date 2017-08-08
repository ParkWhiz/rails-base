FROM ruby:2.3.4-alpine3.4
MAINTAINER ParkWhiz <dev@parkwhiz.com>

ENV BUILD_PACKAGES autoconf bison build-base curl git libc-dev libstdc++ openssl-dev pcre pcre-dev postgresql-dev procps ruby-dev wget
ENV RUBY_PACKAGES ca-certificates curl-dev file imagemagick libxml2-dev libxslt-dev linux-headers mysql-dev nodejs postgresql-client procps readline-dev ruby-rake tzdata

RUN \
  apk update && \
  apk upgrade && \
  apk add bash && \
  apk add --virtual build-dependencies $BUILD_PACKAGES && \
  apk add --virtual ruby-dependencies $RUBY_PACKAGES && \
  gem install nokogiri -v 1.6.7 --no-rdoc --no-ri --no-doc -- --use-system-libraries && \
  gem install rb-readline --no-rdoc --no-ri --no-doc && \
  gem install json -v 1.8.3 --no-rdoc --no-ri --no-doc && \
  rm -rf /var/cache/apk/*
