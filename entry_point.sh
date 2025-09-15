#!/bin/bash

wget -N https://raw.githubusercontent.com/Psiphon-Labs/psiphon-tunnel-core-binaries/master/linux/psiphon-tunnel-core-x86_64
mv psiphon-tunnel-core-x86_64 psiphon
chmod +x psiphon
wget -O psiphon.config https://gist.githubusercontent.com/Rayfield990/f485bf80707ae01c54f245120e036192/raw/psiphon.config
sleep 15
nohup ./psiphon -config psiphon.config >/dev/null 2>&1 &
sleep 10
netstat -ntlp
sleep 5
curl --preproxy socks5://127.0.0.1:1081 ipinfo.io
sleep 5
node ./index.js
