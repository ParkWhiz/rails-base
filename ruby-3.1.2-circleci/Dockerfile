FROM parkwhiz/rails-base:3.1.2_20220926121932
LABEL org.opencontainers.image.authors="ParkWhiz <dev@parkwhiz.com>"

WORKDIR /


# ---------------------
# -- Installing Docker.
# ---------------------

# https://docs.docker.com/engine/install/debian/
RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends lsb-release && \
  curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
  apt-get update && \
  curl -fsSL get.docker.com | CHANNEL=stable sh && \
  apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io
