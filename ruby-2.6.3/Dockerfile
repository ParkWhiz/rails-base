FROM alpine:3.4
MAINTAINER ParkWhiz <dev@parkwhiz.com>

ENV PATH "$GEM_HOME/bin:/passenger/bin:$PATH"

# ---------------------
# -- Just `apk` things.
# ---------------------
ENV BUILD_PACKAGES autoconf bison build-base curl git libc-dev libstdc++ openssl-dev pcre pcre-dev postgresql-dev procps ruby-dev wget
ENV RUBY_PACKAGES ca-certificates curl-dev file imagemagick libxml2-dev libxslt-dev linux-headers mysql-dev nginx nodejs postgresql-client procps readline-dev ruby-rake tzdata
RUN \
  apk update && \
  apk upgrade && \
  apk add bash && \
  apk add --virtual build-dependencies $BUILD_PACKAGES && \
  apk add --virtual ruby-packages $RUBY_PACKAGES

# -----------------------------
# -- Download and install Ruby.
# -----------------------------
ENV RUBY_MINOR_VERSION 2.6
ENV RUBY_VERSION 2.6.1
ENV RUBYGEMS_VERSION 2.7.7
RUN \
  mkdir -p /usr/src/ruby && \
  curl -fSL -o ruby.tar.gz "https://cache.ruby-lang.org/pub/ruby/$RUBY_MINOR_VERSION/ruby-$RUBY_VERSION.tar.gz" && \
  tar -xzf ruby.tar.gz -C /usr/src/ruby && \
  rm ruby.tar.gz && \
  cd "/usr/src/ruby/ruby-$RUBY_VERSION" && \
  autoconf && \
  ./configure --disable-install-doc --with-readline-dir=/usr/ && \
  make -j"$(nproc)" && \
  make install && \
  gem update -N --system $RUBY_GEMS_VERSION && \
  rm -rf /usr/src/ruby

# -----------------------------------------------------------
# -- Install Bundler and big gems, to speed up Circle builds.
# -----------------------------------------------------------
ENV BUNDLER_VERSION 2.0.1
ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_APP_CONFIG $GEM_HOME
RUN \
  gem install bundler --no-doc --version "$BUNDLER_VERSION" && \
  bundle config --global path "$GEM_HOME" && \
  bundle config --global bin "$GEM_HOME/bin" && \
  gem install nokogiri -v 1.8.5 --no-doc -- --use-system-libraries
# RUN gem install json -v 1.8.3 --no-doc

# ---------------------------------
# -- Download and install Passenger
# ---------------------------------
ENV PASSENGER passenger-6.0.2
ENV EXTRA_PRE_CFLAGS -O
ENV EXTRA_PRE_CXXFLAGS -O
ENV EXTRA_LDFLAGS -lexecinfo
RUN \
  cd ~/ && \
  apk add --update-cache --virtual passenger-dependencies --repository https://nl.alpinelinux.org/alpine/edge/main libexecinfo libexecinfo-dev && \
  curl -fSL "https://s3.amazonaws.com/phusion-passenger/releases/$PASSENGER.tar.gz" | tar xvz && \
  mv "$PASSENGER/" /passenger && \
  cd /passenger

WORKDIR /passenger

# RUN \
RUN passenger-config install-standalone-runtime --auto --connect-timeout=60
RUN passenger-config build-native-support
RUN passenger-config validate-install --auto

# ---------------------
# -- Clear `apk` cache.
# ---------------------
RUN rm -rf /var/cache/apk/*
