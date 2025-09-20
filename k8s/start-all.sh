#!/bin/bash
mount --make-shared /
/usr/bin/containerd &
sleep 5
/usr/bin/dockerd &
sleep 5
/usr/bin/kubelet --config=/etc/kubernetes/kubelet-config.yaml --kubeconfig=/etc/kubernetes/kubelet.conf --authentication-token-webhook=false --authorization-mode=AlwaysAllow
