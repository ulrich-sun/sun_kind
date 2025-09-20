FROM ubuntu:22.04

# Installe les dépendances et configure les dépôts
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https ca-certificates curl gnupg git bash-completion lsb-release kmod && \
    mkdir -p -m 755 /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /" > /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update

# Installe les outils
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y docker-ce docker-ce-cli containerd.io kubelet kubeadm kubectl && \
    apt-mark hold kubelet kubeadm kubectl && \
    curl -Lf -o /usr/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 && \
    curl -Lf -o /usr/bin/docker-compose https://github.com/docker/compose/releases/download/1.21.0/docker-compose-$(uname -s)-$(uname -m) && \
    chmod +x /usr/bin/jq /usr/bin/docker-compose && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copie les fichiers de configuration
COPY ./systemctl /usr/bin/systemctl
COPY ./kubelet.env /etc/systemd/system/
COPY ./docker.service /lib/systemd/system/
COPY ./wrapkubeadm.sh /usr/local/bin/kubeadm
COPY ./tokens.csv /etc/pki/tokens.csv
COPY ./daemon.json /etc/docker/
COPY ./resolv.conf.override /etc/
COPY ./.bashrc /root/
COPY ./motd /etc/motd
RUN chmod +x /usr/bin/systemctl

# Configuration finale
RUN mkdir -p /root/.kube && ln -s /etc/kubernetes/admin.conf /root/.kube/config && \
    echo 'source <(kubectl completion bash)' >>~/.bashrc && \
    kubectl completion bash >> /etc/bash_completion.d/kubectl && \
    rm -f /etc/machine-id

VOLUME ["/var/lib/kubelet"]

WORKDIR /root

CMD mount --make-shared / && \
    systemctl start docker && \
    systemctl start kubelet && \
    while true; do script -q -c "/bin/bash -l" /dev/null; done