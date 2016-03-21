#!/bin/bash

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

while true
do
  rm -rf /tmp/scramblesuit*
  /usr/bin/supervisorctl restart obfsproxy
 sleep 1200
done
