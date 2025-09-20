#!/bin/bash
mount --make-shared /
/usr/bin/containerd &
sleep 5
/usr/bin/dockerd &
sleep 5
/usr/bin/kubelet --container-runtime=remote --container-runtime-endpoint=unix:///run/containerd/containerd.sock --runtime-request-timeout=15m
