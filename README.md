# MistServer

MistServer is a streaming media server that works well in any streaming environment even on a Raspberry Pi! It bridges the gap between dedicated media servers and web servers, performing the best of both worlds when it comes to media streaming delivery.

### Mistserver is now fully open source!! 
Mistserver 3.4 has all now all Pro features, more info [here](https://www.reddit.com/r/selfhosted/comments/1f9m9zl/mistserver_media_streaming_now_public_domain/) and [changelog](https://releases.mistserver.org/changelog).

# Usage 
```
docker run -d --restart always --name=mistserver \   
--net=host \    
-v <path to config>:/config \   
-v <path to video>:/media \
--shm-size=2048m \    
r0gger/mistserver   
```   
  
**Parameters**    
* `--net=host` - Recommended! You can change ports within Mistserver Protocols.
* `-v <path to config>:/config` - config and log files  
* `-v <path to video>:/media` - video and audio files  

*Special note* - If you'd like to run Mistserver without requiring `--net=host` (`NOT recommended`) then you will need the following ports in your `docker create` command:

* `-p 4242` - Web UI  
* `-p 1935` - RTMP  
* `-p 554` - RTSP   
* `-p 8080` - HTTP / HLS 
* `-v /etc/localhost:ro` - for timesync (read-only)
* `--shm-size=2048m` - amount of shared memory 

### Webinterface
1. Webui: http://mydomain.tld:4242 and enter a username/password.   
2. Click on "Enable protocols" and change ports if necessary.
3. Enter a "Human readable name" and thick "Force JSON file save". 

### MistServer
- [MistServer](https://mistserver.org)
- [Changelog](https://releases.mistserver.org/changelog)
- [Documentation](https://docs.mistserver.org/)


