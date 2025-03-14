#!/bin/bash
export URL=https://raw.githubusercontent.com/clecio81/qemu-alpine-docker_on_termux
export BRANCH=master

# we need qemu 5.2+

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7638D0442B90D010
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 04EE7237B7D453EC

sudo rm -f /etc/apt/sources.list.d/buster-backports.list
echo "deb http://deb.debian.org/debian buster-backports main" | sudo tee -a /etc/apt/sources.list.d/buster-backports.list

sudo apt-get update

sudo apt-get install -y wget expect
sudo apt-get -t buster-backports install -y qemu qemu-system-common qemu-system-data qemu-system-x86 qemu-utils

mkdir -p alpine
cd alpine

if [ ! -f "config.env" ]; then
    # get the default config file
    wget -q -c -t0 ${URL}/${BRANCH}/config.env
fi

# URL / BRANCH might be overwritten here
. config.env

wget -q -c -t0 ${URL}/${BRANCH}/answerfile
wget -q -c -t0 ${URL}/${BRANCH}/ssh2qemu.sh
chmod +x ./ssh2qemu.sh
wget -q -c -t0 ${URL}/${BRANCH}/startqemu.sh
chmod +x ./startqemu.sh
sed -i "s:\$PREFIX/share/qemu/edk2-x86_64-code.fd:/usr/share/qemu/OVMF.fd:g" ./startqemu.sh
wget -q -c -t0 ${URL}/${BRANCH}/installqemu.expect
sed -i "s:\$env(PREFIX)/share/qemu/edk2-x86_64-code.fd:/usr/share/qemu/OVMF.fd:g" ./installqemu.expect
expect -f installqemu.expect
