#!/bin/bash

apt-get -y install curl

curl -sL https://deb.nodesource.com/setup_8.x | bash -
apt-get -y install nodejs

apt-get update
apt-get -y install -y git rdiff-backup screen build-essential openjdk-8-jre-headless

mkdir -p /usr/games
cd /usr/games
git clone https://github.com/hexparrot/mineos-node.git minecraft
cd minecraft
git config core.filemode false
chmod +x service.js mineos_console.js generate-sslcert.sh webui.js
npm install --unsafe-perm
ln -s /usr/games/minecraft/mineos_console.js /usr/local/bin/mineos


cp mineos.conf /etc/mineos.conf

cp init/systemd_conf /etc/systemd/system/mineos.service
systemctl enable mineos

cd /usr/games/minecraft
./generate-sslcert.sh

systemctl start mineos
