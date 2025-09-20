#!/bin/bash
mount --make-shared /
/usr/bin/containerd &
sleep 5
/usr/bin/dockerd &
sleep 5
/usr/bin/kubelet --config=/etc/kubelet-config.yaml