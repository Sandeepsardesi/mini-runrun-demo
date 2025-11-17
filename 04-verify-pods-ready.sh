#!/usr/bin/env bash
set -euo pipefail
source ./env.sh || true

echo ">> waiting for pods in ${KUBE_NAMESPACE} to be Ready (timeout 240s)"
kubectl -n "${KUBE_NAMESPACE}" get pods || true

end=$((SECONDS+240))
while true; do
  not_ready=$(kubectl -n "${KUBE_NAMESPACE}" get pods --no-headers 2>/dev/null | awk '$2 !~ /[0-9]+\/[0-9]+/ || $2 ~ /0\/[0-9]+/ {print $0}' || true)
  if [[ -z "${not_ready}" ]]; then
    echo "All pods show ready."
    kubectl -n "${KUBE_NAMESPACE}" get pods -o wide
    break
  fi
  if (( SECONDS >= end )); then
    echo "Timed out waiting for pods. Outputting pod list:"
    kubectl -n "${KUBE_NAMESPACE}" get pods -o wide
    exit 1
  fi
  echo "Waiting for pods to be Ready..."
  sleep 5
done
