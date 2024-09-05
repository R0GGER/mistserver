FROM debian:stable-slim

ENV PATH="/app/mistserver:${PATH}"
ARG MISTSERVER=https://r.mistserver.org/dl/mistserver_64V3.4.tar.gz

# install basics
RUN apt-get update
RUN apt-get install wget -yq
RUN mkdir -p /app/mistserver /config /media
ADD service/ /etc/service/
RUN chmod -v +x /etc/service/*/run

# install mistserver
RUN wget -qO- ${MISTSERVER} | tar xvz -C /app/mistserver

# clean up
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /config /media
EXPOSE 4242 8080 1935 554

# run
CMD ["/etc/service/mistserver/run"]

# docker run -d --name mistserver --restart=always --net=host -v <path to video>:/media r0gger/mistserver 
