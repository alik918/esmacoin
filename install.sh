#!/usr/bin/env bash

if [ -d "/opt/esmacoin" ]; then
  # Control will enter here if $DIRECTORY exists.
  echo "#######################################################################"
  echo "__________                            "
  echo "\____    /____  ___________   ____   "
  echo "  /     // ___\/  _ \_  __ \_/ __ \  "
  echo " /     /\  \__(  <_> )  | \/\  ___/  "
  echo "/_______ \___  >____/|__|    \___  > "
  echo "        \/   \/                  \/   " 
  echo "#######################################################################"
  echo "### Please backup folder /opt/esmacoin ex.: mv /opt/esmacoin /opt/esmacoin-bkp"
  echo "#######################################################################"
else
esmacoin-cli stop
apt-get update
mkdir /opt/esmacoin
cd /opt/esmacoin/
apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils -y
apt-get install libboost-all-dev -y
add-apt-repository -y ppa:bitcoin/bitcoin
apt-get update
apt-get install libdb4.8-dev libdb4.8++-dev -y
cd /opt/esmacoin/
git clone https://github.com/esmacoin-coin/esmacoin-source.git 
cd /opt/esmacoin/esmacoin-source/
ls -l
#dd if=/dev/zero of=/swapfile bs=1024 count=2M
#chmod 600 /swapfile
#mkswap /swapfile
#swapon -a /swapfile
./autogen.sh
./configure
make install
fi