#!/bin/bash
mount --make-shared /
echo "Génération du fichier de configuration containerd..."
mkdir -p /etc/containerd
/usr/bin/containerd config default > /etc/containerd/config.toml
/usr/bin/containerd >> /proc/1/fd/1 2>&1 &
sleep 5
/usr/bin/dockerd >> /proc/1/fd/1 2>&1 &
sleep 5
/usr/bin/kubelet --config=/etc/kubernetes/kubelet-config.yaml --kubeconfig=/etc/kubernetes/kubelet.conf --authentication-token-webhook=false --authorization-mode=AlwaysAllow
