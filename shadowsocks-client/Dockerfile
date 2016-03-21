FROM debian:jessie

RUN echo 'deb http://mirrors.163.com/debian jessie main'>/etc/apt/sources.list
RUN echo 'deb http://mirrors.163.com/debian jessie-updates main'>>/etc/apt/sources.list

RUN apt-get update && apt-get install -y supervisor gcc python-pip python-dev curl sudo --no-install-recommends

ADD pip.conf  /etc/pip.conf
RUN pip install obfsproxy

RUN mkdir -p /etc/shadowsocks
RUN test -x /usr/local/bin/shadowsocks-local || curl -q http://dl.chenyufei.info/shadowsocks/latest/shadowsocks-local-linux64-1.1.4.gz | gunzip > /usr/local/bin/shadowsocks-local
RUN chmod 0555 /usr/local/bin/shadowsocks-local
ADD files/client.json /etc/shadowsocks/

ADD files/supervisor/supervisord.conf  /etc/supervisor/supervisord.conf
ADD files/supervisor/shadowsocks-client.ini /etc/supervisor/conf.d/
ADD files/supervisor/obfsproxy-client.ini   /etc/supervisor/conf.d/

ADD run.sh    /run.sh

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 7000
CMD [ "/run.sh"]

