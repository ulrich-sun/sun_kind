FROM ubuntu:22.04

# Mettre à jour le système et installer les dépendances de base
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        wget \
        gnupg \
        lsb-release \
        software-properties-common \
        bash-completion \
        git \
        iproute2 \
        net-tools \
        iptables \
        sudo \
        kmod \
        jq \
        vim \
        systemd && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Installer containerd
RUN wget https://github.com/containerd/containerd/releases/download/v2.0.0/containerd-2.0.0-linux-amd64.tar.gz && \
    tar Cxzvf /usr/local containerd-2.0.0-linux-amd64.tar.gz

# Installer runc
RUN wget https://github.com/opencontainers/runc/releases/download/v1.1.3/runc.amd64 && \
    install -m 755 runc.amd64 /usr/local/sbin/runc

# Installer CNI plugins
RUN wget https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz && \
    mkdir -p /opt/cni/bin && \
    tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.1.1.tgz

# Installer Docker CLI
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y docker-ce-cli docker-compose && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Installer kubeadm, kubelet, kubectl
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /" > /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y kubelet kubeadm kubectl && \
    apt-mark hold kubelet kubeadm kubectl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copier les scripts et fichiers de configuration
COPY ./systemctl /usr/bin/systemctl
RUN chmod +x /usr/bin/systemctl

COPY ./.bashrc /root/
COPY ./motd /etc/motd
COPY ./wrapkubeadm.sh /usr/local/bin/kubeadm
COPY ./kubelet-config.yaml /etc/kubernetes/kubelet-config.yaml
COPY ./kubelet.service /lib/systemd/system/kubelet.service
COPY ./kubelet.conf /etc/kubernetes/kubelet.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh


# Configurer containerd et systemd
RUN mkdir -p /etc/containerd && \
    containerd config default > /etc/containerd/config.toml && \
    sed -i 's/SystemdCgroup = false/SystemdCgroup = true/g' /etc/containerd/config.toml && \
    curl -L https://raw.githubusercontent.com/containerd/containerd/main/containerd.service -o /etc/systemd/system/containerd.service && \
    systemctl daemon-reload

# Définir le volume pour kubelet
VOLUME ["/var/lib/kubelet"]

WORKDIR /root

# Script de démarrage
ENTRYPOINT ["/entrypoint.sh"]

CMD ["bash"]
