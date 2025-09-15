#!/bin/bash

wget -N https://github.com/Snawoot/opera-proxy/releases/download/v1.4.2/opera-proxy.linux-amd64
chmod +x opera-proxy.linux-amd64
curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && dpkg -i cloudflared.deb 
wget -O websocat https://github.com/vi/websocat/releases/latest/download/websocat.x86_64-unknown-linux-musl
chmod a+x websocat

wget -O wireproxy.tar.gz https://github.com/pufferffish/wireproxy/releases/download/v1.0.9/wireproxy_linux_amd64.tar.gz
tar xzf wireproxy.tar.gz; rm -f wireproxy.tar.gz
chmod +x wireproxy

wget -O socks-over-https.tar.gz https://github.com/haxii/socks-over-https/files/2635594/socks-over-https-v0.1.2-linux-amd64.tar.gz
tar xf socks-over-https.tar.gz; rm -f socks-over-https.tar.gz
mv socks-over-https-v0.1.2-linux-amd64/socks-over-https socksover
mv socks-over-https-v0.1.2-linux-amd64/config.json config.json
chmod a+x socksover
rm config.json
curl -o config.json https://gist.githubusercontent.com/laurens28/73867cb271d2952af1a1f616652cb2e0/raw/conf.json
curl -o wnl.conf https://gist.githubusercontent.com/haynes62/52f4ae1b78d5e412f81e5a436c62e25f/raw/wnl.conf
ls -la
sleep 5
cat wnl.conf
sleep 5
nohup ./opera-proxy.linux-amd64 -country EU >/dev/null 2>&1 &
sleep 3
nohup ./socksover -c ./config.json >/dev/null 2>&1 &
sleep 5
nohup ./websocat -E -b ws-l:127.0.0.1:5096 tcp:127.0.0.1:10800 >/dev/null 2>&1 &

# nohup ./wireproxy -c ./wnl.conf >/dev/null 2>&1 &

sleep 4
nohup cloudflared tunnel --edge-ip-version auto --no-autoupdate --protocol http2 run --token "eyJhIjoiZjllNjNiZmUwNjZiOTYwN2YyZTExZDliNDRjYTk0ZjYiLCJ0IjoiYTU1N2NmODEtMjFiMy00MGY3LWI0MjgtOTMxMWZjM2U5NDJhIiwicyI6Ik5qWmlNamRtTWpNdE1XRTFaUzAwTmpsaExXRmpPV1V0TkRKaFpERmtZbVV5WWpFMSJ9" >/dev/null 2>&1 &
sleep 5
curl -sS http://ip-api.com/json --preproxy socks5://127.0.0.1:10800

sleep 15
netstat -ntlp
sleep 5
node ./index.js
