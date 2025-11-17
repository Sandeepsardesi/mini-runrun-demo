#!/usr/bin/env bash
set -euo pipefail
source ./env.sh || true

./00-prereqs-check.sh
./01-create-namespace-and-secret.sh
./02-restart-repo-server-and-refresh.sh
./03-wait-for-app-synced.sh
./04-verify-pods-ready.sh

echo "Done. To open ArgoCD UI run: ./05-portforward-argocd.sh (this will block the terminal)"
