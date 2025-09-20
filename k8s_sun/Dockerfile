FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV MINIKUBE_VERSION=v1.35.0
ENV CRICTL_VERSION=v1.31.0
ENV GO_VERSION=1.21.1

# Installation des paquets de base
RUN apt-get update && apt-get install -y \
    curl wget apt-transport-https ca-certificates gnupg lsb-release \
    git build-essential bash-completion socat conntrack && \
    rm -rf /var/lib/apt/lists/*

# Copier les scripts
WORKDIR /opt/scripts
COPY scripts/ .

# Rendre exécutables
RUN chmod +x *.sh

# Exécuter les installations
RUN ./install_docker.sh && \
    ./install_kubernetes.sh && \
    ./install_minikube.sh && \
    ./install_crictl.sh && \
    ./install_tools.sh

# Ajouter kubectl autocomplete et alias
RUN echo 'source <(kubectl completion bash)' >> ~/.bashrc && \
    echo 'alias k=kubectl' >> ~/.bashrc && \
    echo 'complete -F __start_kubectl k' >> ~/.bashrc

# Entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["bash"]
