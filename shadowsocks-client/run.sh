#!/bin/bash

# OBFS_INHOST
# OBFS_INPORT
# OBFS_PASSWORD
# SS_PASSWORD
# SS_HOST
# SS_PORT


if [[ x"${OBFS_PASSWORD}" == x ]]; then
  rm -fv /etc/supervisor/conf.d/obfsproxy-client.ini

  sed -i'' -e "
    s,SS_HOST,${SS_HOST},g;
    s,SS_PORT,${SS_PORT},g;
    s,SS_PASSWORD,${SS_PASSWORD},g;" \
    /etc/shadowsocks/client.json

else
  export SS_HOST=127.0.0.1
  export SS_PORT=9999
  sed -i'' -e "s,OBFS_INHOST,${OBFS_INHOST},g;
    s,OBFS_INPORT,${OBFS_INPORT},g;
    s,OBFS_PASSWORD,${OBFS_PASSWORD},g;
    s,SS_HOST,${SS_HOST},g;
    s,SS_PORT,${SS_PORT},g;
    s,SS_PASSWORD,${SS_PASSWORD},g;" \
    /etc/supervisor/conf.d/obfsproxy-client.ini  /etc/shadowsocks/client.json

fi


exec /usr/bin/supervisord --nodaemon
