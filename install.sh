#!/bin/bash

# Install with `curl -fsSL $SCRIPT_URL | sudo bash`

REPO="https://github.com/derekolsen/koala.git"
INSTALL_DIR="/opt/koala"
KOALA_USER="koala"

[ "$UID" != 0 ] && echo "This script must be run as root" && exit 1

apt-get install -y xvfb ffmpeg chromium

useradd -r $KOALA_USER

git clone $REPO $INSTALL_DIR
ln -s ${INSTALL_DIR}/koala.service /etc/systemd/system
systemctl daemon-reload
systemctl enable koala.service
systemctl start koala.service
