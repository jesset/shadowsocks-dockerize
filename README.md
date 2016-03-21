# Run


## server side: (with obfsproxy)
```
sudo docker run -d --ulimit nofile=4096:8192 -p 8090:8080 \
  --restart=always --memory="256m" --memory-swap="-1" --name=obfsserver_8090 \
    -e OBFS_PASSWORD={32_base64_char} \
    -e SS_PASSWORD={some_rand_str} \
    ssserver;
```

## server side: (without obfsproxy)
```
sudo docker run -d --ulimit nofile=4096:8192 -p 8096:8080 \
  --restart=always --memory="256m" --memory-swap="-1" --name=ssserver_8096 \
    -e SS_PASSWORD={some_rand_str} \
    ssserver;
```



## client side : (with obfsproxy)
```
sudo docker run -d -p 7070:7000 --ulimit nofile=8192:8192 \
  --restart=always --memory="256m" --memory-swap="-1" --name=obfsclient_lato \
  -e OBFS_PASSWORD={32_base64_char} \
  -e OBFS_INHOST=x.x.x.x \
  -e OBFS_INPORT=8090 \
  -e SS_PASSWORD={some_rand_str}  ssclient
```

## client side: (without obfsproxy)
```
sudo docker run -d -p 7071:7000 --ulimit nofile=8192:8192 \
  --restart=always --memory="256m" --memory-swap="-1" --name=ssclient_lato \
  -e SS_HOST=x.x.x.x \
  -e SS_PORT=8096 \
  -e SS_PASSWORD={some_rand_str}  ssclient
```


## test
```
while true;do
  for port in 7070 7071
  do
    curl --progress-bar -f -q --connect-timeout 3 --max-time 10 \
    --socks5-hostname 127.0.0.1:$port   https://twitter.com/ >/dev/null
    echo $((c++)):$?
  done
done



true>/tmp/proxytest.txt
true>/tmp/proxytest.result

for i in {1..100}
do
  curl -f -q --connect-timeout 3 --max-time 8 --socks5-hostname 127.0.0.1:7090  https://twitter.com/   >/dev/null  2>/tmp/proxytest.txt
  echo $? >> /tmp/proxytest.result
done
sort /tmp/proxytest.result | uniq -c

```

