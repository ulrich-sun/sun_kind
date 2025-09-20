FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release iproute2 socat conntrack ebtables ethtool \
    software-properties-common systemd && \
    apt-get clean

# Add Kubernetes apt repository
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | gpg --dearmor -o /etc/apt/trusted.gpg.d/kubernetes.gpg && \
    echo "deb https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /" > /etc/apt/sources.list.d/kubernetes.list

# Install Kubernetes components and containerd
RUN apt-get update && \
    apt-get install -y kubelet kubeadm kubectl containerd && \
    apt-mark hold kubelet kubeadm kubectl

# Disable swap (Kubernetes requirement)
RUN swapoff -a && sed -i '/ swap / s/^/#/' /etc/fstab

# Configure containerd
RUN mkdir -p /etc/containerd && \
    containerd config default > /etc/containerd/config.toml

# Copy configuration files
COPY kubelet/config.yaml /var/lib/kubelet/config.yaml
COPY systemd/kubelet.service /etc/systemd/system/kubelet.service
COPY systemd/10-kubeadm.conf /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

# Entrypoint for systemd
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

STOPSIGNAL SIGRTMIN+3
CMD ["/entrypoint.sh"]