export URL=https://github.com/clecio81/qemu-alpine-docker_on_termux
export BRANCH=main

pkg install -y expect wget qemu-utils qemu-common qemu-system-x86_64-headless openssh

mkdir -p alpine
cd alpine

if [ ! -f "config.env" ]; then
    # get the default config file
    wget -q -c -t0 https://raw.githubusercontent.com/clecio81/qemu-alpine-docker_on_termux/main/config.env
fi

# URL / BRANCH might be overwritten here
. config.env

wget -q -c -t0 https://raw.githubusercontent.com/clecio81/qemu-alpine-docker_on_termux/main/answerfile
wget -q -c -t0 https://raw.githubusercontent.com/clecio81/qemu-alpine-docker_on_termux/main/ssh2qemu.sh
chmod +x ./ssh2qemu.sh
wget -q -c -t0 https://raw.githubusercontent.com/clecio81/qemu-alpine-docker_on_termux/main/startqemu.sh
chmod +x ./startqemu.sh
wget -q -c -t0 https://raw.githubusercontent.com/clecio81/qemu-alpine-docker_on_termux/main/installqemu.expect
expect -f installqemu.expect
