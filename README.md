# MistServer

MistServer is a streaming media server that works well in any streaming environment even on a Raspberry Pi! It bridges the gap between dedicated media servers and web servers, performing the best of both worlds when it comes to media streaming delivery.

### Mistserver is now fully open source!! 
Since 3.4 MistServer has all Pro features, more info [here](https://www.reddit.com/r/selfhosted/comments/1f9m9zl/mistserver_media_streaming_now_public_domain/) and [changelog](https://releases.mistserver.org/changelog).

The image always installs the newest official MistServer release at build time and is available for `linux/amd64`, `linux/arm64`, `linux/arm/v7` and `linux/386`.

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
* `--net=host` - Recommended! You can change ports within Mistserver Protocols.
* `-v <path to config>:/config` - config and log files  
* `-v <path to video>:/media` - video and audio files  
* `-p 4242` - Web UI  
* `-p 1935` - RTMP  
* `-p 554` - RTSP   
* `-p 8080` - HTTP / HLS 
* `-v /etc/localhost:ro` - for timesync (read-only)
* `--shm-size=2048m` - amount of shared memory 

### Updating
The image tracks the latest MistServer release, so pulling a fresh image is all you need:
```
docker compose pull && docker compose up -d
```
Building it yourself always fetches the newest release as well:
```
docker build -t mistserver .
```
To pin a specific release instead, pass the version as a build argument:
```
docker build --build-arg MISTSERVER_VERSION=3.11.2 -t mistserver .
```

### Webinterface
1. Webui: http://mydomain.tld:4242 and enter a username/password.   
2. Click on "Enable protocols" and change ports if necessary.
3. Enter a "Human readable name" and thick "Force JSON file save". 

### MistServer
- [MistServer](https://mistserver.org)
- [Changelog](https://releases.mistserver.org/changelog)
- [Documentation](https://docs.mistserver.org/)


