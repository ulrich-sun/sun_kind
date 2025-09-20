mount --make-shared /
/usr/bin/containerd &
sleep 5
/usr/bin/kubelet --config=/etc/kubernetes/kubelet-config.yaml
