#!/usr/bin/env bash
set -euo pipefail
source ./env.sh || true

echo ">> waiting for ArgoCD app '${ARGOCD_APP_NAME}' to be Synced and Healthy (timeout 180s)"
end=$((SECONDS+180))
while true; do
  status=$(kubectl -n "${ARGOCD_NS}" get application "${ARGOCD_APP_NAME}" -o jsonpath='{.status.sync.status}' 2>/dev/null || echo "Unknown")
  health=$(kubectl -n "${ARGOCD_NS}" get application "${ARGOCD_APP_NAME}" -o jsonpath='{.status.health.status}' 2>/dev/null || echo "Unknown")
  echo "status=${status} health=${health}"
  if [[ "$status" == "Synced" && "$health" == "Healthy" ]]; then
    echo "App is Synced & Healthy."
    break
  fi
  if (( SECONDS >= end )); then
    echo "Timed out waiting for app to be ready. Outputting application YAML:"
    kubectl -n "${ARGOCD_NS}" get application "${ARGOCD_APP_NAME}" -o yaml || true
    exit 1
  fi
  sleep 5
done

echo ">> listing resources in ${KUBE_NAMESPACE}"
kubectl -n "${KUBE_NAMESPACE}" get all --show-labels || true
