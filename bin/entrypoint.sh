#!/usr/bin/env bash
rm -rf /release/*

if [ ! -d "/app/scripts" ]; then
  cd /app && git clone https://github.com/stitchpvp/scripts
fi

cd /release
ln -s /world/source/WorldServer/eq2world /release/eq2world
ln -s /app/scripts/* /release
cp -rs /app/structs/*.xml /release
cp -rs /app/config/* /release

exec "$@"
