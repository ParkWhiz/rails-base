FROM parkwhiz/rails-base:2.6.3_20190429154415
MAINTAINER ParkWhiz <dev@parkwhiz.com>

WORKDIR /


# ---------------------
# -- Just `apk` things.
# ---------------------

RUN \
  apk update && \
  apk upgrade && \
  apk add docker && \
  apk add nano && \
  apk add vim



# ---------------------------------
# -- Download and install PhantomJS
# ---------------------------------

RUN \
  wget -O phantomjs-2.1.1-linux-x86_64.tar.bz2 "https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2" && \
  tar -xvf phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
  cd phantomjs-2.1.1-linux-x86_64/bin && \
  ln -s `pwd`/phantomjs /usr/local/bin/phantomjs


# ------------------------
# -- Run `bash` for Circle
# ------------------------

CMD /bin/bash
