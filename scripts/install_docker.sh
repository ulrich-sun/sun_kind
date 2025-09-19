#!/bin/bash
set -e

echo "[INFO] Installation de Docker CLI"

VERSION_STRING="5:25.0.3-1~ubuntu.22.04~jammy"

apt-get update
apt-get install -y ca-certificates curl gnupg

# Clé GPG
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Dépôt officiel Docker
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
  > /etc/apt/sources.list.d/docker.list

# Installation Docker CLI (pas de dockerd systemd)
apt-get update
apt-get install -y \
  docker-ce-cli=$VERSION_STRING \
  docker-buildx-plugin \
  docker-compose-plugin
