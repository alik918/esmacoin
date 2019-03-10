[Unit]
Description=Esmacoin's distributed currency daemon
After=network.target

[Service]
User=esmacoin
Group=esmacoin

Type=forking
PIDFile=/var/lib/esmacoind/esmacoind.pid
ExecStart=/usr/bin/esmacoind -daemon -pid=/var/lib/esmacoind/esmacoind.pid \
-conf=/etc/esmacoin/esmacoin.conf -datadir=/var/lib/esmacoind -disablewallet

Restart=always
PrivateTmp=true
TimeoutStopSec=60s
TimeoutStartSec=2s
StartLimitInterval=120s
StartLimitBurst=5

[Install]
WantedBy=multi-user.target
