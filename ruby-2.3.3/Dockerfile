FROM alpine:3.4
MAINTAINER ParkWhiz <dev@parkwhiz.com>

ENV BUILD_PACKAGES autoconf bison build-base curl git libc-dev libstdc++ openssl-dev pcre pcre-dev postgresql-dev procps ruby-dev wget
ENV BUNDLER_VERSION 1.13.6
ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_APP_CONFIG $GEM_HOME
ENV PASSENGER passenger-5.0.30
ENV RUBY_PACKAGES ca-certificates curl-dev libxml2-dev libxslt-dev linux-headers nginx nodejs postgresql-client procps readline-dev ruby-rake tzdata
ENV RUBY_VERSION 2.3.3
ENV RUBYGEMS_VERSION 2.6.8

ENV PATH "$GEM_HOME/bin:/passenger/bin:$PATH"

RUN \
  apk update && \
  apk upgrade && \
  apk add bash && \
  apk add --virtual build-dependencies $BUILD_PACKAGES && \
  apk add --virtual ruby-packages $RUBY_PACKAGES && \
  mkdir -p /usr/src/ruby && \
  curl -fSL -o ruby.tar.gz "https://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.gz" && \
  tar -xzf ruby.tar.gz -C /usr/src/ruby && \
  rm ruby.tar.gz && \
  cd "/usr/src/ruby/ruby-$RUBY_VERSION" && \
  autoconf && \
  ./configure --disable-install-doc --with-readline-dir=/usr/ && \
  make -j"$(nproc)" && \
  make install && \
  gem update -N --system $RUBY_GEMS_VERSION && \
  rm -rf /usr/src/ruby && \
  cd ~/ && \
  apk add --update-cache --virtual passenger-dependencies --repository https://nl.alpinelinux.org/alpine/edge/main libexecinfo libexecinfo-dev && \
  curl -fSL "https://s3.amazonaws.com/phusion-passenger/releases/$PASSENGER.tar.gz" | tar xvz && \
  mv "$PASSENGER/" /passenger && \
  cd /passenger && \
  export EXTRA_PRE_CFLAGS='-O' EXTRA_PRE_CXXFLAGS='-O' EXTRA_LDFLAGS='-lexecinfo' && \
  passenger-config install-standalone-runtime --auto --connect-timeout=60 && \
  passenger-config build-native-support && \
  passenger-config validate-install --auto && \
  gem install bundler --no-rdoc --no-ri --no-doc --version "$BUNDLER_VERSION" && \
  bundle config --global path "$GEM_HOME" && \
  bundle config --global bin "$GEM_HOME/bin" && \
  gem install nokogiri -v 1.6.7 --no-rdoc --no-ri --no-doc -- --use-system-libraries && \
  gem install rb-readline --no-rdoc --no-ri --no-doc && \
  gem install json -v 1.8.3 --no-rdoc --no-ri --no-doc && \
  rm -rf /var/cache/apk/*
