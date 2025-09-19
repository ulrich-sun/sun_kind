#!/bin/bash
set -e

echo "[INFO] Installation des outils supplémentaires (Git, Go, CNI, etc.)"

apt-get update
apt-get install -y git build-essential wget socat conntrack

# Go
GO_VERSION="1.21.1"
wget "https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz"
tar -C /usr/local -xzf "go${GO_VERSION}.linux-amd64.tar.gz"
echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.bashrc
rm -f "go${GO_VERSION}.linux-amd64.tar.gz"

# Plugins CNI
CNI_VERSION="v1.5.1"
curl -LO "https://github.com/containernetworking/plugins/releases/download/${CNI_VERSION}/cni-plugins-linux-amd64-${CNI_VERSION}.tgz"
mkdir -p /opt/cni/bin
tar -C /opt/cni/bin -xzvf "cni-plugins-linux-amd64-${CNI_VERSION}.tgz"
rm -f "cni-plugins-linux-amd64-${CNI_VERSION}.tgz"
