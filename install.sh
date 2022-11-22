#!/bin/bash

# Install with `curl -fsSL $URL | sudo bash`

REPO="https://github.com/robottalk/koala.git"
INSTALL_DIR="/opt/koala"
KOALA_USER="koala"

# Exit if not root
[ "$UID" != 0 ] && echo "This script must be run as root" && exit 1

# Create system user
useradd -r $KOALA_USER

git clone $REPO $INSTALL_DIR
ln -s ${INSTALL_DIR}/koala.service /etc/systemd/system
systemctl daemon-reload
systemctl enable koala.service
systemctl start koala.service
