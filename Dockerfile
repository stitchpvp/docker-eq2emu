FROM ubuntu:16.04

RUN apt-get update && \
  apt-get install -y build-essential libmysqlclient-dev libreadline-dev mysql-client git

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone https://github.com/stitchpvp/world && \
  cd world/source/WorldServer && \
  git checkout new_beginnings && \
  make

VOLUME /app

WORKDIR /release

COPY bin/entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
CMD ["./eq2world"]
