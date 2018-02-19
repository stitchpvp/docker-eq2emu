#!/usr/bin/env bash
rm -rf /release/*

ln -s /world/source/WorldServer/eq2world /release/eq2world
ln -s /app/logs /release/logs
ln -s /app/scripts/* /release
cp -rs /app/structs/*.xml /release
cp -rs /app/config/* /release

# give db time to start
if ! mysql -uroot -peq2world -hdb -e 'show databases'; then
  echo "Waiting for database..."
  sleep 10
fi

if ! mysql -uroot -peq2world -hdb -e 'use eq2world'; then
  echo "Seeding database, this might take a minute..."
  mysql -uroot -peq2world -hdb -e "create database eq2world"; 
  gunzip < /app/data/dump.sql.gz | mysql -uroot -peq2world -hdb eq2world
fi

exec "$@"
