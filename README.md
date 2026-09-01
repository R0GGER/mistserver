# MistServer

MistServer is a streaming media server that works well in any streaming environment, including on a Raspberry Pi. It bridges the gap between dedicated media servers and web servers, combining the strengths of both for media delivery.

### MistServer is fully open source

Since 3.4, MistServer includes all Pro features. See the [announcement](https://www.reddit.com/r/selfhosted/comments/1f9m9zl/mistserver_media_streaming_now_public_domain/) and the [changelog](https://releases.mistserver.org/changelog).

This image installs the newest official MistServer release at build time. It is available for `linux/amd64`, `linux/arm64`, `linux/arm/v7` and `linux/386`.

# Usage

```
docker run -d --restart always --name=mistserver \
  --net=host \
  -v <path to config>:/config \
  -v <path to video>:/media \
  --shm-size=2048m \
  ghcr.io/r0gger/mistserver
```

[docker-compose.yml](https://github.com/R0GGER/mistserver/blob/master/docker-compose.yml):

```
services:
  mistserver:
    container_name: mistserver
    image: ghcr.io/r0gger/mistserver:latest
    pull_policy: always
    restart: unless-stopped
    volumes:
      - /path-to/config:/config
      - /path-to/media:/media
    network_mode: host
    shm_size: 2048m
```

**Parameters**

* `--net=host` — Recommended. You can change ports in MistServer Protocols.
* `-v <path to config>:/config` — Config and log files
* `-v <path to video>:/media` — Video and audio files
* `-p 4242` — Web UI
* `-p 1935` — RTMP
* `-p 554` — RTSP
* `-p 8080` — HTTP / HLS
* `-v /etc/localtime:/etc/localtime:ro` — Time sync (read-only)
* `--shm-size=2048m` — Shared memory size

### Updating

The image tracks the latest MistServer release, so pulling a fresh image is enough:

```
docker compose pull && docker compose up -d
```

Building it yourself also fetches the newest release:

```
docker build -t mistserver .
```

To pin a specific release, pass the version as a build argument:

```
docker build --build-arg MISTSERVER_VERSION=3.11.2 -t mistserver .
```

### Web interface

1. Open the web UI at `http://mydomain.tld:4242` and set a username and password.
2. Click **Enable protocols** and change ports if needed.
3. Enter a **Human readable name** and tick **Force JSON file save**.

### MistServer

- [MistServer](https://mistserver.org)
- [Changelog](https://releases.mistserver.org/changelog)
- [Documentation](https://docs.mistserver.org/)
