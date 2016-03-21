FROM debian:jessie

RUN apt-get update && apt-get install -y supervisor gcc python-pip python-dev curl lsof net-tools vim-nox strace sudo --no-install-recommends
RUN pip install obfsproxy

RUN mkdir -p /etc/shadowsocks
RUN test -x /usr/local/bin/shadowsocks-server || curl -q http://dl.chenyufei.info/shadowsocks/latest/shadowsocks-server-linux64-1.1.4.gz | gunzip > /usr/local/bin/shadowsocks-server
RUN chmod 0755 /usr/local/bin/shadowsocks-server
ADD files/server.json /etc/shadowsocks/

ADD files/supervisor/supervisord.conf  /etc/supervisor/supervisord.conf
ADD files/supervisor/shadowsocks-server.ini /etc/supervisor/conf.d/
ADD files/supervisor/obfsproxy.ini         /etc/supervisor/conf.d/
ADD files/supervisor/obfsproxy_cleanup.ini /etc/supervisor/conf.d/
ADD run.sh         /run.sh
ADD workaround_purgeobfsdata.sh  /workaround_purgeobfsdata.sh

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN useradd -m search
EXPOSE 8080
CMD [ "/run.sh" ]

