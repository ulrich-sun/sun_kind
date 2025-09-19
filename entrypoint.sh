#!/bin/bash
set -e

echo "[INFO] Lancement du conteneur Kubernetes Dev"

# Ici, tu pourrais démarrer dockerd en mode foreground si tu fais du DinD
# dockerd-entrypoint.sh &

exec "$@"
