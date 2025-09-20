#!/bin/bash
set -e

# Démarrer systemd (nécessaire pour kubelet lancé en tant que service)
exec /sbin/init