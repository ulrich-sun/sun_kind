#!/bin/bash
set -e

echo "[INFO] Installation de crictl"

CRICTL_VERSION="v1.31.0"

curl -LO "https://github.com/kubernetes-sigs/cri-tools/releases/download/${CRICTL_VERSION}/crictl-${CRICTL_VERSION}-linux-amd64.tar.gz"
tar -zxvf "crictl-${CRICTL_VERSION}-linux-amd64.tar.gz"
mv crictl /usr/local/bin/
rm -f "crictl-${CRICTL_VERSION}-linux-amd64.tar.gz"
