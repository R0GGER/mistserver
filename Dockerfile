# syntax=docker/dockerfile:1

# Set to a specific release (e.g. 3.11.2) to pin the build.
ARG MISTSERVER_VERSION=latest

# ADD re-checks the remote file on every build, so "latest" really stays latest
# instead of being frozen in a cached layer.
FROM --platform=$BUILDPLATFORM debian:stable-slim AS fetch-amd64
ARG MISTSERVER_VERSION
ADD https://r.mistserver.org/dl/mistserver_64V${MISTSERVER_VERSION}.tar.gz /tmp/mistserver.tar.gz

FROM --platform=$BUILDPLATFORM debian:stable-slim AS fetch-386
ARG MISTSERVER_VERSION
ADD https://r.mistserver.org/dl/mistserver_32V${MISTSERVER_VERSION}.tar.gz /tmp/mistserver.tar.gz

FROM --platform=$BUILDPLATFORM debian:stable-slim AS fetch-arm64
ARG MISTSERVER_VERSION
ADD https://r.mistserver.org/dl/mistserver_aarch64V${MISTSERVER_VERSION}.tar.gz /tmp/mistserver.tar.gz

FROM --platform=$BUILDPLATFORM debian:stable-slim AS fetch-arm
ARG MISTSERVER_VERSION
ADD https://r.mistserver.org/dl/mistserver_armv7V${MISTSERVER_VERSION}.tar.gz /tmp/mistserver.tar.gz

FROM fetch-${TARGETARCH} AS unpack
RUN set -eux; \
    mkdir -p /app/mistserver; \
    tar xzf /tmp/mistserver.tar.gz -C /app/mistserver; \
    rm /tmp/mistserver.tar.gz; \
    chmod +x /app/mistserver/*


FROM debian:stable-slim

ENV PATH="/app/mistserver:${PATH}"

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends ca-certificates tzdata; \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*; \
    mkdir -p /config /media

COPY --from=unpack /app/mistserver /app/mistserver

VOLUME /config /media
EXPOSE 4242 8080 1935 554

CMD ["/bin/bash", "-c", "echo 'n' | /app/mistserver/MistController -c /config/server.conf"]
# docker run -d --name mistserver --restart=always --net=host --shm-size=2048m -v <path to video>:/media ghcr.io/r0gger/mistserver
