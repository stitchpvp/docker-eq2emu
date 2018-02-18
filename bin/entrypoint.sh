#!/usr/bin/env bash
rm -rf /release/*

lndir :wq

ln -s /world/source/WorldServer/eq2world /release/eq2world
ln -s /app/logs /release/logs
cp -rs /app/structs/*.xml /release
cp -rs /app/config/* /release

# give db time to start
sleep 5

if ! mysql -uroot -peq2world -hdb -e 'use eq2world'; then
  mysql -uroot -peq2world -hdb -e "create database eq2world"; 
  mysql -uroot -peq2world -hdb eq2world < /app/data/dump.sql
fi

exec "$@"
