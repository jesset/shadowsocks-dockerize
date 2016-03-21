#!/bin/bash

# OBFS_PASSWORD
# SS_PASSWORD

if [[ x"${OBFS_PASSWORD}" == x ]]; then
  rm -fv /etc/supervisor/conf.d/obfsproxy.ini
  sed -i'' -e 's,9999,8080,g;'  /etc/shadowsocks/server.json
else
  sed -i'' -e "s,OBFS_PASSWORD,${OBFS_PASSWORD},g;" /etc/supervisor/conf.d/obfsproxy.ini
fi

sed -i'' -e "s,SS_PASSWORD,${SS_PASSWORD},g;"  /etc/shadowsocks/server.json


exec /usr/bin/supervisord --nodaemon
