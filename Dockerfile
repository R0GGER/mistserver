FROM debian:stable-slim

ENV PATH="/app/mistserver:${PATH}"
ARG MISTSERVER=https://r.mistserver.org/dl/mistserver_64V3.4.tar.gz

# install basics
RUN apt-get update
RUN apt-get install wget -yq
RUN mkdir -p /app/mistserver /config /media

# install mistserver
RUN wget -qO- ${MISTSERVER} | tar xvz -C /app/mistserver

# clean up
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /config /media
EXPOSE 4242 8080 1935 554

CMD ["/bin/bash", "-c", "echo 'n' | /app/mistserver/MistController -c /config/server.conf"]
# docker run -d --name mistserver --restart=always --net=host --shm-size=2048m -v <path to video>:/media r0gger/mistserver 
