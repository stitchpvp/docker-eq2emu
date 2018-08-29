FROM ubuntu:16.04

RUN apt-get update && \
  apt-get install -y build-essential libmysqlclient-dev libreadline-dev mysql-client git

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone https://github.com/stitchpvp/world && \
  cd world/source/WorldServer && \
  git checkout ini-to-env && \
  make

RUN mkdir /app
WORKDIR /app

RUN mkdir structs
COPY structs/*.xml structs/

RUN mkdir config
COPY config/*.xml config/

WORKDIR /release

COPY bin/entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["./eq2world"]
