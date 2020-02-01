#!/usr/bin/env bash

set -Eeuo pipefail
shopt -s expand_aliases
alias die='EXIT=$? LINE=$LINENO error_exit'
trap die ERR
function error_exit() {
  trap - ERR
  local DEFAULT='Unknown failure occured.'
  local REASON="\e[97m${1:-$DEFAULT}\e[39m"
  local FLAG="\e[91m[ERROR:LXC] \e[93m$EXIT@$LINE"
  msg "$FLAG $REASON"
  exit $EXIT
}
function msg() {
  local TEXT="$1"
  echo -e "$TEXT"
}

# Prepare container OS
msg "Setting up container OS..."
sed -i "/$LANG/ s/\(^# \)//" /etc/locale.gen
locale-gen >/dev/null
apt-get -y purge openssh-{client,server} >/dev/null
apt-get autoremove >/dev/null

# Update container OS
msg "Updating container OS..."
apt-get update >/dev/null
apt-get -qqy upgrade &>/dev/null

# Install prerequisites
msg "Installing prerequisites..."
msg "Installing Node..."
apt-get -y install node.js #&>/dev/null

ln -s /usr/bin/nodejs /usr/bin/node &>/dev/null

msg "Installing NPM..."
apt-get -y install npm #&>/dev/null
msg "Installing PM2..."
npm install -g pm2 #&>/dev/null

# Install Node Red
msg "Installing Node Red..."
npm install -g --unsafe-perm node-red # &>/dev/null

# Customize Docker configuration
msg "Setting up PM2..."
pm2 start /usr/local/bin/node-red#  #&>/dev/null
pm2 save #&>/dev/null
pm2 startup #&>/dev/null
env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u nodeadmin --hp /home/nodeadmin #&>/dev/null

# Cleanup container
msg "Cleanup..."
rm -rf /setup.sh /var/{cache,log}/* /var/lib/apt/lists/*
