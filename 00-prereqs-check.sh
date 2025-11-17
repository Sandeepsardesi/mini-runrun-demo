#!/usr/bin/env bash
set -euo pipefail
source ./env.sh || true
echo ">> prerequisites check"

command -v kubectl >/dev/null || { echo "kubectl not found"; exit 1; }
echo "kubectl OK"

if ! kubectl version --short >/dev/null 2>&1; then
  echo "kubectl can't access the cluster"; exit 1
fi
echo "kubectl can access cluster"

if ! command -v argocd >/dev/null 2>&1; then
  echo "warning: argocd cli not found. You can still use kubectl."
else
  echo "argocd cli found"
fi

if [[ ! -f "${SSH_KEY_PATH:-$HOME/.ssh/argocd-mini-runrun-2}" ]]; then
  echo "ERROR: expected SSH private key at ${SSH_KEY_PATH:-$HOME/.ssh/argocd-mini-runrun-2}"
  exit 1
fi
echo "SSH key present at $SSH_KEY_PATH"

echo "All checks passed."
