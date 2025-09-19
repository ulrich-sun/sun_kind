#!/bin/bash
set -e

echo "[INFO] Installation de Minikube"

MINIKUBE_VERSION="v1.35.0"

curl -LO "https://storage.googleapis.com/minikube/releases/${MINIKUBE_VERSION}/minikube-linux-amd64"
install minikube-linux-amd64 /usr/local/bin/minikube
rm -f minikube-linux-amd64
